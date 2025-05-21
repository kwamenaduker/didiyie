import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_controller/auth_controller.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_homepage.dart';
import 'package:didiyie/didiyie_page/didiyie_Authentication/didiyie_login_fixed.dart';
import './didiyie_login_animation.dart';

class didiyieSignup extends StatefulWidget {
  const didiyieSignup({Key? key}) : super(key: key);

  @override
  State<didiyieSignup> createState() => _didiyieSignupState();
}

class _didiyieSignupState extends State<didiyieSignup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        Get.snackbar(
          'Error',
          'Passwords do not match',
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red[700],
          duration: const Duration(seconds: 3),
        );
        return;
      }

      final success = await _authController.signUp(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (success) {
        Get.offAll(() => const didiyieHomePage());
      } else {
        Get.snackbar(
          'Signup Failed',
          _authController.errorMessage.value,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red[700],
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: didiyieColor.appcolor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width/16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height/40),
                  
                  // App Logo
                  Center(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: height/12,
                        width: height/12,
                        decoration: BoxDecoration(
                          color: didiyieColor.appcolor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.restaurant_rounded,
                          color: didiyieColor.appcolor,
                          size: height/20,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/40),
                  
                  // Header with animation
                  DelayedAnimation(
                    delay: 100,
                    child: Center(
                      child: Text(
                        "Create Account 🚀",
                        style: dmmedium.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/60),
                  
                  // Subtitle text with animation
                  DelayedAnimation(
                    delay: 200,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/12),
                        child: Text(
                          "Sign up to discover nutritional insights for your favorite foods",
                          textAlign: TextAlign.center,
                          style: mulishmedium.copyWith(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Divider for visual separation
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height/40),
                    child: Container(
                      height: 5,
                      width: width/5,
                      decoration: BoxDecoration(
                        color: didiyieColor.appcolor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/40),
                  
                  // Name Field with animation
                  DelayedAnimation(
                    delay: 300,
                    offset: 0.35,
                    direction: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        style: mulishmedium.copyWith(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(color: didiyieColor.appcolor.withOpacity(0.8)),
                          hintText: "Your full name",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: didiyieColor.appcolor, width: 1.5),
                          ),
                          prefixIcon: Icon(Icons.person_outline, color: didiyieColor.appcolor.withOpacity(0.7)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/40),
                  
                  // Email Field with animation
                  DelayedAnimation(
                    delay: 400,
                    offset: 0.35,
                    direction: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: mulishmedium.copyWith(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: didiyieColor.appcolor.withOpacity(0.8)),
                          hintText: "your.email@example.com",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: didiyieColor.appcolor, width: 1.5),
                          ),
                          prefixIcon: Icon(Icons.email_outlined, color: didiyieColor.appcolor.withOpacity(0.7)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/40),
                  
                  // Phone Field with animation
                  DelayedAnimation(
                    delay: 500,
                    offset: 0.35,
                    direction: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: mulishmedium.copyWith(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(color: didiyieColor.appcolor.withOpacity(0.8)),
                          hintText: "Your phone number",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: didiyieColor.appcolor, width: 1.5),
                          ),
                          prefixIcon: Icon(Icons.phone_outlined, color: didiyieColor.appcolor.withOpacity(0.7)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/40),
                  
                  // Password Field with animation
                  DelayedAnimation(
                    delay: 600,
                    offset: 0.35,
                    direction: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: mulishmedium.copyWith(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: didiyieColor.appcolor.withOpacity(0.8)),
                          hintText: "Create a password",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: didiyieColor.appcolor, width: 1.5),
                          ),
                          prefixIcon: Icon(Icons.lock_outline, color: didiyieColor.appcolor.withOpacity(0.7)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword 
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: didiyieColor.appcolor.withOpacity(0.7),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please create a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/40),
                  
                  // Confirm Password Field with animation
                  DelayedAnimation(
                    delay: 700,
                    offset: 0.35,
                    direction: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        style: mulishmedium.copyWith(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: didiyieColor.appcolor.withOpacity(0.8)),
                          hintText: "Confirm your password",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: didiyieColor.appcolor, width: 1.5),
                          ),
                          prefixIcon: Icon(Icons.lock_outline, color: didiyieColor.appcolor.withOpacity(0.7)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword 
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: didiyieColor.appcolor.withOpacity(0.7),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/24),
                  
                  // Signup Button with animation
                  DelayedAnimation(
                    delay: 800,
                    child: Obx(() => InkWell(
                      onTap: _authController.isLoading.value ? null : _signup,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: height/13,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              didiyieColor.appcolor,
                              didiyieColor.appcolor.withGreen((didiyieColor.appcolor.green + 20).clamp(0, 255)),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: didiyieColor.appcolor.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: _authController.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Create Account",
                                      style: mulishbold.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    )),
                  ),
                  
                  SizedBox(height: height/30),
                  
                  // Login Link with animation
                  DelayedAnimation(
                    delay: 900,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: mulishmedium.copyWith(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(
                                () => const didiyieLogin(),
                                transition: Transition.leftToRight,
                                duration: const Duration(milliseconds: 400),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Log In",
                              style: mulishbold.copyWith(
                                color: didiyieColor.appcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/40),
                  
                  // Decorative element at the bottom
                  DelayedAnimation(
                    delay: 1000,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: height/60, bottom: height/40),
                        height: 4,
                        width: width * 0.2,
                        decoration: BoxDecoration(
                          color: didiyieColor.appcolor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
