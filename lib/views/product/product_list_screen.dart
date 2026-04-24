import 'package:flutter/material.dart';
import '../../app/routes.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Products")),

      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.productDetail),
              leading: Container(width: 60, height: 60, color: Colors.grey),
              title: const Text("Item",
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text("\$100",
                  style: TextStyle(color: Colors.orange)),
            ),
          );
        },
      ),
    );
  }
}