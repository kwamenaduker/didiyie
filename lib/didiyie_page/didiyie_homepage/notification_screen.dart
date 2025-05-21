import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:didiyie/didiyie_controllers/notification_controller.dart';
import 'package:didiyie/didiyie_models/notification_model.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  final NotificationController _notificationController = Get.put(NotificationController());
  late TabController _tabController;
  final List<Tab> _tabs = [
    const Tab(text: 'All'),
    const Tab(text: 'Tips'),
    const Tab(text: 'Reminders'),
    const Tab(text: 'Others'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notifications',
          style: dmmedium.copyWith(fontSize: 20, color: Colors.black87),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() => _notificationController.notifications.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.done_all, color: Colors.black87),
                tooltip: 'Mark all as read',
                onPressed: () => _showMarkAllAsReadDialog(),
              )
            : const SizedBox.shrink()
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black87),
            tooltip: 'Clear all notifications',
            onPressed: () => _showClearAllDialog(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
          indicatorColor: didiyieColor.appcolor,
          labelColor: didiyieColor.appcolor,
          unselectedLabelColor: Colors.grey,
          labelStyle: dmmedium.copyWith(fontSize: 14),
          unselectedLabelStyle: dmmedium.copyWith(fontSize: 14),
        ),
      ),
      body: Obx(
        () => _notificationController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _notificationController.notifications.isEmpty
            ? _buildEmptyState()
            : TabBarView(
                controller: _tabController,
                children: [
                  // All notifications
                  _buildNotificationList(_notificationController.notifications),
                  
                  // Tips (Nutrition tips and food recommendations)
                  _buildNotificationList(_notificationController.notifications.where((n) => 
                    n.type == NotificationType.nutritionTip || 
                    n.type == NotificationType.foodRecommendation).toList()),
                  
                  // Reminders (Water and meal reminders)
                  _buildNotificationList(_notificationController.notifications.where((n) => 
                    n.type == NotificationType.reminderWater || 
                    n.type == NotificationType.reminderMeal).toList()),
                  
                  // Others (all other types)
                  _buildNotificationList(_notificationController.notifications.where((n) => 
                    n.type != NotificationType.nutritionTip && 
                    n.type != NotificationType.foodRecommendation &&
                    n.type != NotificationType.reminderWater && 
                    n.type != NotificationType.reminderMeal).toList()),
                ],
              ),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: dmmedium.copyWith(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When you receive notifications, they will appear here',
            style: mulishregular.copyWith(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildNotificationList(List<DidiyieNotification> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Text(
          'No notifications in this category',
          style: mulishregular.copyWith(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }
    
    return ListView.builder(
      itemCount: notifications.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }
  
  Widget _buildNotificationCard(DidiyieNotification notification) {
    return Dismissible(
      key: Key(notification.id),
      background: Container(
        color: Colors.red[400],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _notificationController.deleteNotification(notification.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notification deleted'),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                // Re-add the notification
                _notificationController.addNotification(notification);
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: notification.isRead 
            ? BorderSide.none 
            : BorderSide(color: notification.type.color.withOpacity(0.5), width: 1.5),
        ),
        child: InkWell(
          onTap: () {
            if (!notification.isRead) {
              _notificationController.markAsRead(notification.id);
            }
            
            // Handle navigation based on actionRoute if available
            if (notification.actionRoute != null) {
              // In a real implementation, we would navigate to the specified route
              // with the provided parameters
              Get.snackbar(
                'Navigation',
                'Would navigate to: ${notification.actionRoute}',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: notification.type.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        notification.type.icon,
                        color: notification.type.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  notification.title,
                                  style: dmmedium.copyWith(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (!notification.isRead)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: didiyieColor.appcolor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification.message,
                            style: mulishregular.copyWith(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 52, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTimestamp(notification.timestamp),
                        style: mulishregular.copyWith(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: notification.type.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          notification.type.label,
                          style: mulishregular.copyWith(
                            fontSize: 10,
                            color: notification.type.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
  
  void _showMarkAllAsReadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Mark all as read',
            style: dmmedium.copyWith(fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to mark all notifications as read?',
            style: mulishregular.copyWith(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: mulishregular.copyWith(color: Colors.grey[700]),
              ),
            ),
            TextButton(
              onPressed: () {
                _notificationController.markAllAsRead();
                Navigator.of(context).pop();
                Get.snackbar(
                  'Success',
                  'All notifications marked as read',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  colorText: Colors.green[700],
                );
              },
              child: Text(
                'Mark All',
                style: dmmedium.copyWith(color: didiyieColor.appcolor),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }
  
  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Clear all notifications',
            style: dmmedium.copyWith(fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to clear all notifications? This action cannot be undone.',
            style: mulishregular.copyWith(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: mulishregular.copyWith(color: Colors.grey[700]),
              ),
            ),
            TextButton(
              onPressed: () {
                _notificationController.clearAllNotifications();
                Navigator.of(context).pop();
                Get.snackbar(
                  'Success',
                  'All notifications cleared',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  colorText: Colors.green[700],
                );
              },
              child: Text(
                'Clear All',
                style: dmmedium.copyWith(color: Colors.red),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }
}
