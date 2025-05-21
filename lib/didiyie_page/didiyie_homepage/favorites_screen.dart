import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_models/food_model.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/food_result_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  final FoodController _foodController = Get.find<FoodController>();
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Load favorites from storage when screen initializes
    _foodController.loadFavorites();
    _foodController.loadRecentlyScanned();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
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
          'Your Food Collection',
          style: mulishbold.copyWith(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: mulishbold.copyWith(fontSize: 16),
          unselectedLabelStyle: mulishmedium.copyWith(fontSize: 16),
          tabs: const [
            Tab(text: 'Favorites'),
            Tab(text: 'Recently Scanned'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Favorites tab
          _buildFavoritesTab(width, height),
          
          // Recently scanned tab
          _buildRecentlyScannedTab(width, height),
        ],
      ),
    );
  }
  
  Widget _buildFavoritesTab(double width, double height) {
    return Obx(() {
      final favorites = _foodController.favoriteFoods;
      
      if (_foodController.isLoadingFavorites.value) {
        return const Center(child: CircularProgressIndicator());
      }
      
      if (favorites.isEmpty) {
        return _buildEmptyState(
          'No favorites yet',
          'Save foods you like by tapping the heart icon',
          Icons.favorite_border,
          width,
          height,
        );
      }
      
      return GridView.builder(
        padding: EdgeInsets.all(width / 30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: width / 30,
          mainAxisSpacing: width / 30,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final food = favorites[index];
          return _buildFoodCard(
            food, 
            width, 
            height,
            onRemove: () => _foodController.removeFromFavorites(food),
          );
        },
      );
    });
  }
  
  Widget _buildRecentlyScannedTab(double width, double height) {
    return Obx(() {
      final recentlyScanned = _foodController.recentlyScannedFoods;
      
      if (_foodController.isLoadingRecentlyScanned.value) {
        return const Center(child: CircularProgressIndicator());
      }
      
      if (recentlyScanned.isEmpty) {
        return _buildEmptyState(
          'No scanned foods yet',
          'Start scanning foods to see your history here',
          Icons.camera_alt_outlined,
          width,
          height,
        );
      }
      
      return ListView.builder(
        padding: EdgeInsets.all(width / 30),
        itemCount: recentlyScanned.length,
        itemBuilder: (context, index) {
          final food = recentlyScanned[index];
          final date = DateTime.now().subtract(Duration(minutes: index * 30));
          return _buildRecentFoodItem(food, date, width, height);
        },
      );
    });
  }
  
  Widget _buildEmptyState(
    String title, 
    String subtitle, 
    IconData icon, 
    double width, 
    double height
  ) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(width / 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width / 3,
              height: width / 3,
              decoration: BoxDecoration(
                color: didiyieColor.appcolor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: width / 6,
                color: didiyieColor.appcolor.withOpacity(0.7),
              ),
            ),
            SizedBox(height: height / 40),
            Text(
              title,
              style: dmmedium.copyWith(
                fontSize: 22,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height / 80),
            Text(
              subtitle,
              style: mulishregular.copyWith(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height / 30),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate back to home to scan or search
                Get.toNamed('/scan');
              },
              icon: const Icon(Icons.search),
              label: const Text('Discover Foods'),
              style: ElevatedButton.styleFrom(
                backgroundColor: didiyieColor.appcolor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: width / 10,
                  vertical: height / 60,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFoodCard(
    Food food, 
    double width, 
    double height, 
    {required Function onRemove}
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to food details screen
        Get.to(() => FoodResultScreen(imagePath: food.image));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF006B3F).withOpacity(0.1), // Ghana green
                        image: DecorationImage(
                          image: AssetImage(food.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () => onRemove(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Calories badge
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${food.calories} kcal',
                        style: mulishsemiBold.copyWith(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Food details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: mulishbold.copyWith(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      food.category,
                      style: mulishregular.copyWith(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // Macronutrients
                    Row(
                      children: [
                        _buildNutrientBadge('P: ${food.protein.toStringAsFixed(1)}g'),
                        const SizedBox(width: 6),
                        _buildNutrientBadge('C: ${food.carbs.toStringAsFixed(1)}g'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRecentFoodItem(Food food, DateTime date, double width, double height) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to food details screen
          Get.to(() => FoodResultScreen(imagePath: food.image));
        },
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            // Food image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Container(
                width: width / 4,
                height: width / 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF006B3F).withOpacity(0.1), // Ghana green
                  image: DecorationImage(
                    image: AssetImage(food.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // Food details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          food.name,
                          style: mulishbold.copyWith(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Favorite toggle
                        Obx(() {
                          final isFavorite = _foodController.isInFavorites(food);
                          return InkWell(
                            onTap: () {
                              if (isFavorite) {
                                _foodController.removeFromFavorites(food);
                              } else {
                                _foodController.saveToFavorites(food);
                              }
                            },
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 22,
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      food.category,
                      style: mulishregular.copyWith(
                        fontSize: 14,
                        color: didiyieColor.appcolor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(date),
                          style: mulishregular.copyWith(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Nutrition info
                    Row(
                      children: [
                        _buildNutrientTag('${food.calories} kcal', Colors.orange),
                        const SizedBox(width: 8),
                        _buildNutrientTag('${food.protein.toStringAsFixed(1)}g protein', Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNutrientBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        text,
        style: mulishregular.copyWith(
          fontSize: 10,
          color: Colors.grey[700],
        ),
      ),
    );
  }
  
  Widget _buildNutrientTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: mulishsemiBold.copyWith(
          fontSize: 12,
          color: color,
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
