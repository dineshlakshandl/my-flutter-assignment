import 'package:flutter/material.dart';
import '../../app/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBannerIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<Map<String, String>> banners = [
    {
      "subtitle": "UP TO 40% OFF",
      "title": "Weekend Sale",
      "image": "assets/images/banner1.jpg"
    },
    {
      "subtitle": "JUST ARRIVED",
      "title": "Summer Essentials",
      "image": "assets/images/banner2.jpg"
    },
    {
      "subtitle": "NEW COLLECTION",
      "title": "Spring 2026",
      "image": "assets/images/banner3.jpg"
    },
  ];

  final List<String> categories = [
    "All",
    "Men",
    "Women",
    "Kids",
    "Accessories"
  ];

  final List<Map<String, dynamic>> products = [
    {
      "brand": "Calvin Klein",
      "name": "Leather Jacket",
      "price": 120,
      "rating": 4.8,
      "reviews": 234,
      "category": "Men",
      "image": "assets/images/Blouson en cuir PU pour homme, style motard, col montant, coupe ajustée, décontracté, double.jpg"
    },
    {
      "brand": "Zara",
      "name": "Summer Dress",
      "price": 80,
      "rating": 4.6,
      "reviews": 187,
      "category": "Women",
      "image": "assets/images/redfrock.jpg"
    },
    {
      "brand": "Nike",
      "name": "Classic Sneakers",
      "price": 150,
      "rating": 4.9,
      "reviews": 412,
      "category": "Men",
      "image": "assets/images/pexels-jose-martin-segura-benites-1422456152-27204251.jpg"
    },
    {
      "brand": "H&M",
      "name": "Silk Blouse",
      "price": 65,
      "rating": 4.4,
      "reviews": 98,
      "category": "Women",
      "image": "assets/images/silkblouse.jpg"
    },
    {
      "brand": "Levi's",
      "name": "Denim Jeans",
      "price": 95,
      "rating": 4.7,
      "reviews": 316,
      "category": "Men",
      "image": "assets/images/denim.jpg"
    },
    {
      "brand": "Coach",
      "name": "Crossbody Bag",
      "price": 180,
      "rating": 4.5,
      "reviews": 142,
      "category": "Accessories",
      "image": "assets/images/green-leather-branded-women-s-bag-with-a-long-strap-free-photo.jpg"
    },
    {
      "brand": "Gap",
      "name": "Kids Hoodie",
      "price": 45,
      "rating": 4.8,
      "reviews": 76,
      "category": "Kids",
      "image": "assets/images/JH01J_LS05_2021.png"
    },
    {
      "brand": "Ray-Ban",
      "name": "Sunglasses",
      "price": 130,
      "rating": 4.6,
      "reviews": 203,
      "category": "Accessories",
      "image": "assets/images/sunglass.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    String selectedCategory = categories[_selectedCategoryIndex];

    List<Map<String, dynamic>> filteredProducts = selectedCategory == "All"
        ? products
        : products.where((product) => product["category"] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        title: const Text(
          "FASHION STORE",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, Routes.search),
          ),

          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, Routes.cart),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF97316),
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          
          const SizedBox(width: 8),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.login);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1E1E1E),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFFF97316), width: 1),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Color(0xFFF97316),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
        ],
      ),

      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF141414),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFF97316),
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            if (index == 1) Navigator.pushNamed(context, Routes.search);
            if (index == 2) Navigator.pushNamed(context, Routes.cart);
            if (index == 3) Navigator.pushNamed(context, Routes.profile);
          },
        ),
      ),
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              SizedBox(
                height: 180,
                child: PageView.builder(
                  itemCount: banners.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                  controller: PageController(viewportFraction: 0.92),
                  itemBuilder: (context, index) {
                    final banner = banners[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(banner["image"]!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner["subtitle"]!,
                              style: const TextStyle(
                                color: Color(0xFFF97316),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner["title"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'serif',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  banners.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentBannerIndex == index ? 8 : 6,
                    height: _currentBannerIndex == index ? 8 : 6,
                    decoration: BoxDecoration(
                      color: _currentBannerIndex == index
                          ? const Color(0xFFF97316)
                          : Colors.grey[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Categories",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'serif',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF97316)
                              : const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCategory == "All" ? "Featured" : selectedCategory,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'serif',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "See all",
                      style: TextStyle(
                        color: Color(0xFFF97316),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              filteredProducts.isEmpty 
              ? const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Center(
                    child: Text(
                      "No products found in this category.",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.58,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return ProductItemBox(
                        product: product,
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.productDetail,
                          arguments: product,
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


class ProductItemBox extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;

  const ProductItemBox({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    product['image'],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    radius: 14,
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['brand'],
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFF97316),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${product['rating']}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(${product['reviews']})",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}