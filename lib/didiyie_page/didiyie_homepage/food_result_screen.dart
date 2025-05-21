import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_models/food_model.dart';
import 'package:didiyie/didiyie_utils/demo_utils.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_homepage.dart';

class FoodResultScreen extends StatefulWidget {
  final String imagePath;
  
  const FoodResultScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<FoodResultScreen> createState() => _FoodResultScreenState();
}

class _FoodResultScreenState extends State<FoodResultScreen> with SingleTickerProviderStateMixin {
  late FoodController _foodController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = true;
  Food? _identifiedFood;
  
  @override
  void initState() {
    super.initState();
    _foodController = Get.find<FoodController>();
    
    // Animation setup
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn)
    );
    
    _identifyFood();
  }
  
  Future<void> _identifyFood() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate network delay for food identification
    await Future.delayed(const Duration(seconds: 1));
    
    // Check if we're in demo mode and have a demo food available
    if (DemoUtils.isDemoMode && DemoUtils.lastDemoFood != null) {
      // Use the demo food that was generated in the scan screen
      _identifiedFood = DemoUtils.lastDemoFood;
      // Clear the static variable to avoid confusion in future scans
      DemoUtils.lastDemoFood = null;
    } else {
      // Normal mode: use the food controller to identify the food
      _identifiedFood = await _foodController.identifyFood(widget.imagePath);
    }
    
    setState(() {
      _isLoading = false;
    });
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: didiyieColor.appcolor,
        title: Text(
          'Food Details',
          style: mulishbold.copyWith(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () => Get.offAll(() => const didiyieHomePage()),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: () {
              // Share functionality
              Get.snackbar(
                'Share',
                'Sharing this nutritional information',
                backgroundColor: Colors.green.withOpacity(0.1),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? _buildLoadingView()
          : _buildResultView(width, height),
      floatingActionButton: !_isLoading
          ? FloatingActionButton.extended(
              onPressed: () {
                // Save this food to favorites
                _foodController.saveToFavorites(_identifiedFood!);
                Get.snackbar(
                  'Saved',
                  '${_identifiedFood!.name} added to favorites',
                  backgroundColor: Colors.green.withOpacity(0.1),
                  colorText: Colors.green[700],
                );
              },
              icon: const Icon(Icons.favorite_border),
              label: const Text('Save'),
              backgroundColor: didiyieColor.appcolor,
            )
          : null,
      bottomNavigationBar: !_isLoading
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton.icon(
                  onPressed: () => Get.offAll(() => const didiyieHomePage()),
                  icon: const Icon(Icons.home),
                  label: const Text('Return to Home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: didiyieColor.yellow,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ghana flag colors shimmer animation
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFDC143C), // Ghana red
                  const Color(0xFFFFD600), // Ghana yellow
                  const Color(0xFF006B3F), // Ghana green
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Identifying Food',
            style: dmmedium.copyWith(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Analyzing Ghanaian dish...',
            style: mulishregular.copyWith(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResultView(double width, double height) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image at the top
            SizedBox(
              width: double.infinity,
              height: height / 3.5,
              child: Container(
                decoration: BoxDecoration(
                  color: didiyieColor.appcolor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage(_identifiedFood!.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    // Confidence badge
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${(_identifiedFood!.confidence * 100).toStringAsFixed(0)}% Match',
                              style: mulishbold.copyWith(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Food title and basic details
            Padding(
              padding: EdgeInsets.all(width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _identifiedFood!.name,
                              style: dmmedium.copyWith(
                                fontSize: 24,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _identifiedFood!.category,
                              style: mulishregular.copyWith(
                                fontSize: 16,
                                color: didiyieColor.appcolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Nutrition grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildNutritionCard(
                          title: 'Calories',
                          value: _identifiedFood!.calories.toString(),
                          unit: 'kcal',
                          icon: Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildNutritionCard(
                          title: 'Protein',
                          value: _identifiedFood!.protein.toStringAsFixed(1),
                          unit: 'g',
                          icon: Icons.fitness_center,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildNutritionCard(
                          title: 'Carbs',
                          value: _identifiedFood!.carbs.toStringAsFixed(1),
                          unit: 'g',
                          icon: Icons.grain,
                          color: didiyieColor.appcolor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildNutritionCard(
                          title: 'Fat',
                          value: _identifiedFood!.fat.toStringAsFixed(1),
                          unit: 'g',
                          icon: Icons.opacity,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Description
                  Text(
                    'Description',
                    style: dmmedium.copyWith(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _identifiedFood!.description,
                    style: mulishregular.copyWith(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Cultural context
                  Text(
                    'Traditional Ghanaian Context',
                    style: dmmedium.copyWith(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFFD600).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.auto_stories,
                              color: Color(0xFF006B3F),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Cultural Significance',
                              style: mulishsemiBold.copyWith(
                                fontSize: 16,
                                color: const Color(0xFF006B3F),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _identifiedFood!.culturalContext,
                          style: mulishregular.copyWith(
                            fontSize: 14,
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Health benefits
                  Text(
                    'Health Benefits',
                    style: dmmedium.copyWith(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: _identifiedFood!.healthBenefits.map((benefit) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: didiyieColor.appcolor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: didiyieColor.appcolor,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                benefit,
                                style: mulishregular.copyWith(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Similar foods
                  Text(
                    'Similar Foods',
                    style: dmmedium.copyWith(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _identifiedFood!.similarFoods.map((food) {
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.restaurant,
                                color: didiyieColor.appcolor,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                food,
                                textAlign: TextAlign.center,
                                style: mulishmedium.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(height: 80), // Space for FAB
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNutritionCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: mulishsemiBold.copyWith(
                  fontSize: 16,
                  color: color,
                ),
              ),
              Icon(
                icon,
                color: color,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: dmmedium.copyWith(
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  unit,
                  style: mulishregular.copyWith(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
