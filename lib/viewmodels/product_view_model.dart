// lib/viewmodels/product_view_model.dart

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../app/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductModel> _products = [];
  bool _isLoading = false;
  String _selectedCategory = "All";

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  Future<void> fetchAllProducts() async {
    _isLoading = true;
    notifyListeners(); 

    try {
      _products = await _productService.fetchProductsFromDatabase(
        selectedCategory: _selectedCategory,
      );
    } catch (e) {
      debugPrint("Firestore Fetch Error inside ViewModel: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateCategory(String newCategory) {
    if (_selectedCategory == newCategory) return; 
    _selectedCategory = newCategory;
    fetchAllProducts(); 
  }
}