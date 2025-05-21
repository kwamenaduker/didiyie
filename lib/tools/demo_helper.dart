import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_models/food_model.dart';
import 'package:path_provider/path_provider.dart';

class DemoHelper extends StatefulWidget {
  const DemoHelper({Key? key}) : super(key: key);

  @override
  State<DemoHelper> createState() => _DemoHelperState();
}

class _DemoHelperState extends State<DemoHelper> {
  final FoodController _foodController = Get.find<FoodController>();
  final Map<String, String> _testResults = {};
  bool _isLoading = false;
  String _selectedFood = '';
  String _testImagePath = '';
  
  final List<String> _testFileNames = [
    'jollof_rice_demo.jpg',
    'fufu_demo.jpg',
    'waakye_demo.jpg',
    'kelewele_demo.jpg',
    'banku_demo.jpg',
    'red_red_demo.jpg',
    'kenkey_demo.jpg',
    'yam_palava_demo.jpg',
    'ampesi_demo.jpg',
    'koko_koose_demo.jpg',
  ];
  
  @override
  void initState() {
    super.initState();
    _createTestImage();
  }
  
  Future<void> _createTestImage() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final testFile = File('${tempDir.path}/test_placeholder.jpg');
      
      if (!testFile.existsSync()) {
        // Create a simple placeholder image (1x1 pixel)
        final bytes = [137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 1, 0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137, 0, 0, 0, 10, 73, 68, 65, 84, 120, 156, 99, 0, 1, 0, 0, 5, 0, 1, 13, 10, 45, 180, 0, 0, 0, 0, 73, 69, 78, 68, 174, 66, 96, 130];
        await testFile.writeAsBytes(bytes);
      }
      
      setState(() {
        _testImagePath = testFile.path;
      });
    } catch (e) {
      print('Error creating test image: $e');
    }
  }
  
  Future<void> _testFileName(String fileName) async {
    if (_testImagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Test image not ready yet. Please wait.')),
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      final tempDir = await getTemporaryDirectory();
      final newPath = '${tempDir.path}/$fileName';
      
      // Copy the test placeholder to the new path
      await File(_testImagePath).copy(newPath);
      
      // Run the food recognition on this file
      final matchingFood = await _foodController.identifyFood(newPath);
      
      setState(() {
        _testResults[fileName] = matchingFood.name;
        _selectedFood = matchingFood.name;
      });
      
      // Delete the copied file
      await File(newPath).delete();
    } catch (e) {
      print('Error testing filename: $e');
      setState(() {
        _testResults[fileName] = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  Future<void> _runAllTests() async {
    for (final fileName in _testFileNames) {
      await _testFileName(fileName);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Helper'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _runAllTests,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Selected food: $_selectedFood',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _testFileNames.length,
                    itemBuilder: (context, index) {
                      final fileName = _testFileNames[index];
                      final result = _testResults[fileName] ?? 'Not tested';
                      
                      return ListTile(
                        title: Text(fileName),
                        subtitle: Text('Recognized as: $result'),
                        trailing: IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () => _testFileName(fileName),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
