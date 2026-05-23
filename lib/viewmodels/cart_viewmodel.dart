import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/cart_item_model.dart';

class CartViewModel extends ChangeNotifier {
  List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => _cartItems;

  CartViewModel() {
    _initializeAuthListener();
  }

  void _initializeAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _loadCartFromFirestore(user.uid);
      } else {
        _cartItems = [];
        notifyListeners();
      }
    });
  }

  Future<void> _loadCartFromFirestore(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart_items')
          .get();

      _cartItems = snapshot.docs.map((doc) {
        return CartItemModel.fromMap(doc.data());
      }).toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Firestore Load Cart Error: $e");
    }
  }

  void addToCart(ProductModel product, String size, int quantity) {
    final String itemId = "${product.id}_$size";
    final int index = _cartItems.indexWhere((item) => item.id == itemId);

    if (index >= 0) {
      final existingItem = _cartItems[index];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      _cartItems[index] = updatedItem;
      _saveItemToFirestore(updatedItem);
    } else {
      final newItem = CartItemModel(
        id: itemId,
        product: product,
        size: size,
        quantity: quantity,
      );
      _cartItems.add(newItem);
      _saveItemToFirestore(newItem);
    }

    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    _removeItemFromFirestore(itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(itemId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      final updatedItem = _cartItems[index].copyWith(quantity: newQuantity);
      _cartItems[index] = updatedItem;
      _saveItemToFirestore(updatedItem);
      notifyListeners();
    }
  }

  void incrementQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      updateQuantity(itemId, _cartItems[index].quantity + 1);
    }
  }

  void decrementQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      updateQuantity(itemId, _cartItems[index].quantity - 1);
    }
  }

  int get totalItemCount {
    return _cartItems.fold(0, (total, item) => total + item.quantity);
  }
  double getTotal() {
    return _cartItems.fold(0.0, (total, item) => total + (item.product.price * item.quantity));
  }

  Future<void> _saveItemToFirestore(CartItemModel item) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return; 

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart_items')
          .doc(item.id)
          .set(item.toMap());
    } catch (e) {
      debugPrint("Firestore Save Item Error: $e");
    }
  }

  Future<void> _removeItemFromFirestore(String itemId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart_items')
          .doc(itemId)
          .delete();
    } catch (e) {
      debugPrint("Firestore Delete Item Error: $e");
    }
  }

  void clearCart() {
    _cartItems = [];
    _clearCartFromFirestore();
    notifyListeners();
  }

  Future<void> _clearCartFromFirestore() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final collectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart_items');
      final snapshot = await collectionRef.get();
      final batch = FirebaseFirestore.instance.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      debugPrint("Firestore Clear Cart Error: $e");
    }
  }
}