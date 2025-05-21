import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_controllers/user_preferences_controller.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_controller/auth_controller.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/model_test_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserPreferencesController _preferencesController = Get.put(UserPreferencesController());
  final FoodController _foodController = Get.find<FoodController>();
  final AuthController _authController = Get.find<AuthController>();
  
  final TextEditingController _calorieController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();
  
  String _selectedLifestyle = 'Standard';
  final List<String> _lifestyleOptions = [
    'Standard', 
    'Low Carb', 
    'High Protein', 
    'Keto', 
    'Ghanaian Traditional',
    'Balanced African'
  ];
  
  @override
  void initState() {
    super.initState();
    
    // Initialize text controllers with current values
    _calorieController.text = _preferencesController.preferences.dailyCalorieGoal.toString();
    _proteinController.text = _preferencesController.preferences.dailyProteinGoal.toString();
    _carbsController.text = _preferencesController.preferences.dailyCarbsGoal.toString();
    _fatController.text = _preferencesController.preferences.dailyFatGoal.toString();
    _selectedLifestyle = _preferencesController.preferences.dietaryLifestyle;
  }
  
  @override
  void dispose() {
    _calorieController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _allergyController.dispose();
    super.dispose();
  }
  
  void _saveNutritionGoals() {
    try {
      final calories = int.parse(_calorieController.text);
      final protein = int.parse(_proteinController.text);
      final carbs = int.parse(_carbsController.text);
      final fat = int.parse(_fatController.text);
      
      // Validate inputs
      if (calories <= 0 || protein <= 0 || carbs <= 0 || fat <= 0) {
        Get.snackbar(
          'Invalid Input',
          'All values must be greater than 0',
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
        );
        return;
      }
      
      // Save preferences
      _preferencesController.updateCalorieGoal(calories);
      _preferencesController.updateProteinGoal(protein);
      _preferencesController.updateCarbsGoal(carbs);
      _preferencesController.updateFatGoal(fat);
      
      Get.snackbar(
        'Success',
        'Nutritional goals updated',
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Please enter valid numbers',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }
  
  void _addAllergy() {
    final allergy = _allergyController.text.trim();
    if (allergy.isNotEmpty) {
      _preferencesController.addAllergy(allergy);
      _allergyController.clear();
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
        final preferences = _preferencesController.preferences;
        final isLoading = _preferencesController.isLoading.value;
        
        return SafeArea(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await _preferencesController.loadUserPreferences();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height / 50),
                          
                          // User info header
                          _buildUserInfoHeader(width, height),
                          
                          SizedBox(height: height / 25),
                          
                          // Advanced Features Section (For Developers)
                          _buildSectionTitle('Advanced Features'),
                          SizedBox(height: height / 80),
                          _buildAdvancedFeaturesSection(width, height),
                          
                          SizedBox(height: height / 30),
                          
                          // Nutrition Goals
                          _buildSectionTitle('Nutrition Goals'),
                          SizedBox(height: height / 80),
                          _buildNutritionGoalsSection(width, height),
                          
                          SizedBox(height: height / 30),
                          
                          // Dietary Preferences
                          _buildSectionTitle('Dietary Preferences'),
                          SizedBox(height: height / 80),
                          _buildDietaryPreferencesSection(preferences, width, height),
                          
                          SizedBox(height: height / 30),
                          
                          // Allergies
                          _buildSectionTitle('Allergies & Restrictions'),
                          SizedBox(height: height / 80),
                          _buildAllergiesSection(preferences, width, height),
                          
                          SizedBox(height: height / 30),
                          
                          // Favorite Categories
                          _buildSectionTitle('Food Preferences'),
                          SizedBox(height: height / 80),
                          _buildFavoriteCategoriesSection(preferences, width, height),
                          
                          SizedBox(height: height / 20),
                          
                          // Sign out button
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _authController.logout();
                                Get.offAllNamed('/login');
                              },
                              icon: const Icon(Icons.logout),
                              label: const Text('Sign Out'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: height / 20),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      }),
    );
  }
  
  Widget _buildUserInfoHeader(double width, double height) {
    // Fixed: Changed to access currentUser directly instead of trying to use properties from Rx<AppUser?>
    final userData = _authController.currentUser.value;
    final String displayName = userData?.name ?? 'User';
    final String displayEmail = userData?.email ?? 'user@example.com';
    final String initials = displayName.isNotEmpty ? displayName.substring(0, 1).toUpperCase() : 'U';
    
    return Container(
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            didiyieColor.appcolor,
            didiyieColor.appcolor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: didiyieColor.appcolor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile avatar
          CircleAvatar(
            radius: width / 12,
            backgroundColor: Colors.white,
            child: Text(
              initials,
              style: dmmedium.copyWith(
                fontSize: 24,
                color: didiyieColor.appcolor,
              ),
            ),
          ),
          SizedBox(width: width / 20),
          
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: dmmedium.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height / 150),
                Text(
                  displayEmail,
                  style: mulishregular.copyWith(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Edit profile button
          IconButton(
            onPressed: () {
              // Edit profile
              Get.snackbar(
                'Coming Soon',
                'Profile editing will be available in a future update',
              );
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: didiyieColor.appcolor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: dmmedium.copyWith(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
  
  // Advanced features section for development and testing
  Widget _buildAdvancedFeaturesSection(double width, double height) {
    return Container(
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'Developer Tools',
            style: mulishsemiBold.copyWith(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: height / 80),
          
          // ML Model Testing option
          InkWell(
            onTap: () {
              Get.to(() => const ModelTestScreen());
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: didiyieColor.appcolor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.smart_toy_outlined,
                    color: didiyieColor.appcolor,
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ML Model Testing',
                          style: mulishsemiBold.copyWith(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Test food recognition model integration',
                          style: mulishregular.copyWith(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 12),
          
          // Training Data Collection Stats
          Obx(() => Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: didiyieColor.yellow.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.data_usage_rounded,
                  color: didiyieColor.yellow,
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Training Data Collection',
                        style: mulishsemiBold.copyWith(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${_foodController.totalTrainingImages.value} images collected',
                        style: mulishregular.copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
  
  Widget _buildNutritionGoalsSection(double width, double height) {
    return Container(
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Calories input
          _buildNutritionGoalInput(
            label: 'Daily Calories',
            controller: _calorieController,
            hint: '2000',
            icon: Icons.local_fire_department,
            color: Colors.orange,
            suffix: 'kcal',
          ),
          
          SizedBox(height: height / 50),
          
          // Protein input
          _buildNutritionGoalInput(
            label: 'Daily Protein',
            controller: _proteinController,
            hint: '50',
            icon: Icons.fitness_center,
            color: Colors.green,
            suffix: 'g',
          ),
          
          SizedBox(height: height / 50),
          
          // Carbs input
          _buildNutritionGoalInput(
            label: 'Daily Carbs',
            controller: _carbsController,
            hint: '300',
            icon: Icons.grain,
            color: didiyieColor.appcolor,
            suffix: 'g',
          ),
          
          SizedBox(height: height / 50),
          
          // Fat input
          _buildNutritionGoalInput(
            label: 'Daily Fat',
            controller: _fatController,
            hint: '65',
            icon: Icons.opacity,
            color: Colors.red,
            suffix: 'g',
          ),
          
          SizedBox(height: height / 40),
          
          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveNutritionGoals,
              style: ElevatedButton.styleFrom(
                backgroundColor: didiyieColor.appcolor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save Goals',
                style: mulishbold.copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNutritionGoalInput({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color color,
    required String suffix,
  }) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: mulishsemiBold.copyWith(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: dmmedium.copyWith(
              fontSize: 16,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: mulishmedium.copyWith(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              suffixText: suffix,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildDietaryPreferencesSection(dynamic preferences, double width, double height) {
    return Container(
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dietary restrictions toggle switches
          _buildToggleOption(
            label: 'Vegetarian',
            value: preferences.isVegetarian,
            onChanged: (value) => _preferencesController.toggleVegetarian(value),
            icon: Icons.eco,
            color: Colors.green,
          ),
          
          const Divider(),
          
          _buildToggleOption(
            label: 'Gluten-Free',
            value: preferences.isGlutenFree,
            onChanged: (value) => _preferencesController.toggleGlutenFree(value),
            icon: Icons.no_food,
            color: Colors.orange,
          ),
          
          const Divider(),
          
          _buildToggleOption(
            label: 'Lactose-Free',
            value: preferences.isLactoseFree,
            onChanged: (value) => _preferencesController.toggleLactoseFree(value),
            icon: Icons.no_drinks,
            color: Colors.blue,
          ),
          
          const Divider(),
          
          // Dietary lifestyle dropdown
          Row(
            children: [
              const Icon(Icons.restaurant_menu, color: didiyieColor.appcolor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Dietary Lifestyle',
                  style: mulishsemiBold.copyWith(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              DropdownButton<String>(
                value: _selectedLifestyle,
                underline: Container(), // Remove underline
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedLifestyle = newValue;
                    });
                    _preferencesController.updateDietaryLifestyle(newValue);
                  }
                },
                items: _lifestyleOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: mulishmedium.copyWith(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildToggleOption({
    required String label,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: mulishsemiBold.copyWith(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: didiyieColor.appcolor,
        ),
      ],
    );
  }
  
  Widget _buildAllergiesSection(dynamic preferences, double width, double height) {
    return Container(
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Add allergy input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _allergyController,
                  decoration: InputDecoration(
                    hintText: 'Add an allergy (e.g., nuts, shellfish)',
                    hintStyle: mulishregular.copyWith(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addAllergy,
                style: ElevatedButton.styleFrom(
                  backgroundColor: didiyieColor.appcolor,
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          
          SizedBox(height: height / 60),
          
          // Allergies list
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: preferences.allergies.map<Widget>((String allergy) {
              return Chip(
                label: Text(
                  allergy,
                  style: mulishmedium.copyWith(color: Colors.white),
                ),
                backgroundColor: didiyieColor.appcolor,
                deleteIconColor: Colors.white,
                onDeleted: () => _preferencesController.removeAllergy(allergy),
              );
            }).toList(),
          ),
          
          if (preferences.allergies.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'No allergies added yet',
                style: mulishregular.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildFavoriteCategoriesSection(dynamic preferences, double width, double height) {
    return Container(
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select your favorite food categories:',
            style: mulishmedium.copyWith(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          
          SizedBox(height: height / 60),
          
          // Food categories
          Wrap(
            spacing: 8,
            runSpacing: 12,
            children: _buildCategoryChips(),
          ),
        ],
      ),
    );
  }
  
  List<Widget> _buildCategoryChips() {
    // Get all food categories from the food controller
    final categories = _foodController.getAllCategories();
    final selectedCategories = _preferencesController.preferences.favoriteFoodCategories;
    
    return categories.map((category) {
      final isSelected = selectedCategories.contains(category);
      
      return GestureDetector(
        onTap: () {
          if (isSelected) {
            _preferencesController.removeFavoriteCategory(category);
          } else {
            _preferencesController.addFavoriteCategory(category);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? didiyieColor.appcolor : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? didiyieColor.appcolor : Colors.grey[300]!,
            ),
          ),
          child: Text(
            category,
            style: mulishsemiBold.copyWith(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
          ),
        ),
      );
    }).toList();
  }
}
