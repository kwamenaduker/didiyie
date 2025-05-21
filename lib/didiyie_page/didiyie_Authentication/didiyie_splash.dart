import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_page/didiyie_Authentication/didiyie_onboarding.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieSplash extends StatefulWidget {
  const didiyieSplash({Key? key}) : super(key: key);

  @override
  State<didiyieSplash> createState() => _didiyieSplashState();
}

class _didiyieSplashState extends State<didiyieSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    
    // Fade in animation
    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
    );
    
    // Scale animation for logo
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );
    
    // Slide animation for tagline
    _slideAnim = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOutCubic),
      ),
    );
    
    _controller.forward();
    goup();
  }

  goup() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const OnboardingScreen(), transition: Transition.fadeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Subtle gradient background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFFF5F9FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width/12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ghanaian-inspired decorative bar
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnim.value * 0.7,
                        child: Container(
                          height: 6,
                          width: width * 0.6,
                          margin: EdgeInsets.only(bottom: height/30),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFDC143C), // Ghana red
                                Color(0xFFFFD600), // Ghana yellow
                                Color(0xFF006B3F), // Ghana green
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  // App logo with scale animation
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnim.value,
                        child: FadeTransition(
                          opacity: _fadeAnim,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Subtle shadow/glow
                              Container(
                                width: width * 0.5,
                                height: width * 0.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: didiyieColor.appcolor.withOpacity(0.1),
                                      blurRadius: 30,
                                      spreadRadius: 15,
                                    ),
                                  ],
                                ),
                              ),
                              // Logo
                              Container(
                                padding: EdgeInsets.all(width/30),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  didiyiePngimage.appLogo,
                                  width: width * 0.35,
                                  height: width * 0.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: height/25),
                  
                  // App name with fade animation
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Text(
                      'Didi Yie',
                      style: dmmedium.copyWith(
                        fontSize: 32,
                        color: didiyieColor.appcolor,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height/60),
                  
                  // Animated tagline
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnim.value),
                        child: Opacity(
                          opacity: _fadeAnim.value,
                          child: Column(
                            children: [
                              // Food emoji icons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _foodIcon('🍲'), // Pot of food
                                  _foodIcon('🥗'), // Salad 
                                  _foodIcon('🍌'), // Banana
                                  _foodIcon('🍚'), // Rice
                                  _foodIcon('🥑'), // Avocado
                                ],
                              ),
                              SizedBox(height: height/80),
                              Text(
                                'Your AI Food Recognition Assistant',
                                style: mulishmedium.copyWith(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: height/20),
                  
                  // Subtle loading indicator
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(didiyieColor.appcolor.withOpacity(0.5)),
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

  Widget _foodIcon(String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
