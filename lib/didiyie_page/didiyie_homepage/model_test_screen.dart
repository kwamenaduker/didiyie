import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/training_data_collection_screen.dart';

/// A utility screen to test and monitor ML model integration
class ModelTestScreen extends StatefulWidget {
  const ModelTestScreen({Key? key}) : super(key: key);

  @override
  State<ModelTestScreen> createState() => _ModelTestScreenState();
}

class _ModelTestScreenState extends State<ModelTestScreen> {
  final FoodController _foodController = Get.find<FoodController>();
  bool _isLoading = false;
  String _status = "Ready to test";
  String _modelInfo = "No model loaded";
  List<String> _logMessages = [];
  
  void _log(String message) {
    setState(() {
      _logMessages.add("[${DateTime.now().toString().split('.').first}] $message");
      if (_logMessages.length > 100) {
        _logMessages.removeAt(0);
      }
    });
  }
  
  Future<void> _testModelLoading() async {
    setState(() {
      _isLoading = true;
      _status = "Testing model loading...";
    });
    
    _log("Starting model loading test");
    
    try {
      // Listen for progress updates
      final subscription = _foodController.currentProcessingStep.listen((step) {
        _log("Step: $step");
      });
      
      final result = await _foodController.testModelLoading();
      
      setState(() {
        _status = result ? "Test completed successfully" : "Test failed";
        _modelInfo = result 
            ? "Model loaded successfully. Labels found: ${_foodController.isModelLoaded.value}"
            : "Model loading failed";
        _isLoading = false;
      });
      
      _log(_status);
      subscription.cancel();
    } catch (e) {
      setState(() {
        _status = "Error: $e";
        _isLoading = false;
      });
      _log("Error: $e");
    }
  }
  
  Future<void> _collectModelStats() async {
    setState(() {
      _isLoading = true;
      _status = "Collecting model statistics...";
    });
    
    _log("Collecting model statistics");
    
    try {
      final stats = await _foodController.getTrainingDataStats();
      final totalImages = stats.values.fold<int>(0, (sum, count) => sum + count);
      
      setState(() {
        _status = "Statistics collected";
        _modelInfo = "Total training images: $totalImages\n"
            "Categories with data: ${stats.length}\n"
            "Details: ${stats.toString()}";
        _isLoading = false;
      });
      
      _log(_status);
      stats.forEach((food, count) {
        _log("$food: $count images");
      });
    } catch (e) {
      setState(() {
        _status = "Error: $e";
        _isLoading = false;
      });
      _log("Error: $e");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ML Model Tester', style: mulishbold.copyWith(fontSize: 20)),
        backgroundColor: didiyieColor.appcolor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status', style: dmmedium.copyWith(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text(_status, style: mulishregular.copyWith(fontSize: 16)),
                      const SizedBox(height: 16),
                      Text('Model Info', style: dmmedium.copyWith(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text(_modelInfo, style: mulishregular.copyWith(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : _testModelLoading,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: didiyieColor.appcolor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: Text('Test Model Loading', 
                      style: mulishsemiBold.copyWith(fontSize: 14),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _collectModelStats,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: didiyieColor.yellow,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: Text('Check Training Data', 
                      style: mulishsemiBold.copyWith(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Training data collection button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => const TrainingDataCollectionScreen());
                  },
                  icon: const Icon(Icons.add_photo_alternate),
                  label: Text(
                    'Collect Training Data',
                    style: mulishsemiBold.copyWith(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Log section
              Text('Log', style: dmmedium.copyWith(fontSize: 18)),
              const SizedBox(height: 8),
              
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ListView.builder(
                    itemCount: _logMessages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          _logMessages[index],
                          style: mulishregular.copyWith(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
