import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> myOrders = [
      {
        "orderId": "#ORD-83920",
        "date": "April 18, 2026",
        "status": "In Transit",
        "statusColor": const Color(0xFFF97316),
        "total": 145.00,
        "items": 2,
      },
      {
        "orderId": "#ORD-83711",
        "date": "April 12, 2026",
        "status": "Delivered",
        "statusColor": Colors.green[400], 
        "total": 80.00,
        "items": 1,
      },
      {
        "orderId": "#ORD-83445",
        "date": "March 05, 2026",
        "status": "Cancelled",
        "statusColor": Colors.red[400], 
        "total": 120.00,
        "items": 1,
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
          "My Orders",
          style: TextStyle(
            color: Colors.white, 
            fontFamily: 'serif', 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      body: myOrders.isEmpty 
          ? _buildEmptyState() 
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myOrders.length,
              itemBuilder: (context, index) {
                final order = myOrders[index];
                return _buildOrderCard(order);
              },
            ),
    );
  }
  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order["orderId"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: order["statusColor"].withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order["status"],
                  style: TextStyle(
                    color: order["statusColor"],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date: ${order["date"]}",
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
              Text(
                "${order["items"]} Items",
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ],
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.white10, thickness: 1),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "\$${order["total"].toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFF97316)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                },
                child: const Text(
                  "Details",
                  style: TextStyle(color: Color(0xFFF97316), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
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
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inventory_2_outlined, 
              size: 60, 
              color: Color(0xFFF97316), 
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "No Active Orders",
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontFamily: 'serif',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You haven't placed any orders yet.",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}