import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  final int dailyCalorieGoal;
  final int dailyProteinGoal;
  final int dailyCarbsGoal;
  final int dailyFatGoal;
  final bool isVegetarian;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final List<String> allergies;
  final List<String> favoriteFoodCategories;
  final String dietaryLifestyle;

  UserPreferences({
    this.dailyCalorieGoal = 2000,
    this.dailyProteinGoal = 50,
    this.dailyCarbsGoal = 300,
    this.dailyFatGoal = 65,
    this.isVegetarian = false,
    this.isGlutenFree = false,
    this.isLactoseFree = false,
    this.allergies = const [],
    this.favoriteFoodCategories = const [],
    this.dietaryLifestyle = 'Standard',
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'dailyCalorieGoal': dailyCalorieGoal,
      'dailyProteinGoal': dailyProteinGoal,
      'dailyCarbsGoal': dailyCarbsGoal,
      'dailyFatGoal': dailyFatGoal,
      'isVegetarian': isVegetarian,
      'isGlutenFree': isGlutenFree,
      'isLactoseFree': isLactoseFree,
      'allergies': allergies,
      'favoriteFoodCategories': favoriteFoodCategories,
      'dietaryLifestyle': dietaryLifestyle,
    };
  }

  // Create from JSON
  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      dailyCalorieGoal: json['dailyCalorieGoal'] ?? 2000,
      dailyProteinGoal: json['dailyProteinGoal'] ?? 50,
      dailyCarbsGoal: json['dailyCarbsGoal'] ?? 300,
      dailyFatGoal: json['dailyFatGoal'] ?? 65,
      isVegetarian: json['isVegetarian'] ?? false,
      isGlutenFree: json['isGlutenFree'] ?? false,
      isLactoseFree: json['isLactoseFree'] ?? false,
      allergies: List<String>.from(json['allergies'] ?? []),
      favoriteFoodCategories: List<String>.from(json['favoriteFoodCategories'] ?? []),
      dietaryLifestyle: json['dietaryLifestyle'] ?? 'Standard',
    );
  }

  // Create a copy with updated values
  UserPreferences copyWith({
    int? dailyCalorieGoal,
    int? dailyProteinGoal,
    int? dailyCarbsGoal,
    int? dailyFatGoal,
    bool? isVegetarian,
    bool? isGlutenFree,
    bool? isLactoseFree,
    List<String>? allergies,
    List<String>? favoriteFoodCategories,
    String? dietaryLifestyle,
  }) {
    return UserPreferences(
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      dailyProteinGoal: dailyProteinGoal ?? this.dailyProteinGoal,
      dailyCarbsGoal: dailyCarbsGoal ?? this.dailyCarbsGoal,
      dailyFatGoal: dailyFatGoal ?? this.dailyFatGoal,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      allergies: allergies ?? this.allergies,
      favoriteFoodCategories: favoriteFoodCategories ?? this.favoriteFoodCategories,
      dietaryLifestyle: dietaryLifestyle ?? this.dietaryLifestyle,
    );
  }

  // Save preferences to local storage
  static Future<void> savePreferences(UserPreferences preferences) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert the user preferences to JSON
      final Map<String, dynamic> prefsMap = preferences.toJson();
      
      // Save individual fields to ensure they persist correctly
      await prefs.setInt('dailyCalorieGoal', preferences.dailyCalorieGoal);
      await prefs.setInt('dailyProteinGoal', preferences.dailyProteinGoal);
      await prefs.setInt('dailyCarbsGoal', preferences.dailyCarbsGoal);
      await prefs.setInt('dailyFatGoal', preferences.dailyFatGoal);
      await prefs.setBool('isVegetarian', preferences.isVegetarian);
      await prefs.setBool('isGlutenFree', preferences.isGlutenFree);
      await prefs.setBool('isLactoseFree', preferences.isLactoseFree);
      await prefs.setString('dietaryLifestyle', preferences.dietaryLifestyle);
      
      // For lists, convert to JSON strings
      await prefs.setStringList('allergies', preferences.allergies);
      await prefs.setStringList('favoriteFoodCategories', preferences.favoriteFoodCategories);
      
      // Also save the full JSON string as a backup
      final jsonString = json.encode(prefsMap);
      await prefs.setString('user_preferences', jsonString);
      
      print('User preferences saved successfully!');
    } catch (e) {
      print('Error saving user preferences: $e');
    }
  }

  // Load preferences from local storage
  static Future<UserPreferences> loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if we have any saved preferences
      if (!prefs.containsKey('dailyCalorieGoal') && !prefs.containsKey('user_preferences')) {
        return UserPreferences(); // Return default values if nothing is saved
      }
      
      // Try loading individual fields first (more reliable)
      if (prefs.containsKey('dailyCalorieGoal')) {
        return UserPreferences(
          dailyCalorieGoal: prefs.getInt('dailyCalorieGoal') ?? 2000,
          dailyProteinGoal: prefs.getInt('dailyProteinGoal') ?? 50,
          dailyCarbsGoal: prefs.getInt('dailyCarbsGoal') ?? 300,
          dailyFatGoal: prefs.getInt('dailyFatGoal') ?? 65,
          isVegetarian: prefs.getBool('isVegetarian') ?? false,
          isGlutenFree: prefs.getBool('isGlutenFree') ?? false,
          isLactoseFree: prefs.getBool('isLactoseFree') ?? false,
          dietaryLifestyle: prefs.getString('dietaryLifestyle') ?? 'Standard',
          allergies: prefs.getStringList('allergies') ?? [],
          favoriteFoodCategories: prefs.getStringList('favoriteFoodCategories') ?? [],
        );
      }
      
      // Fallback to JSON string if individual fields aren't available
      final jsonString = prefs.getString('user_preferences');
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        return UserPreferences.fromJson(jsonMap);
      }
      
      return UserPreferences(); // Return default values if nothing could be loaded
    } catch (e) {
      print('Error loading user preferences: $e');
      return UserPreferences(); // Return default values on error
    }
  }
}
