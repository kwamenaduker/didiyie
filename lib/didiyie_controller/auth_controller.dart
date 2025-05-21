import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// User model to store user data
class AppUser {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime createdAt;
  final String password; // Store password for local auth (in a real app, this would be hashed)
  
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.createdAt,
    required this.password,
  });
  
  // Convert user data to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
      'password': password, // In a real app, this would be hashed
    };
  }
  
  // Create user from JSON
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      password: json['password'] ?? '',
    );
  }
}

// Authentication controller using GetX
class AuthController extends GetxController {
  // Local storage for user data
  late SharedPreferences _prefs;
  
  // Observable user state
  Rx<AppUser?> currentUser = Rx<AppUser?>(null);
  
  // Loading state for authentication operations
  RxBool isLoading = false.obs;
  
  // Error messages
  RxString errorMessage = ''.obs;
  
  // Store users locally (in a real app, this would be a secure database)
  final RxList<AppUser> _users = <AppUser>[].obs;
  
  // Check if user is logged in
  bool get isLoggedIn => currentUser.value != null;
  
  @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    await loadUserFromStorage();
    await _loadSavedUsers(); // Load any existing users from storage
  }

  // Load saved users from SharedPreferences
  Future<void> _loadSavedUsers() async {
    final usersJson = _prefs.getString('users_data');
    if (usersJson != null && usersJson.isNotEmpty) {
      try {
        final List<dynamic> usersList = jsonDecode(usersJson);
        _users.value = usersList.map((u) => AppUser.fromJson(u)).toList();
      } catch (e) {
        debugPrint('Error loading users: $e');
        _users.value = [];
      }
    }
  }

  // Save all users to SharedPreferences
  Future<void> _saveAllUsers() async {
    try {
      final String usersJson = jsonEncode(_users.map((u) => u.toJson()).toList());
      await _prefs.setString('users_data', usersJson);
    } catch (e) {
      debugPrint('Error saving users: $e');
    }
  }
  
  // Load the current user from SharedPreferences
  Future<void> loadUserFromStorage() async {
    isLoading.value = true;
    try {
      final userJson = _prefs.getString('current_user');
      
      if (userJson != null && userJson.isNotEmpty) {
        final userData = jsonDecode(userJson) as Map<String, dynamic>;
        currentUser.value = AppUser.fromJson(userData);
      }
    } catch (e) {
      debugPrint('Failed to load user: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // Save current user to SharedPreferences
  Future<void> saveUserToStorage(AppUser user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _prefs.setString('current_user', userJson);
    } catch (e) {
      debugPrint('Failed to save user: $e');
      throw Exception('Failed to save user data');
    }
  }
  
  // Sign up with email and password
  Future<bool> signUp(String name, String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // Validate email
      if (!GetUtils.isEmail(email)) {
        errorMessage.value = 'Please enter a valid email';
        return false;
      }
      
      // Check if email already exists
      if (_users.any((user) => user.email.toLowerCase() == email.toLowerCase())) {
        errorMessage.value = 'Email already in use';
        return false;
      }
      
      // Validate password
      if (password.length < 6) {
        errorMessage.value = 'Password must be at least 6 characters';
        return false;
      }
      
      // Create new user
      final appUser = AppUser(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
        password: password, // In a real app, this should be hashed
      );
      
      // Save user to local storage
      _users.add(appUser);
      await _saveAllUsers();
      
      // Set as current user
      currentUser.value = appUser;
      await saveUserToStorage(appUser);
      
      return true;
    } catch (e) {
      errorMessage.value = 'Sign up failed. Please try again.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Login with email and password
  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // Validate inputs
      if (email.isEmpty || password.isEmpty) {
        errorMessage.value = 'Email and password cannot be empty';
        return false;
      }
      
      // Find user with matching email
      final matchingUsers = _users.where(
        (user) => user.email.toLowerCase() == email.toLowerCase()
      ).toList();
      
      if (matchingUsers.isEmpty) {
        errorMessage.value = 'No user found with this email';
        return false;
      }
      
      // Check password
      final user = matchingUsers.first;
      if (user.password != password) { // In a real app, use secure password comparison
        errorMessage.value = 'Wrong password';
        return false;
      }
      
      // Set as current user
      currentUser.value = user;
      await saveUserToStorage(user);
      
      return true;
    } catch (e) {
      errorMessage.value = 'Login failed. Please try again.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Logout
  Future<void> logout() async {
    isLoading.value = true;
    try {
      // Clear current user from storage
      await _prefs.remove('current_user');
      currentUser.value = null;
    } catch (e) {
      debugPrint('Failed to logout: $e');
      errorMessage.value = 'Failed to log out';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Reset password for local auth
  Future<bool> resetPassword(String email) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // Find user with matching email
      final userIndex = _users.indexWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase()
      );
      
      if (userIndex == -1) {
        errorMessage.value = 'No user found with this email';
        return false;
      }
      
      // In a real app, this would send an email with reset instructions
      // For demo purposes, we'll just show a success message
      Get.snackbar(
        'Password Reset',
        'Password reset instructions would be sent to $email',
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green[700],
        duration: const Duration(seconds: 3),
      );
      
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to reset password';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

// Initialize the auth controller (now handled in main.dart)
void initAuthServices() {
  // This is now handled in main.dart
  // Get.put(AuthController());
}
