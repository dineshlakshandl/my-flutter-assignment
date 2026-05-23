import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(child: Container(color: Colors.grey)),

          Text(product.name),
          Text("\$${product.price}"),

          ElevatedButton(
            onPressed: () {},
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}