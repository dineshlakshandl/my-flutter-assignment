import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        "title": "Order Shipped! ",
        "message": "Your order #ORD-83920 is on the way. Track your delivery to see when it arrives.",
        "time": "2 hours ago",
        "type": "order",
        "isUnread": true,
      },
      {
        "title": "Weekend Sale is Live!",
        "message": "Get up to 40% off on all Summer Essentials. Tap to shop now before stock runs out.",
        "time": "Yesterday",
        "type": "promo",
        "isUnread": false,
      },
      {
        "title": "Welcome to Fashion Store",
        "message": "Thanks for joining us! Complete your profile to get a 10% discount on your first order.",
        "time": "April 10, 2026",
        "type": "account",
        "isUnread": false,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), 
      
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white, 
            fontFamily: 'serif', 
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.done_all, color: Colors.white54),
              onPressed: () {
              },
            ),
        ],
      ),
      
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                
                IconData icon;
                Color iconColor;
                Color bgColor;

                if (notification["type"] == "order") {
                  icon = Icons.local_shipping;
                  iconColor = Colors.orange[200]!;
                  bgColor = Colors.orange.withOpacity(0.15);
                } else if (notification["type"] == "promo") {
                  icon = Icons.local_offer;
                  iconColor = Colors.pinkAccent[100]!;
                  bgColor = Colors.pinkAccent.withOpacity(0.15);
                } else {
                  icon = Icons.person;
                  iconColor = Colors.blue[200]!;
                  bgColor = Colors.blue.withOpacity(0.15);
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E), 
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: notification["isUnread"] 
                          ? const Color(0xFFF97316).withOpacity(0.5) 
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: iconColor, size: 24),
                      ),
                      const SizedBox(width: 16),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    notification["title"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'serif',
                                    ),
                                  ),
                                ),
                                if (notification["isUnread"])
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF97316),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              notification["message"],
                              style: TextStyle(
                                color: Colors.grey[400], 
                                fontSize: 14, 
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              notification["time"],
                              style: TextStyle(
                                color: Colors.grey[600], 
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_off_outlined, 
              size: 60, 
              color: Color(0xFFF97316), 
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "You're all caught up!",
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontFamily: 'serif',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Check back later for updates and offers.",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}