import 'package:flutter/material.dart';

class DidiyieNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final String? imageUrl;
  final String? actionRoute;
  final Map<String, dynamic>? actionParams;
  final bool isRead;

  DidiyieNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.imageUrl,
    this.actionRoute,
    this.actionParams,
    this.isRead = false,
  });

  DidiyieNotification copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    NotificationType? type,
    String? imageUrl,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
    bool? isRead,
  }) {
    return DidiyieNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      actionRoute: actionRoute ?? this.actionRoute,
      actionParams: actionParams ?? this.actionParams,
      isRead: isRead ?? this.isRead,
    );
  }

  // Factory constructor to create a notification from JSON
  factory DidiyieNotification.fromJson(Map<String, dynamic> json) {
    return DidiyieNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == 'NotificationType.${json['type']}',
        orElse: () => NotificationType.general,
      ),
      imageUrl: json['imageUrl'] as String?,
      actionRoute: json['actionRoute'] as String?,
      actionParams: json['actionParams'] as Map<String, dynamic>?,
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  // Convert notification to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString().split('.').last,
      'imageUrl': imageUrl,
      'actionRoute': actionRoute,
      'actionParams': actionParams,
      'isRead': isRead,
    };
  }
}

enum NotificationType {
  general,
  nutritionTip,
  foodRecommendation,
  reminderWater,
  reminderMeal,
  trainingDataThankYou,
  newFoodAdded,
  weeklyInsight,
  achievementUnlocked,
}

// Extension to get color and icon for each notification type
extension NotificationTypeExtension on NotificationType {
  Color get color {
    switch (this) {
      case NotificationType.general:
        return Colors.blue;
      case NotificationType.nutritionTip:
        return Colors.green;
      case NotificationType.foodRecommendation:
        return Colors.orange;
      case NotificationType.reminderWater:
        return Colors.lightBlue;
      case NotificationType.reminderMeal:
        return Colors.amber;
      case NotificationType.trainingDataThankYou:
        return Colors.purple;
      case NotificationType.newFoodAdded:
        return Colors.pink;
      case NotificationType.weeklyInsight:
        return Colors.teal;
      case NotificationType.achievementUnlocked:
        return Colors.indigo;
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.general:
        return Icons.notifications;
      case NotificationType.nutritionTip:
        return Icons.lightbulb_outline;
      case NotificationType.foodRecommendation:
        return Icons.restaurant;
      case NotificationType.reminderWater:
        return Icons.water_drop;
      case NotificationType.reminderMeal:
        return Icons.access_time;
      case NotificationType.trainingDataThankYou:
        return Icons.camera_alt;
      case NotificationType.newFoodAdded:
        return Icons.new_releases;
      case NotificationType.weeklyInsight:
        return Icons.analytics;
      case NotificationType.achievementUnlocked:
        return Icons.emoji_events;
    }
  }
  
  String get label {
    switch (this) {
      case NotificationType.general:
        return 'General';
      case NotificationType.nutritionTip:
        return 'Nutrition Tip';
      case NotificationType.foodRecommendation:
        return 'Food Recommendation';
      case NotificationType.reminderWater:
        return 'Water Reminder';
      case NotificationType.reminderMeal:
        return 'Meal Reminder';
      case NotificationType.trainingDataThankYou:
        return 'Training Contribution';
      case NotificationType.newFoodAdded:
        return 'New Food';
      case NotificationType.weeklyInsight:
        return 'Weekly Insight';
      case NotificationType.achievementUnlocked:
        return 'Achievement';
    }
  }
}
