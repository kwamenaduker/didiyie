import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_models/food_model.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/food_result_screen.dart';

class NutritionDashboard extends StatefulWidget {
  const NutritionDashboard({Key? key}) : super(key: key);

  @override
  State<NutritionDashboard> createState() => _NutritionDashboardState();
}

class _NutritionDashboardState extends State<NutritionDashboard> {
  final FoodController _foodController = Get.put(FoodController());
  
  // Calculated nutritional values
  int _dailyCalories = 0;
  double _dailyProtein = 0.0;
  double _dailyCarbs = 0.0;
  double _dailyFat = 0.0;
  
  @override
  void initState() {
    super.initState();
    _calculateDailyNutrition();
  }
  
  void _calculateDailyNutrition() {
    // In a real app, this would calculate based on user's consumed foods
    // For demo, we'll calculate based on recent scans (simulating today's intake)
    final recentScans = _foodController.recentlyScannedFoods;
    
    // Take the most recent 3 scans as "today's meals"
    final todaysFoods = recentScans.take(3).toList();
    
    if (todaysFoods.isNotEmpty) {
      // Reset values first
      _dailyCalories = 0;
      _dailyProtein = 0.0;
      _dailyCarbs = 0.0;
      _dailyFat = 0.0;
      
      for (final food in todaysFoods) {
        // Use explicit casting to int for calories
        _dailyCalories += food.calories.toInt();
        _dailyProtein += food.protein;
        _dailyCarbs += food.carbs;
        _dailyFat += food.fat;
      }
    } else {
      // Default values if no scans yet
      _dailyCalories = 0;
      _dailyProtein = 0.0;
      _dailyCarbs = 0.0;
      _dailyFat = 0.0;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final recentScans = _foodController.recentlyScannedFoods;
        final allFoods = _foodController.allFoods;
        
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height / 40),
                  
                  // Daily Nutrition Summary
                  _buildDailyNutritionCard(width, height),
                  
                  SizedBox(height: height / 30),
                  
                  // Recent Scans Section
                  Text(
                    'Recent Food Scans',
                    style: dmmedium.copyWith(fontSize: 22, color: Colors.black87),
                  ),
                  SizedBox(height: height / 60),
                  
                  if (recentScans.isEmpty)
                    _buildEmptyStateCard(width, height)
                  else
                    _buildRecentScansSection(recentScans, width, height),
                  
                  SizedBox(height: height / 30),
                  
                  // Recommended Foods Section
                  Text(
                    'Recommended Ghanaian Foods',
                    style: dmmedium.copyWith(fontSize: 22, color: Colors.black87),
                  ),
                  SizedBox(height: height / 60),
                  
                  _buildRecommendedFoodsSection(allFoods, width, height),
                  
                  // Nutritional Tips
                  SizedBox(height: height / 30),
                  Text(
                    'Nutritional Tips',
                    style: dmmedium.copyWith(fontSize: 22, color: Colors.black87),
                  ),
                  SizedBox(height: height / 60),
                  
                  _buildNutritionalTipsCard(width, height),
                  
                  SizedBox(height: height / 20),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
  
  Widget _buildDailyNutritionCard(double width, double height) {
    // Calculate progress (simulated for demo)
    final calorieProgress = _dailyCalories / 2000; // 2000 calories daily target
    final proteinProgress = _dailyProtein / 50;  // 50g protein daily target
    final carbsProgress = _dailyCarbs / 300;     // 300g carbs daily target
    final fatProgress = _dailyFat / 65;          // 65g fat daily target
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF006B3F), // Ghana green
            const Color(0xFF006B3F).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pie_chart, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Text(
                'Today\'s Nutrition',
                style: mulishbold.copyWith(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: height / 60),
          
          // Calorie and nutrient progress
          Row(
            children: [
              _buildNutrientProgress(
                'Calories', 
                _dailyCalories.toString(), 
                'kcal',
                calorieProgress, 
                width, 
                const Color(0xFFFFD600), // Ghana yellow
              ),
              SizedBox(width: width / 30),
              _buildNutrientProgress(
                'Protein', 
                _dailyProtein.toStringAsFixed(1), 
                'g',
                proteinProgress, 
                width, 
                Colors.white,
              ),
            ],
          ),
          SizedBox(height: height / 60),
          
          Row(
            children: [
              _buildNutrientProgress(
                'Carbs', 
                _dailyCarbs.toStringAsFixed(1), 
                'g',
                carbsProgress, 
                width, 
                Colors.white70,
              ),
              SizedBox(width: width / 30),
              _buildNutrientProgress(
                'Fat', 
                _dailyFat.toStringAsFixed(1), 
                'g',
                fatProgress, 
                width, 
                const Color(0xFFDC143C), // Ghana red
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildNutrientProgress(
    String label, 
    String value, 
    String unit,
    double progress, 
    double width, 
    Color color,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: mulishmedium.copyWith(fontSize: 14, color: Colors.white.withOpacity(0.8)),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: dmmedium.copyWith(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: mulishregular.copyWith(fontSize: 14, color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.white.withOpacity(0.2),
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyStateCard(double width, double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width / 30),
      margin: EdgeInsets.symmetric(vertical: height / 80),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt_outlined, size: 48, color: didiyieColor.appcolor),
          SizedBox(height: height / 80),
          Text(
            'No food scans yet',
            style: mulishbold.copyWith(fontSize: 18, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height / 120),
          Text(
            'Tap the camera icon to scan Ghanaian foods and track your nutrition',
            style: mulishregular.copyWith(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height / 60),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to scan screen
              Get.toNamed('/scan');
            },
            icon: const Icon(Icons.add_a_photo),
            label: const Text('Scan Food'),
            style: ElevatedButton.styleFrom(
              backgroundColor: didiyieColor.appcolor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentScansSection(List<Food> recentScans, double width, double height) {
    return SizedBox(
      height: height * 0.22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentScans.length,
        itemBuilder: (context, index) {
          final food = recentScans[index];
          return GestureDetector(
            onTap: () {
              // Navigate to food details (reusing the result screen)
              Get.to(() => FoodResultScreen(imagePath: food.image));
            },
            child: Container(
              width: width * 0.38,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food image (actual image when available)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      height: height * 0.12,
                      width: double.infinity,
                      child: _buildFoodImage(food.image, width),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: mulishsemiBold.copyWith(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${food.calories} kcal',
                          style: mulishmedium.copyWith(
                            fontSize: 12,
                            color: didiyieColor.appcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendedFoodsSection(List<Food> allFoods, double width, double height) {
    // In a real app, recommendations would be based on user's nutritional needs
    // For demo purposes, just showing a few foods from our database
    final recommendedFoods = allFoods.take(5).toList();
    
    return SizedBox(
      height: height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendedFoods.length,
        itemBuilder: (context, index) {
          final food = recommendedFoods[index];
          return Container(
            width: width * 0.28,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFDC143C).withOpacity(0.9), // Ghana red
                  const Color(0xFFDC143C).withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 45,
                    height: 45,
                    child: _buildFoodImage(food.image, width),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  food.name,
                  textAlign: TextAlign.center,
                  style: mulishsemiBold.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${food.protein.toStringAsFixed(1)}g protein',
                  style: mulishregular.copyWith(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNutritionalTipsCard(double width, double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1), // Light Ghana yellow background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFFD600).withOpacity(0.3), // Ghana yellow border
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFFFD600), // Ghana yellow
                radius: 18,
                child: Icon(Icons.lightbulb_outline, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                'Ghanaian Diet Tips',
                style: mulishbold.copyWith(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTip('Traditional ingredients like kontomire (cocoyam leaves) are rich in iron and calcium.'),
          _buildTip('Balance starchy staples like fufu with protein-rich soup and vegetables.'),
          _buildTip('Red palm oil in moderate amounts provides vitamin E and carotenoids.'),
          _buildTip('Incorporate local fruits like pawpaw and pineapple for additional vitamins.'),
        ],
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF006B3F))), // Ghana green
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: mulishmedium.copyWith(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build food images from different sources
  Widget _buildFoodImage(String imagePath, double width) {
    // Check if the image is a file path, asset path, or network URL
    if (imagePath.startsWith('http')) {
      // Network image
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackImage(width);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              valueColor: AlwaysStoppedAnimation<Color>(didiyieColor.appcolor),
              strokeWidth: 2,
            ),
          );
        },
      );
    } else if (imagePath.startsWith('/')) {
      // Local file path
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackImage(width);
        },
      );
    } else if (imagePath.startsWith('assets/')) {
      // Asset path
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackImage(width);
        },
      );
    } else {
      // Fallback
      return _buildFallbackImage(width);
    }
  }

  // Fallback image when no valid image is available
  Widget _buildFallbackImage(double width) {
    return Container(
      color: didiyieColor.appcolor.withOpacity(0.8),
      child: Center(
        child: Icon(
          Icons.restaurant,
          color: Colors.white,
          size: width * 0.1,
        ),
      ),
    );
  }
}
