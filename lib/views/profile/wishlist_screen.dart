import 'package:flutter/material.dart';
import '../../app/routes.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Map<String, dynamic>> wishlistItems = [
    {
      "brand": "Calvin Klein",
      "name": "Leather Jacket",
      "price": 120,
      "rating": 4.8,
      "reviews": 234,
      "image": "assets/images/Blouson en cuir PU pour homme, style motard, col montant, coupe ajustée, décontracté, double.jpg"
    },
    {
      "brand": "Zara",
      "name": "Summer Dress",
      "price": 80,
      "rating": 4.6,
      "reviews": 187,
      "image": "assets/images/redfrock.jpg"
    },
    {
      "brand": "Nike",
      "name": "Classic Sneakers",
      "price": 150,
      "rating": 4.9,
      "reviews": 412,
      "image": "assets/images/pexels-jose-martin-segura-benites-1422456152-27204251.jpg"
    },
    {
      "brand": "Coach",
      "name": "Crossbody Bag",
      "price": 180,
      "rating": 4.5,
      "reviews": 142,
      "image": "assets/images/green-leather-branded-women-s-bag-with-a-long-strap-free-photo.jpg"
    },
  ];

  void removeFromWishlist(int index) {
    setState(() {
      wishlistItems.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item removed from Wishlist"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          "Wishlist",
          style: TextStyle(
            color: Colors.white, 
            fontFamily: 'serif', 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      body: wishlistItems.isEmpty
          ? _buildEmptyState() 
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: wishlistItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = wishlistItems[index];

                  return GestureDetector(

                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.productDetail,
                        arguments: product,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    product['image'],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () => removeFromWishlist(index),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black.withOpacity(0.5),
                                      radius: 16,
                                      child: const Icon(
                                        Icons.favorite, 
                                        color: Colors.pinkAccent,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['brand'].toString().toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'serif',
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "\$${product['price']}",
                                  style: const TextStyle(
                                    color: Color(0xFFF97316),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
              Icons.favorite_border, 
              size: 60, 
              color: Colors.pinkAccent, 
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Your Wishlist is Empty",
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontFamily: 'serif',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Save your favorite items here.",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
          const SizedBox(height: 30),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFF97316)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.home);
            },
            child: const Text(
              "Start Shopping",
              style: TextStyle(
                color: Color(0xFFF97316), 
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}