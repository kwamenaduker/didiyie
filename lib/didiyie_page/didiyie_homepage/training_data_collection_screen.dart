import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';

class TrainingDataCollectionScreen extends StatefulWidget {
  const TrainingDataCollectionScreen({Key? key}) : super(key: key);

  @override
  State<TrainingDataCollectionScreen> createState() => _TrainingDataCollectionScreenState();
}

class _TrainingDataCollectionScreenState extends State<TrainingDataCollectionScreen> {
  final FoodController _foodController = Get.find<FoodController>();
  final ImagePicker _picker = ImagePicker();
  
  String? _selectedCategory;
  String? _imagePath;
  bool _isProcessing = false;
  Map<String, int> _trainingStats = {};
  
  @override
  void initState() {
    super.initState();
    _loadTrainingStats();
  }
  
  Future<void> _loadTrainingStats() async {
    setState(() {
      _isProcessing = true;
    });
    
    final stats = await _foodController.getTrainingDataStats();
    
    setState(() {
      _trainingStats = stats;
      _isProcessing = false;
    });
  }
  
  Future<void> _captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }
  
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }
  
  Future<void> _saveTrainingImage() async {
    if (_imagePath == null || _selectedCategory == null) {
      Get.snackbar(
        'Error',
        'Please select both an image and a food category',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }
    
    setState(() {
      _isProcessing = true;
    });
    
    final success = await _foodController.saveImageForTraining(_imagePath!, _selectedCategory!);
    
    if (success) {
      Get.snackbar(
        'Success',
        'Image saved for training',
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
      
      setState(() {
        _imagePath = null;
      });
      
      await _loadTrainingStats();
    } else {
      Get.snackbar(
        'Error',
        'Failed to save image',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
    
    setState(() {
      _isProcessing = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    
    final categories = _foodController.getAllCategories();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Training Data Collection',
          style: mulishsemiBold.copyWith(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTrainingStats,
          ),
        ],
      ),
      body: _isProcessing
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info card
                  Container(
                    padding: EdgeInsets.all(width / 30),
                    decoration: BoxDecoration(
                      color: didiyieColor.appcolor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Help Improve Food Recognition',
                          style: mulishsemiBold.copyWith(
                            fontSize: 18,
                            color: didiyieColor.appcolor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Contribute to our database by adding images of Ghanaian foods. '
                          'This will help the app better recognize local dishes.',
                          style: mulishregular.copyWith(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: height / 30),
                  
                  // Current stats
                  Text(
                    'Current Training Data',
                    style: mulishsemiBold.copyWith(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Stats cards
                  _trainingStats.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'No training data collected yet',
                              style: mulishregular.copyWith(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _trainingStats.length,
                          itemBuilder: (context, index) {
                            final entry = _trainingStats.entries.elementAt(index);
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    entry.key,
                                    style: mulishsemiBold.copyWith(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.photo_library,
                                        color: didiyieColor.appcolor,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${entry.value} images',
                                        style: mulishregular.copyWith(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  
                  SizedBox(height: height / 30),
                  
                  // Add new training data
                  Text(
                    'Add New Training Data',
                    style: mulishsemiBold.copyWith(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Category selection
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Food Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.category),
                    ),
                    value: _selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  
                  SizedBox(height: height / 40),
                  
                  // Image selection
                  Container(
                    height: width * 0.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: _imagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_imagePath!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No image selected',
                                style: mulishregular.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                  ),
                  
                  SizedBox(height: height / 40),
                  
                  // Image selection buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _captureImage,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Take Photo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: didiyieColor.appcolor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Gallery'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: height / 30),
                  
                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _imagePath != null && _selectedCategory != null
                          ? _saveTrainingImage
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: didiyieColor.appcolor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBackgroundColor: Colors.grey[300],
                      ),
                      child: Text(
                        'Save Training Image',
                        style: mulishsemiBold.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
