import 'package:flutter/material.dart';
import '../../app/routes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> cartItems = [
    {
      'brand': 'Calvin Klein',
      'name': 'Leather Jacket',
      'price': 120,
      'quantity': 1,
      'size': 'XL',
      'image': 'assets/images/Blouson en cuir PU pour homme, style motard, col montant, coupe ajustée, décontracté, double.jpg'
    },
    {
      'brand': 'Zara',
      'name': 'Summer Dress',
      'price': 80,
      'quantity': 2,
      'size': 'M',
      'image': 'assets/images/redfrock.jpg'
    },
  ];

  double totalPrice() {
    return cartItems.fold(
            0,
            (sum, item) =>
                sum + (item['price'] as int) * (item['quantity'] as int))
        .toDouble();
  }

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int) + 1;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if ((cartItems[index]['quantity'] as int) > 1) {
        cartItems[index]['quantity'] =
            (cartItems[index]['quantity'] as int) - 1;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), 
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty.",
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E), 
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item['image'],
                                width: 80,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['brand'].toString().toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['name'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Size: ${item['size']}",
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "\$${item['price']}",
                                    style: const TextStyle(
                                      color: Color(0xFFF97316),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.delete_outline, color: Colors.white54),
                                  onPressed: () => removeItem(index),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0F0F0F),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        icon: const Icon(Icons.remove, color: Colors.white, size: 16),
                                        onPressed: () => decrementQuantity(index),
                                      ),
                                      Text(
                                        item['quantity'].toString(),
                                        style: const TextStyle(
                                          color: Colors.white, 
                                          fontSize: 14, 
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        icon: const Icon(Icons.add, color: Colors.white, size: 16),
                                        onPressed: () => incrementQuantity(index),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF141414),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$${totalPrice()}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF97316),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: cartItems.isEmpty 
                        ? null 
                        : () => Navigator.pushNamed(context, Routes.checkout),
                      child: const Text(
                        "Proceed to Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
}