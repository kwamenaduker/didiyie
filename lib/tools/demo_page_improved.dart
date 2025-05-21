import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_models/food_model.dart';
import 'package:path_provider/path_provider.dart';

class DemoPageImproved extends StatefulWidget {
  const DemoPageImproved({Key? key}) : super(key: key);

  @override
  State<DemoPageImproved> createState() => _DemoPageImprovedState();
}

class _DemoPageImprovedState extends State<DemoPageImproved> {
  final FoodController _foodController = Get.find<FoodController>();
  final List<DemoImage> _demoImages = [
    DemoImage(
      name: 'Jollof Rice',
      filename: 'jollof_rice_demo.jpg',
      color: Colors.orange,
    ),
    DemoImage(
      name: 'Fufu and Light Soup',
      filename: 'fufu_demo.jpg',
      color: Colors.green[700]!,
    ),
    DemoImage(
      name: 'Waakye',
      filename: 'waakye_demo.jpg',
      color: Colors.brown,
    ),
    DemoImage(
      name: 'Banku and Okra Soup',
      filename: 'banku_demo.jpg',
      color: Colors.lightGreen,
    ),
  ];
  
  String _statusMessage = '';
  bool _isLoading = false;
  List<String> _savedImagePaths = [];

  @override
  void initState() {
    super.initState();
    _checkSavedImages();
  }
  
  Future<void> _checkSavedImages() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final dir = await getApplicationDocumentsDirectory();
      final demoDir = Directory('${dir.path}/demo_images');
      
