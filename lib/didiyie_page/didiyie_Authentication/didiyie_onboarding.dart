import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_icons.dart';
import 'package:didiyie/didiyie_page/didiyie_Authentication/didiyie_getstarted.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'Discover Ghanaian Cuisine',
      'description': 'Explore the rich flavors and cultural heritage of traditional Ghanaian dishes',
      'image': 'assets/images/jollof.jpg',
      'accent_color': const Color(0xFFDC143C), // Ghana red
    },
    {
      'title': 'Scan & Identify Foods',
      'description': 'Our AI technology instantly recognizes Ghanaian dishes and provides nutritional information',
      'image': 'assets/images/fufu.jpg',
      'accent_color': const Color(0xFFFFD600), // Ghana yellow
    },
    {
      'title': 'Track Your Nutrition',
      'description': 'Monitor your diet and discover the health benefits of traditional Ghanaian ingredients',
      'image': 'assets/images/kontomire.jpg',
      'accent_color': const Color(0xFF006B3F), // Ghana green
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Page View for onboarding slides
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildOnboardingPage(
                _onboardingData[index]['title'],
                _onboardingData[index]['description'],
                _onboardingData[index]['image'],
                _onboardingData[index]['accent_color'],
                height,
                width,
              );
            },
          ),
          
          // Skip button
          Positioned(
            top: height / 18,
            right: width / 20,
            child: TextButton(
              onPressed: () => Get.off(() => const didiyieGetStarted()),
              child: Text(
                'Skip',
                style: mulishsemiBold.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          // Bottom navigation dots and button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height / 6,
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Page indicator dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 10,
                        width: _currentPage == index ? 24 : 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? _onboardingData[index]['accent_color']
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: height / 40),
                  
                  // Next/Get Started button
                  Container(
                    width: double.infinity,
                    height: height / 15,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _onboardingData.length - 1) {
                          Get.off(() => const didiyieGetStarted());
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _onboardingData[_currentPage]['accent_color'],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _onboardingData.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: mulishbold.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(
    String title,
    String description,
    String imagePath,
    Color accentColor,
    double height,
    double width,
  ) {
    return Column(
      children: [
        // Smaller food image at the top
        Container(
          height: height * 0.3,
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // Ghana flag-colored accent line
        Container(
          height: 4,
          width: width * 0.3,
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        
        // Content container - focus on text
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width / 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and description
                Text(
                  title,
                  style: dmmedium.copyWith(
                    fontSize: 32,
                    color: didiyieColor.appcolor,
                    height: 1.2,
                  ),
                ),
                
                SizedBox(height: height / 40),
                
                Text(
                  description,
                  style: mulishregular.copyWith(
                    fontSize: 18,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),

                // Spacer to push content to top
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
