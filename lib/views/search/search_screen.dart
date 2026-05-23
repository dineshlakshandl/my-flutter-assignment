import 'package:flutter/material.dart';
import '../../app/routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  final List<String> recentSearches = ["Jacket", "Shoes", "Hat", "Backpack", "T-Shirt"];
  
  final List<Map<String, dynamic>> allProducts = [
    {
      "brand": "Calvin Klein",
      "name": "Leather Jacket",
      "price": 120,
      "image": "assets/images/Blouson en cuir PU pour homme, style motard, col montant, coupe ajustée, décontracté, double.jpg"
    },
    {
      "brand": "Nike",
      "name": "Running Shoes", 
      "price": 150,
      "image": "assets/images/pexels-jose-martin-segura-benites-1422456152-27204251.jpg"
    },
    {
      "brand": "Zara",
      "name": "Cotton T-Shirt", 
      "price": 35,
      "image": "assets/images/Zinc-Blue-Crew-Neck-T-Shirt-04.jpg"
    },
    {
      "brand": "North Face",
      "name": "Travel Backpack", 
      "price": 85,
      "image": "assets/images/backpack.jpg"
    },
    {
      "brand": "Adidas",
      "name": "Stylish Hat",
      "price": 25,
      "image": "assets/images/style-hat.jpg"
    },
    {
      "brand": "H&M",
      "name": "Silk Blouse",
      "price": 65,
      "image": "assets/images/silkblouse.jpg"
    },
  ];
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = allProducts;
    } else {
      results = allProducts
          .where((product) =>
              product["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A), 
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _runFilter(value), 
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search products...", 
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white54),
                          onPressed: () {
                            _searchController.clear();
                            _runFilter(''); 
                            FocusScope.of(context).unfocus();
                          },
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Recent searches",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'serif',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: recentSearches.map((search) {
                return GestureDetector(
                  onTap: () {
                    _searchController.text = search;
                    _runFilter(search);
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E), 
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.white54,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          search,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            const Text(
              "Popular products",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'serif',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: filteredProducts.isNotEmpty
                  ? GridView.builder(
                      itemCount: filteredProducts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.75, 
                      ),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
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
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      product['image'],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'serif',
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "\$${product['price']}",
                                        style: const TextStyle(
                                          color: Color(0xFFF97316),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
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
                    )
                  : const Center(
                      child: Text(
                        "No products found.",
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}