import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_controller/auth_controller.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_homepage.dart';
import 'package:didiyie/didiyie_page/didiyie_Authentication/didiyie_signup.dart';
import './didiyie_login_animation.dart';

class didiyieLogin extends StatefulWidget {
  const didiyieLogin({Key? key}) : super(key: key);

  @override
  State<didiyieLogin> createState() => _didiyieLoginState();
}

class _didiyieLoginState extends State<didiyieLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final success = await _authController.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (success) {
        Get.offAll(() => const didiyieHomePage());
      } else {
        Get.snackbar(
          'Login Failed',
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
                  SizedBox(height: height/25),
                  
                  // App Logo
                  Center(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: height/10,
                        width: height/10,
                        decoration: BoxDecoration(
                          color: didiyieColor.appcolor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.restaurant_rounded,
                          color: didiyieColor.appcolor,
                          size: height/18,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/30),
                  
                  // Header with animation
                  DelayedAnimation(
                    delay: 100,
                    child: Center(
                      child: Text(
                        "Welcome Back 👋",
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
                          "Sign in to access your nutritional insights and saved foods",
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
                  
                  SizedBox(height: height/20),
                  
                  // Email Field with animation
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
                  
                  SizedBox(height: height/36),
                  
                  // Password Field
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
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: mulishmedium.copyWith(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: didiyieColor.appcolor.withOpacity(0.8)),
                          hintText: "Your password",
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
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/50),
                  
                  // Forgot Password
                  DelayedAnimation(
                    delay: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.snackbar(
                            'Coming Soon',
                            'Password reset functionality is not yet implemented',
                            backgroundColor: Colors.amber.withOpacity(0.1),
                            colorText: Colors.amber[800],
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 2),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Forgot Password?",
                          style: mulishsemiBold.copyWith(
                            color: didiyieColor.appcolor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/24),
                  
                  // Login Button with animation
                  DelayedAnimation(
                    delay: 600,
                    child: Obx(() => InkWell(
                      onTap: _authController.isLoading.value ? null : _login,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: height/13,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              didiyieColor.appcolor,
                              didiyieColor.appcolor.withRed((didiyieColor.appcolor.red + 20).clamp(0, 255)),
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
                                      "Log In",
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
                  
                  SizedBox(height: height/16),
                  
                  // Sign Up Link with animation
                  DelayedAnimation(
                    delay: 700,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: mulishmedium.copyWith(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(
                                () => const didiyieSignup(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 400),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Sign Up",
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
                    delay: 800,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: height/40),
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
