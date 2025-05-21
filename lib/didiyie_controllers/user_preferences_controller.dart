import 'package:get/get.dart';
import 'package:didiyie/didiyie_models/user_preferences_model.dart';

class UserPreferencesController extends GetxController {
  final Rx<UserPreferences> _userPreferences = UserPreferences().obs;
  
  // Getter for the current user preferences
  UserPreferences get preferences => _userPreferences.value;
  
  // Loading state
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadUserPreferences();
  }
  
  // Load user preferences from local storage
  Future<void> loadUserPreferences() async {
    isLoading.value = true;
    try {
      final loadedPreferences = await UserPreferences.loadPreferences();
      _userPreferences.value = loadedPreferences;
    } catch (e) {
      print('Error loading user preferences: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // Save user preferences to local storage
  Future<void> saveUserPreferences(UserPreferences preferences) async {
    isLoading.value = true;
    try {
      await UserPreferences.savePreferences(preferences);
      _userPreferences.value = preferences;
    } catch (e) {
      print('Error saving user preferences: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // Update calorie goal
  Future<void> updateCalorieGoal(int goal) async {
    final updated = preferences.copyWith(dailyCalorieGoal: goal);
    await saveUserPreferences(updated);
  }
  
  // Update protein goal
  Future<void> updateProteinGoal(int goal) async {
    final updated = preferences.copyWith(dailyProteinGoal: goal);
    await saveUserPreferences(updated);
  }
  
  // Update carbs goal
  Future<void> updateCarbsGoal(int goal) async {
    final updated = preferences.copyWith(dailyCarbsGoal: goal);
    await saveUserPreferences(updated);
  }
  
  // Update fat goal
  Future<void> updateFatGoal(int goal) async {
    final updated = preferences.copyWith(dailyFatGoal: goal);
    await saveUserPreferences(updated);
  }
  
  // Toggle vegetarian setting
  Future<void> toggleVegetarian(bool value) async {
    final updated = preferences.copyWith(isVegetarian: value);
    await saveUserPreferences(updated);
  }
  
  // Toggle gluten-free setting
  Future<void> toggleGlutenFree(bool value) async {
    final updated = preferences.copyWith(isGlutenFree: value);
    await saveUserPreferences(updated);
  }
  
  // Toggle lactose-free setting
  Future<void> toggleLactoseFree(bool value) async {
    final updated = preferences.copyWith(isLactoseFree: value);
    await saveUserPreferences(updated);
  }
  
  // Update dietary lifestyle
  Future<void> updateDietaryLifestyle(String lifestyle) async {
    final updated = preferences.copyWith(dietaryLifestyle: lifestyle);
    await saveUserPreferences(updated);
  }
  
  // Add an allergy
  Future<void> addAllergy(String allergy) async {
    if (allergy.isEmpty || preferences.allergies.contains(allergy)) {
      return;
    }
    
    final List<String> updatedAllergies = [...preferences.allergies, allergy];
    final updated = preferences.copyWith(allergies: updatedAllergies);
    await saveUserPreferences(updated);
  }
  
  // Remove an allergy
  Future<void> removeAllergy(String allergy) async {
    final List<String> updatedAllergies = [...preferences.allergies];
    updatedAllergies.remove(allergy);
    
    final updated = preferences.copyWith(allergies: updatedAllergies);
    await saveUserPreferences(updated);
  }
  
  // Add a favorite food category
  Future<void> addFavoriteCategory(String category) async {
    if (category.isEmpty || preferences.favoriteFoodCategories.contains(category)) {
      return;
    }
    
    final List<String> updatedCategories = [...preferences.favoriteFoodCategories, category];
    final updated = preferences.copyWith(favoriteFoodCategories: updatedCategories);
    await saveUserPreferences(updated);
  }
  
  // Remove a favorite food category
  Future<void> removeFavoriteCategory(String category) async {
    final List<String> updatedCategories = [...preferences.favoriteFoodCategories];
    updatedCategories.remove(category);
    
    final updated = preferences.copyWith(favoriteFoodCategories: updatedCategories);
    await saveUserPreferences(updated);
  }
}
