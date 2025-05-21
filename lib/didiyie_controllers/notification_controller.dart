import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:didiyie/didiyie_models/notification_model.dart';

class NotificationController extends GetxController {
  final RxList<DidiyieNotification> notifications = <DidiyieNotification>[].obs;
  final RxInt unreadCount = 0.obs;
  final RxBool isLoading = false.obs;
  
  static const String NOTIFICATION_STORAGE_KEY = 'didiyie_notifications';
  
  @override
  void onInit() {
    super.onInit();
    loadNotifications();
    // Generate some sample notifications if list is empty (for demo)
    _checkAndGenerateSampleNotifications();
  }
  
  // Load notifications from shared preferences
  Future<void> loadNotifications() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final notificationJson = prefs.getString(NOTIFICATION_STORAGE_KEY);
      
      if (notificationJson != null) {
        final List<dynamic> decodedJson = jsonDecode(notificationJson);
        final loadedNotifications = decodedJson
            .map((item) => DidiyieNotification.fromJson(item))
            .toList();
        
        // Sort by timestamp (newest first)
        loadedNotifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        
        notifications.value = loadedNotifications;
        _updateUnreadCount();
      }
    } catch (e) {
      print('Error loading notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // Save notifications to shared preferences
  Future<void> saveNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedJson = jsonEncode(notifications.map((n) => n.toJson()).toList());
      await prefs.setString(NOTIFICATION_STORAGE_KEY, encodedJson);
    } catch (e) {
      print('Error saving notifications: $e');
    }
  }
  
  // Add a new notification
  Future<void> addNotification(DidiyieNotification notification) async {
    notifications.insert(0, notification); // Add to the beginning of the list
    _updateUnreadCount();
    await saveNotifications();
  }
  
  // Mark a notification as read
  Future<void> markAsRead(String notificationId) async {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index >= 0) {
      final updatedNotification = notifications[index].copyWith(isRead: true);
      notifications[index] = updatedNotification;
      _updateUnreadCount();
      await saveNotifications();
    }
  }
  
  // Mark all notifications as read
  Future<void> markAllAsRead() async {
    final updatedNotifications = notifications.map(
      (notification) => notification.copyWith(isRead: true)
    ).toList();
    
    notifications.value = updatedNotifications;
    _updateUnreadCount();
    await saveNotifications();
  }
  
  // Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    notifications.removeWhere((n) => n.id == notificationId);
    _updateUnreadCount();
    await saveNotifications();
  }
  
  // Clear all notifications
  Future<void> clearAllNotifications() async {
    notifications.clear();
    _updateUnreadCount();
    await saveNotifications();
  }
  
  // Filter notifications by type
  List<DidiyieNotification> getNotificationsByType(NotificationType type) {
    return notifications.where((n) => n.type == type).toList();
  }
  
  // Update the unread count
  void _updateUnreadCount() {
    unreadCount.value = notifications.where((n) => !n.isRead).length;
  }
  
  // Generate food-related notifications based on user activity
  Future<void> generateFoodRelatedNotification({
    required String foodName,
    required NotificationType type,
  }) async {
    String title = '';
    String message = '';
    String? imageUrl;
    String? actionRoute;
    Map<String, dynamic>? actionParams;
    
    switch (type) {
      case NotificationType.trainingDataThankYou:
        title = 'Thank You For Contributing!';
        message = 'Your image of $foodName helps us improve food recognition for everyone.';
        actionRoute = '/training-progress';
        break;
        
      case NotificationType.foodRecommendation:
        title = 'Try This Ghanaian Dish';
        message = 'Based on your preferences, you might enjoy $foodName. Tap to learn more!';
        actionRoute = '/food-details';
        actionParams = {'foodName': foodName};
        break;
        
      case NotificationType.nutritionTip:
        title = 'Nutrition Tip';
        message = 'Did you know? $foodName is a great source of essential nutrients for your health.';
        break;
        
      case NotificationType.newFoodAdded:
        title = 'New Food Added';
        message = '$foodName has been added to our database. Try scanning it next time!';
        break;
        
      default:
        return; // Don't create notification for unsupported types
    }
    
    final notification = DidiyieNotification(
      id: 'notification_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      message: message,
      timestamp: DateTime.now(),
      type: type,
      imageUrl: imageUrl,
      actionRoute: actionRoute,
      actionParams: actionParams,
    );
    
    await addNotification(notification);
  }
  
  // Generate reminder notification (water, meal, etc.)
  Future<void> generateReminderNotification({
    required NotificationType reminderType,
    String? customMessage,
  }) async {
    String title;
    String message;
    
    switch (reminderType) {
      case NotificationType.reminderWater:
        title = 'Hydration Reminder';
        message = customMessage ?? 'Time to drink some water! Staying hydrated is important for your health.';
        break;
        
      case NotificationType.reminderMeal:
        title = 'Meal Time';
        message = customMessage ?? 'It\'s time for your next meal. Remember to eat balanced portions of your favorite foods!';
        break;
        
      default:
        return; // Don't create notification for unsupported types
    }
    
    final notification = DidiyieNotification(
      id: 'notification_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      message: message,
      timestamp: DateTime.now(),
      type: reminderType,
    );
    
    await addNotification(notification);
  }
  
  // Generate weekly insights based on user's food habits
  Future<void> generateWeeklyInsightNotification() async {
    // In a real app, this would analyze user's food scan history
    // For now, we'll create a simulated insight
    
    final insights = [
      'You\'ve been enjoying a good variety of vegetables this week!',
      'Your protein intake has been consistent this week. Great job!',
      'You might want to try more fiber-rich foods in your diet.',
      'Your food choices this week were well-balanced nutritionally.',
      'You\'ve been exploring new Ghanaian dishes. Keep discovering!',
    ];
    
    final random = Random();
    final selectedInsight = insights[random.nextInt(insights.length)];
    
    final notification = DidiyieNotification(
      id: 'insight_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Your Weekly Food Insight',
      message: selectedInsight,
      timestamp: DateTime.now(),
      type: NotificationType.weeklyInsight,
      actionRoute: '/nutrition-dashboard',
    );
    
    await addNotification(notification);
  }
  
  // Generate sample notifications for demo purposes
  Future<void> _checkAndGenerateSampleNotifications() async {
    await Future.delayed(const Duration(seconds: 1)); // Delay to ensure loading completes
    
    if (notifications.isEmpty) {
      // Generate a variety of sample notifications
      final now = DateTime.now();
      
      final sampleNotifications = [
        DidiyieNotification(
          id: 'sample_1',
          title: 'Welcome to Didi Yie!',
          message: 'Explore Ghanaian foods and discover their nutritional benefits.',
          timestamp: now.subtract(const Duration(days: 1)),
          type: NotificationType.general,
          actionRoute: '/onboarding',
        ),
        
        DidiyieNotification(
          id: 'sample_2',
          title: 'Nutrition Tip',
          message: 'Did you know? Kontomire is rich in iron and vitamin A, essential for healthy blood and vision.',
          timestamp: now.subtract(const Duration(hours: 12)),
          type: NotificationType.nutritionTip,
        ),
        
        DidiyieNotification(
          id: 'sample_3',
          title: 'Try This Ghanaian Dish',
          message: 'Have you tried Waakye? This delicious rice and beans dish is a staple in Ghana.',
          timestamp: now.subtract(const Duration(hours: 6)),
          type: NotificationType.foodRecommendation,
          actionRoute: '/food-details',
          actionParams: {'foodName': 'Waakye'},
        ),
        
        DidiyieNotification(
          id: 'sample_4',
          title: 'Hydration Reminder',
          message: 'Remember to drink water regularly throughout the day for optimal health.',
          timestamp: now.subtract(const Duration(hours: 2)),
          type: NotificationType.reminderWater,
        ),
        
        DidiyieNotification(
          id: 'sample_5',
          title: 'New Foods Added',
          message: 'We\'ve added 5 new Ghanaian dishes to our database! Try scanning them.',
          timestamp: now.subtract(const Duration(minutes: 30)),
          type: NotificationType.newFoodAdded,
        ),
      ];
      
      notifications.value = sampleNotifications;
      _updateUnreadCount();
      await saveNotifications();
    }
  }
}