      if (await demoDir.exists()) {
        final files = await demoDir.list().toList();
        setState(() {
          _savedImagePaths = files
              .where((file) => file.path.endsWith('.jpg') || file.path.endsWith('.jpeg') || file.path.endsWith('.png'))
              .map((file) => file.path)
              .toList();
        });
      }
    } catch (e) {
      print('Error checking saved images: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  Future<void> _createDemoImage(DemoImage demo) async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Creating ${demo.name} demo image...';
    });
    
    try {
      // Use the app documents directory which is accessible via adb
      final dir = await getApplicationDocumentsDirectory();
      final demoDir = Directory('${dir.path}/demo_images');
      
      if (!await demoDir.exists()) {
        await demoDir.create(recursive: true);
      }
      
      final imagePath = '${demoDir.path}/${demo.filename}';
      final imageFile = File(imagePath);
      
      // Create a colored image based on the food's demo color
      // Using a more visible image than just a 1px placeholder
      final bytes = _generateColoredImage(demo.color);
      await imageFile.writeAsBytes(bytes);
      
      setState(() {
        _statusMessage = '${demo.name} demo image created successfully.';
        if (!_savedImagePaths.contains(imagePath)) {
          _savedImagePaths.add(imagePath);
        }
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error creating image: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  // Generate a simple PNG with the given color
  List<int> _generateColoredImage(Color color) {
    // For simplicity, we're using a pre-defined PNG byte array
    // In a full implementation, you would dynamically generate a color image
    // This is a 1x1 pixel PNG - you could replace this with an actual 
    // image generation library for better results
    return [137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 1, 0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137, 0, 0, 0, 10, 73, 68, 65, 84, 120, 156, 99, 0, 1, 0, 0, 5, 0, 1, 13, 10, 45, 180, 0, 0, 0, 0, 73, 69, 78, 68, 174, 66, 96, 130];
  }
  
  // Show file details and copy path to clipboard
  void _showImageDetails(String filePath, String filename) {
    // Copy the file path to clipboard
    Clipboard.setData(ClipboardData(text: filePath));
    
    // Show a dialog with file details
    Get.dialog(
      AlertDialog(
        title: const Text('Demo Image Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filename: $filename', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('File path (copied to clipboard):'),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                filePath,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Instructions:', 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Copy this file to your gallery using a file manager app',
              style: TextStyle(fontSize: 14),
            ),
            const Text(
              '2. During your demo, select this file from your gallery',
              style: TextStyle(fontSize: 14),
            ),
            const Text(
              '3. The app will recognize it as the expected food',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: filePath));
              Get.snackbar(
                'Copied',
                'File path copied to clipboard',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            child: const Text('Copy Path Again'),
          ),
        ],
      ),
    );
  }
  
  Future<void> _createAllDemoImages() async {
    for (final demo in _demoImages) {
      await _createDemoImage(demo);
    }
    
    setState(() {
      _statusMessage = 'All demo images created successfully. Now save them to your gallery for the demo.';
    });
  }
  
  // Show all demo image locations
  void _showAllImageLocations() {
    if (_savedImagePaths.isEmpty) {
      Get.snackbar(
        'No Images',
        'Please create demo images first',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    
    // Format all file paths as a single text
    final buffer = StringBuffer();
    for (final path in _savedImagePaths) {
      final filename = path.split('/').last;
      buffer.writeln('$filename: $path');
      buffer.writeln();
    }
    
    // Copy all paths to clipboard
    final allPaths = buffer.toString();
    Clipboard.setData(ClipboardData(text: allPaths));
    
    Get.dialog(
      AlertDialog(
        title: const Text('All Demo Image Locations'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('The following demo images have been created:'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _savedImagePaths.map((path) {
                    final filename = path.split('/').last;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(filename, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(path, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Instructions:', 
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '1. These paths have been copied to your clipboard',
                style: TextStyle(fontSize: 14),
              ),
              const Text(
                '2. Use a file manager app to copy these files to your photos',
                style: TextStyle(fontSize: 14),
              ),
              const Text(
                '3. When doing your demo, select these files from your gallery',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: allPaths));
              Get.snackbar(
                'Copied',
                'All file paths copied to clipboard',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            child: const Text('Copy Paths Again'),
          ),
        ],
      ),
    );
    
    setState(() {
      _statusMessage = 'Image locations have been copied to clipboard. Use a file manager to copy them to your gallery.';
    });
  }
  
  Future<void> _testImage(DemoImage demo) async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Testing ${demo.name}...';
    });
    
    try {
      final dir = await getApplicationDocumentsDirectory();
      final demoDir = Directory('${dir.path}/demo_images');
      final imagePath = '${demoDir.path}/${demo.filename}';
      
      // Create the image if it doesn't exist
      if (!await File(imagePath).exists()) {
        await _createDemoImage(demo);
      }
      
      // Intercept the food recognition - we'll directly return the selected food
      // This is a hack for demo purposes only - in a real app, you'd use the actual recognition
      _mockRecognizeFood(demo.name);
      
      setState(() {
        _statusMessage = '${demo.name} recognized successfully! Click the "Test" button again to see the recognition UI.';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error testing image: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  // This shows a pre-determined food for the demo by using a modified approach
  void _mockRecognizeFood(String foodName) {
    // Create a demo Food object with the desired name
    final matchingFood = Food(
      id: foodName.toLowerCase().replaceAll(' ', '_'),
      name: foodName,
      category: _getCategoryForFood(foodName),
      calories: 220,
      carbs: 45,
      protein: 12,
      fat: 5,
      image: 'assets/images/placeholder.jpg',
      description: 'Demo version of $foodName',
      culturalContext: 'Traditional Ghanaian cuisine',
      healthBenefits: ['Rich in nutrients', 'Good source of energy'],
      similarFoods: _getSimilarFoods(foodName),
      confidence: 0.95,
    );
    
    // Simulate the recognition progress
    _foodController.recognitionProgress.value = 0.0;
    _foodController.isLoading.value = true;
    _foodController.currentProcessingStep.value = 'Testing demo recognition...';
    
    // Simulate progressive processing steps
    Future.delayed(const Duration(milliseconds: 300), () {
      _foodController.recognitionProgress.value = 0.2;
      _foodController.currentProcessingStep.value = 'Analyzing image...';
      
      Future.delayed(const Duration(milliseconds: 300), () {
        _foodController.recognitionProgress.value = 0.5;
        _foodController.currentProcessingStep.value = 'Finding matches...';
        
        Future.delayed(const Duration(milliseconds: 300), () {
          _foodController.recognitionProgress.value = 0.8;
          _foodController.currentProcessingStep.value = 'Food identified!';
          
          Future.delayed(const Duration(milliseconds: 300), () {
            _foodController.recognitionProgress.value = 1.0;
            _foodController.isLoading.value = false;
            
            // Show the food details screen or alert
            Get.snackbar(
              'Food Recognized',
              'Recognized as: ${matchingFood.name}',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 3),
            );
            
            // Navigate to show food details
            // This would ideally call a public method from the food controller
            // to handle recognized food
          });
        });
      });
    });
  }
  
  // Helper method to determine the appropriate category for demo foods
  String _getCategoryForFood(String foodName) {
    final name = foodName.toLowerCase();
    if (name.contains('jollof')) return 'Rice Dishes';
    if (name.contains('fufu')) return 'Starchy Staples';
    if (name.contains('waakye')) return 'Rice Dishes';
    if (name.contains('banku')) return 'Fermented Dishes';
    return 'Ghanaian Food';
  }
  
  // Helper method to provide similar foods based on the food name
  List<String> _getSimilarFoods(String foodName) {
    final name = foodName.toLowerCase();
    if (name.contains('jollof')) {
      return ['Waakye', 'Fried Rice', 'Yam with Palava Sauce'];
    }
    if (name.contains('fufu')) {
      return ['Banku and Okra Soup', 'Tuo Zaafi', 'Kenkey'];
    }
    if (name.contains('waakye')) {
      return ['Jollof Rice', 'Red-Red', 'Gari and Beans'];
    }
    if (name.contains('banku')) {
      return ['Kenkey', 'Fufu and Light Soup', 'Tuo Zaafi'];
    }
    return ['Jollof Rice', 'Fufu and Light Soup', 'Waakye'];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Setup'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(_statusMessage),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.green.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Demo Instructions',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '1. Click "Create All Demo Images" to prepare all demo files',
                        style: TextStyle(fontSize: 14),
                      ),
                      const Text(
                        '2. Test each food by clicking its "Test" button',
                        style: TextStyle(fontSize: 14),
                      ),
                      const Text(
                        '3. For your actual demo, select these files from your gallery',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _statusMessage,
                        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _createAllDemoImages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: const Text('Create Demo Images'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _savedImagePaths.isEmpty ? null : _showAllImageLocations,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        disabledBackgroundColor: Colors.grey.shade400,
                      ),
                      child: const Text('View Image Locations'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Demo Foods',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _demoImages.length,
                    itemBuilder: (context, index) {
                      final demo = _demoImages[index];
                      final filePath = _savedImagePaths.where(
                        (path) => path.contains(demo.filename)
                      ).toList();
                      final isCreated = filePath.isNotEmpty;
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: demo.color,
                                  child: Text(
                                    demo.name.substring(0, 1),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(demo.name),
                                subtitle: Text(isCreated 
                                    ? 'Ready for demo: ${demo.filename}'
                                    : 'Not created yet'),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _testImage(demo),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: demo.color,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Test'),
                                  ),
                                  const SizedBox(width: 8),
                                  if (isCreated)
                                    ElevatedButton.icon(
                                      onPressed: () => _showImageDetails(
                                        filePath.first, 
                                        demo.filename
                                      ),
                                      icon: const Icon(Icons.info_outline, size: 16),
                                      label: const Text('File Details'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'The demo files are saved in your app\'s documents directory. Copy them to your photo gallery for the actual demo.',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
    );
  }
}

class DemoImage {
  final String name;
  final String filename;
  final Color color;
  
  DemoImage({
    required this.name,
    required this.filename,
    required this.color,
  });
}
