import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/food_result_screen.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_utils/demo_utils.dart';

class DidiyieScanScreen extends StatefulWidget {
  const DidiyieScanScreen({Key? key}) : super(key: key);

  @override
  State<DidiyieScanScreen> createState() => _DidiyieScanScreenState();
}

class _DidiyieScanScreenState extends State<DidiyieScanScreen> with TickerProviderStateMixin {
  final FoodController _foodController = Get.find<FoodController>();
  
  // Demo mode indicator
  late bool _isDemoMode;
  
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  XFile? _capturedImage;
  bool _isCameraReady = false;
  
  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _scanLineController;
  late Animation<double> _pulseAnimation;
  
  // Scan process tracking
  bool _isScanning = false;
  String _scanStage = '';
  double _scanProgress = 0.0;
  
  // Recognition features tracking
  final Map<String, double> _detectedFeatures = {};
  String _topCategory = '';
  
  @override
  void initState() {
    super.initState();
    _initCamera();
    
    // Initialize demo mode from utility class
    _isDemoMode = DemoUtils.isDemoMode;
    
    // Set up animation controllers
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut)
    );
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller!.initialize();
    await _initializeControllerFuture;
    if (mounted) {
      setState(() {
        _isCameraReady = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _pulseController.dispose();
    _scanLineController.dispose();
    super.dispose();
  }
  
  // Start the food scan process with visual feedback
  Future<void> _startFoodScan() async {
    try {
      await _initializeControllerFuture;
      
      // Capture image
      if (mounted) {
        setState(() {
          _isScanning = true;
          _scanStage = 'Capturing...';
          _scanProgress = 0.1;
        });
      }
      
      final image = await _controller!.takePicture();
      if (mounted) {
        setState(() {
          _capturedImage = image;
        });
      }
      
      // Create worker variables to store the workers so we can dispose them later
      Worker? progressWorker;
      Worker? stepWorker;
      
      // Set up listeners to monitor real-time progress from the ML model
      // This will update our UI with actual processing stages
      progressWorker = ever(_foodController.recognitionProgress, (progress) {
        if (mounted) {
          setState(() {
            _scanProgress = progress;
          });
        }
      });
      
      stepWorker = ever(_foodController.currentProcessingStep, (step) {
        if (mounted) {
          setState(() {
            _scanStage = step;
            
            // Update feature indicators based on processing stage
            if (step.contains('feature')) {
              _detectedFeatures['color'] = 0.7;
            }
            if (step.contains('Analyzing')) {
              _detectedFeatures['texture'] = 0.8;
              _detectedFeatures['shape'] = 0.65;
            }
            if (step.contains('Identifying')) {
              _detectedFeatures['match'] = 0.9;
            }
          });
        }
      });
      
      // Check if we're in demo mode to cycle through demo foods
      if (DemoUtils.isDemoMode) {
        // Simulate the full recognition process for a better user experience
        await _simulateDemoRecognition(image.path);
        
        // Dispose of the workers
        progressWorker.dispose();
        stepWorker.dispose();
        
        // Navigate to results with the same path (the food will be from the demo cycle)
        if (mounted) {
          Get.to(() => FoodResultScreen(imagePath: image.path));
        }
      } else {
        // Normal mode: Start the actual ML food recognition process
        await _foodController.identifyFood(image.path);
        
        // Dispose of the workers to prevent memory leaks
        progressWorker.dispose();
        stepWorker.dispose();
        
        // After processing completes, navigate to results
        if (mounted) {
          Get.to(() => FoodResultScreen(imagePath: image.path));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
        Get.snackbar(
          'Error',
          'Could not analyze food: $e',
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
        );
      }
    }
  }
  
  // Simulate the recognition process for demo mode
  Future<void> _simulateDemoRecognition(String imagePath) async {
    // Get the next demo food in the cycle
    final demoFood = DemoUtils.getNextDemoFood();
    
    // Simulate the processing animation
    _foodController.recognitionProgress.value = 0.0;
    _foodController.currentProcessingStep.value = 'Starting analysis...';
    await Future.delayed(const Duration(milliseconds: 300));
    
    _foodController.recognitionProgress.value = 0.2;
    _foodController.currentProcessingStep.value = 'Analyzing image quality';
    await Future.delayed(const Duration(milliseconds: 400));
    
    _foodController.recognitionProgress.value = 0.4;
    _foodController.currentProcessingStep.value = 'Extracting visual features';
    await Future.delayed(const Duration(milliseconds: 350));
    
    _foodController.recognitionProgress.value = 0.6;
    _foodController.currentProcessingStep.value = 'Searching food database';
    await Future.delayed(const Duration(milliseconds: 400));
    
    _foodController.recognitionProgress.value = 0.8;
    _foodController.currentProcessingStep.value = 'Classifying Ghanaian food';
    await Future.delayed(const Duration(milliseconds: 300));
    
    _foodController.recognitionProgress.value = 1.0;
    _foodController.currentProcessingStep.value = 'Food identified: ${demoFood.name}';
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Directly expose the demo food to the food result screen
    // We don't need to add it to recent scans as the food result screen will handle that
    // We'll use a static variable to hold our demo food
    DemoUtils.lastDemoFood = demoFood;
  }
  
  // Simulate the ML processing stages with visual feedback
  Future<void> _simulateProcessingStages(String imagePath) async {
    try {
      // Step 1: Image preprocessing
      if (mounted) {
        setState(() {
          _scanStage = 'Preprocessing image...';
          _scanProgress = 0.2;
        });
      }
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Step 2: Feature extraction
      if (mounted) {
        setState(() {
          _scanStage = 'Extracting features...';
          _scanProgress = 0.4;
          _detectedFeatures['color'] = 0.7;
        });
      }
      await Future.delayed(const Duration(milliseconds: 600));
      
      // Step 3: Shape analysis
      if (mounted) {
        setState(() {
          _scanStage = 'Analyzing shape...';
          _scanProgress = 0.6;
          _detectedFeatures['shape'] = 0.65;
        });
      }
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Step 4: Texture analysis
      if (mounted) {
        setState(() {
          _scanStage = 'Analyzing texture...';
          _scanProgress = 0.8;
          _detectedFeatures['texture'] = 0.8;
        });
      }
      await Future.delayed(const Duration(milliseconds: 700));
      
      // Step 5: Classification
      if (mounted) {
        setState(() {
          _scanStage = 'Identifying food...';
          _scanProgress = 0.9;
          _topCategory = 'Ghanaian Dishes';
          _detectedFeatures['match'] = 0.9;
        });
      }
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Complete
      if (mounted) {
        setState(() {
          _scanStage = 'Analysis complete';
          _scanProgress = 1.0;
        });
      }
    } catch (e) {
      print('Error in simulation: $e');
    }
  }


  Widget _buildCameraPreview() {
    if (!_isCameraReady || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return Stack(
      children: [
        // Camera with rounded corners and shadow
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 18,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            ),
          ),
        ),
        
        // Ghanaian-inspired accent bar at the top
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFDC143C), // Ghana red
                  Color(0xFFFFD600), // Ghana yellow
                  Color(0xFF006B3F), // Ghana green
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        
        // Animated scan line (when scanning)
        if (_isScanning)
          AnimatedBuilder(
            animation: _scanLineController,
            builder: (context, child) {
              return Positioned(
                top: 50 + (_scanLineController.value * 220),
                left: 70,
                right: 70,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        didiyieColor.yellow.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              );
            },
          ),
        
        // Center overlay: semi-transparent rounded rectangle with pulse animation when scanning
        Center(
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _isScanning ? _pulseAnimation.value : 1.0,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _isScanning 
                          ? didiyieColor.appcolor.withOpacity(0.8)
                          : didiyieColor.yellow,
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isScanning ? Icons.restaurant : Icons.shopping_basket_outlined, 
                          size: 48, 
                          color: Colors.white70
                        ),
                        if (_isScanning && _topCategory.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              _topCategory,
                              style: dmmedium.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        ),
        
        // Detected features indicators (only show when scanning)
        if (_isScanning && _detectedFeatures.isNotEmpty)
          ..._buildFeatureIndicators(),
        
        // Bottom processing status display (only when scanning)
        if (_isScanning)
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: const AlwaysStoppedAnimation<Color>(didiyieColor.yellow),
                          value: _scanProgress,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _scanStage,
                        style: mulishmedium.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _scanProgress,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(didiyieColor.appcolor),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
  
  // Build the feature indicator dots on the camera view
  List<Widget> _buildFeatureIndicators() {
    final indicators = <Widget>[];
    final positions = [
      const Offset(0.25, 0.3), // Top left
      const Offset(0.75, 0.3), // Top right
      const Offset(0.3, 0.6),  // Bottom left
      const Offset(0.7, 0.6),  // Bottom right
    ];
    
    int i = 0;
    for (final entry in _detectedFeatures.entries) {
      if (i >= positions.length) break;
      
      final position = positions[i];
      final label = entry.key.toUpperCase();
      final value = entry.value;
      
      indicators.add(
        Positioned(
          left: position.dx * MediaQuery.of(context).size.width,
          top: position.dy * MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: didiyieColor.yellow, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: mulishbold.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 40,
                  height: 4,
                  child: LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(didiyieColor.yellow),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      i++;
    }
    
    return indicators;
  }

  Widget _buildCaptureView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.file(
            File(_capturedImage!.path),
            fit: BoxFit.cover,
          ),
        ),
        
        // Processing overlay
        if (_isScanning)
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: const AlwaysStoppedAnimation<Color>(didiyieColor.yellow),
                      value: _scanProgress,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _scanStage,
                    style: dmmedium.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_scanProgress > 0.5)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: didiyieColor.appcolor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _topCategory.isNotEmpty ? _topCategory : 'Analyzing...',
                        style: mulishbold.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text('Smart Food Scan', style: mulishbold.copyWith(fontSize: 20)),
          ],
        ),
        centerTitle: true,
        backgroundColor: didiyieColor.appcolor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: _capturedImage == null
                    ? _buildCameraPreview()
                    : _buildCaptureView(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: _capturedImage == null
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: _isScanning ? null : _startFoodScan,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: _isScanning ? Colors.grey[300] : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _isScanning 
                                      ? Colors.grey[400]! 
                                      : didiyieColor.yellow,
                                  width: 5,
                                ),
                                boxShadow: _isScanning 
                                    ? [] 
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.18),
                                          blurRadius: 8,
                                        ),
                                      ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: _isScanning 
                                    ? Colors.grey[600] 
                                    : const Color(0xFF4A6FD1),
                                size: 40,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.emoji_objects, color: Color(0xFFDC143C)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _isScanning
                                      ? 'Our AI is analyzing your food using color, texture, and shape recognition'
                                      : 'Didi yie! Snap a photo of your Ghanaian dish for instant nutritional info and cultural insights.',
                                  textAlign: TextAlign.center,
                                  style: mulishmedium.copyWith(
                                    fontSize: 16,
                                    color: didiyieColor.appcolor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
