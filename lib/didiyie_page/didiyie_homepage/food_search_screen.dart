import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_models/food_model.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/food_result_screen.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({Key? key}) : super(key: key);

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final FoodController _foodController = Get.find<FoodController>();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }
  
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
  
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }
  
  List<Food> _getFilteredFoods() {
    List<Food> filteredFoods = _foodController.allFoods;
    
    // Apply search query filter
    if (_searchQuery.isNotEmpty) {
      filteredFoods = filteredFoods.where((food) {
        return food.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               food.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               food.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    // Apply category filter
    if (_selectedCategory != null && _selectedCategory != 'All') {
      filteredFoods = filteredFoods.where((food) => 
        food.category == _selectedCategory).toList();
    }
    
    return filteredFoods;
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search header
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width / 20,
                vertical: height / 40,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Search Ghanaian Foods',
                        style: dmmedium.copyWith(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 60),
                  
                  // Search box
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search foods by name, category...',
                        hintStyle: mulishregular.copyWith(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height / 60),
                  
                  // Category tabs
                  SizedBox(
                    height: 40,
                    child: Obx(() {
                      List<String> categories = ['All', ..._foodController.getAllCategories()];
                      
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = _selectedCategory == category || 
                                          (_selectedCategory == null && category == 'All');
                          
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category == 'All' ? null : category;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: isSelected 
                                  ? didiyieColor.appcolor 
                                  : Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected 
                                    ? didiyieColor.appcolor 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  category,
                                  style: mulishsemiBold.copyWith(
                                    fontSize: 14,
                                    color: isSelected 
                                      ? Colors.white 
                                      : Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            
            // Search results
            Expanded(
              child: Obx(() {
                final filteredFoods = _getFilteredFoods();
                
                if (_foodController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                if (filteredFoods.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: height / 60),
                        Text(
                          'No foods found',
                          style: mulishsemiBold.copyWith(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: height / 120),
                        Text(
                          'Try a different search term or category',
                          style: mulishregular.copyWith(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                // Grid view of foods
                return GridView.builder(
                  padding: EdgeInsets.all(width / 30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: width / 30,
                    mainAxisSpacing: width / 30,
                  ),
                  itemCount: filteredFoods.length,
                  itemBuilder: (context, index) {
                    final food = filteredFoods[index];
                    return _buildFoodCard(food, width, height);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFoodCard(Food food, double width, double height) {
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
                          onError: (exception, stackTrace) {
                            // Fallback for when image fails to load
                            return;
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${food.calories} kcal',
                        style: mulishsemiBold.copyWith(
                          fontSize: 10,
                          color: didiyieColor.appcolor,
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
}
