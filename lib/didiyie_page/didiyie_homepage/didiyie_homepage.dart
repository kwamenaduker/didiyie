import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_scan_screen.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/nutrition_dashboard.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/food_search_screen.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/favorites_screen.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/user_profile_screen.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/notification_screen.dart';
import 'package:didiyie/didiyie_controllers/notification_controller.dart';
import 'package:didiyie/tools/demo_page_improved.dart';

class didiyieHomePage extends StatefulWidget {
  const didiyieHomePage({Key? key}) : super(key: key);

  @override
  State<didiyieHomePage> createState() => _didiyieHomePageState();
}

class _didiyieHomePageState extends State<didiyieHomePage> {
  int _currentIndex = 0;
  
  // Counter for accessing the demo page
  static int _demoTapCount = 0;

  // Selected page
  final List<Widget> _pages = [
    const NutritionDashboard(), 
    const FoodSearchScreen(), 
    const FavoritesScreen(), 
    const UserProfileScreen(), 
  ]; 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              // Hidden access to demo page - triple tap on app title
              onTap: () {
                // Track number of taps with a static counter
                _demoTapCount++;
                if (_demoTapCount >= 3) {
                  _demoTapCount = 0;
                  Get.to(() => const DemoPageImproved());
                }
                // Reset counter after 1 second
                Future.delayed(const Duration(seconds: 1), () {
                  _demoTapCount = 0;
                });
              },
              child: Text(
                "Didi Yie",
                style: dmmedium.copyWith(fontSize: 22, color: didiyieColor.appcolor),
              ),
            ),
            Text(
              "Your food nutrition assistant",
              style: mulishregular.copyWith(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          Obx(() => Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
                onPressed: () {
                  // Navigate to notifications screen
                  Get.to(() => const NotificationScreen());
                },
              ),
              // Notification badge
              if (Get.isRegistered<NotificationController>() && 
                  Get.find<NotificationController>().unreadCount.value > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: didiyieColor.appcolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      Get.find<NotificationController>().unreadCount.value.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          )),
        ],
      ),
      
      body: _pages[_currentIndex],
      
      // Bottom navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              // Handle navigation to different screens here
            },
            selectedItemColor: didiyieColor.appcolor,
            unselectedItemColor: Colors.grey[400],
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline),
                activeIcon: Icon(Icons.pie_chart),
                label: 'Nutrition',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
      
      // Floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the scan screen when FAB is pressed
          Get.to(() => const DidiyieScanScreen());
        },
        backgroundColor: didiyieColor.appcolor,
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }
  
  Widget _buildInsightCard(
    double width,
    double height, {
    required String title,
    required String value,
    required String unit,
    required IconData iconData,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(width/30),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: mulishsemiBold.copyWith(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Icon(
                  iconData,
                  color: color,
                  size: width/15,
                ),
              ],
            ),
            SizedBox(height: height/100),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: dmmedium.copyWith(
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: width/100),
                Padding(
                  padding: EdgeInsets.only(bottom: height/200),
                  child: Text(
                    unit,
                    style: mulishregular.copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
