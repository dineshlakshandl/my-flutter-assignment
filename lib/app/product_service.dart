// lib/app/product_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProductsFromDatabase({String? selectedCategory}) async {
    try {
      Query query = _firestore.collection('products');

    
      if (selectedCategory != null && selectedCategory != "All") {
        query = query.where('category', isEqualTo: selectedCategory);
      }

      QuerySnapshot snapshot = await query.get();

      return snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      throw Exception("Failed to query product collection: $e");
    }
  }
}