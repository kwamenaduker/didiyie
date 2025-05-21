import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_Authentication/didiyie_getstarted.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

// Model class for onboarding content
class OnboardingContent {
  final String image;
  final String title;
  final String description;
  final Color color;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
  });
}

class didiyieOnboarding extends StatefulWidget {
  const didiyieOnboarding({Key? key}) : super(key: key);

  @override
  State<didiyieOnboarding> createState() => _didiyieOnboardingState();
}

class _didiyieOnboardingState extends State<didiyieOnboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: didiyiePngimage.illustration, // Update with food scan image
      title: "Scan Any Food",
      description: "Use your camera to instantly recognize both Ghanaian and global food items",
      color: const Color(0xFFFF9800),
    ),
    OnboardingContent(
      image: didiyiePngimage.illustration, // Update with nutritional info image
      title: "Nutrition Insights",
      description: "Get detailed nutritional information and make healthier food choices",
      color: const Color(0xFF4CAF50),
    ),
    OnboardingContent(
      image: didiyiePngimage.illustration, // Update with offline image
      title: "Works Offline",
      description: "Access nutrition data anytime, even without internet connection",
      color: didiyieColor.appcolor,
    ),
  ];
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToGetStarted() {
    Get.to(() => const didiyieGetStarted());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button at top-right
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: width/20, top: height/60),
                child: _currentPage < 2 ? TextButton(
                  onPressed: _goToGetStarted,
                  child: Text(
                    "Skip",
                    style: mulishsemiBold.copyWith(
                      fontSize: 16,
                      color: didiyieColor.appcolor,
                    ),
                  ),
                ) : const SizedBox.shrink(),
              ),
            ),
            
            // Page view for onboarding screens
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _contents.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image with accent color background
                        Container(
                          padding: EdgeInsets.all(width/20),
                          decoration: BoxDecoration(
                            color: _contents[index].color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Image.asset(
                            _contents[index].image,
                            height: height / 3,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: height/20),
                        
                        // Title with Ghanaian accent dot
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _contents[index].title,
                              style: dmmedium.copyWith(fontSize: 26),
                            ),
                            SizedBox(width: 8),
                            Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                color: _contents[index].color,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height/40),
                        
                        // Description
                        Text(
                          _contents[index].description,
                          textAlign: TextAlign.center,
                          style: mulishmedium.copyWith(
                            fontSize: 16, 
                            color: didiyieColor.appcolor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _contents.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 10,
                  width: _currentPage == index ? 30 : 10,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _currentPage == index
                        ? _contents[_currentPage].color
                        : didiyieColor.lightappcolor.withOpacity(0.4),
                  ),
                ),
              ),
            ),
            SizedBox(height: height/30),
            
            // Navigation buttons
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width/20,
                vertical: height/50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button (hidden on first page)
                  _currentPage > 0
                    ? InkWell(
                        onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          height: height/16,
                          width: width/5,
                          decoration: BoxDecoration(
                            border: Border.all(color: didiyieColor.appcolor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: didiyieColor.appcolor,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(width: width/5),
                  
                  // Next or Get Started button
                  InkWell(
                    onTap: () {
                      if (_currentPage < _contents.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _goToGetStarted();
                      }
                    },
                    child: Container(
                      height: height/13,
                      width: width/1.5,
                      decoration: BoxDecoration(
                        color: _contents[_currentPage].color,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          _currentPage < _contents.length - 1 ? "Next" : "Get Started",
                          style: mulishsemiBold.copyWith(
                            fontSize: 16, 
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height/40),
          ],
        ),
      ),
    );
  }
}
