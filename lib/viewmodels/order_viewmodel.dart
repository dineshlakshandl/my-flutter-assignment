import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';
import 'cart_viewmodel.dart';

class OrderViewModel extends ChangeNotifier {
  List<OrderModel> _orders = [];
  bool _isLoading = false;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;

  OrderViewModel() {
    _initializeAuthListener();
  }

  void _initializeAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        fetchOrderHistory();
      } else {
        _orders = [];
        notifyListeners();
      }
    });
  }

  Future<void> fetchOrderHistory() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .orderBy('date', descending: true)
          .get();

      _orders = snapshot.docs.map((doc) {
        return OrderModel.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      debugPrint("Firestore Load Orders Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> placeOrder({
    required String recipientName,
    required String address,
    required String phone,
    required String paymentMethod,
    required List<CartItemModel> items,
    required double total,
    required CartViewModel cartVM,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .doc();

      final newOrder = OrderModel(
        id: docRef.id,
        recipientName: recipientName,
        address: address,
        phone: phone,
        paymentMethod: paymentMethod,
        items: items,
        total: total,
        date: DateTime.now(),
        status: 'In Transit',
      );

      await docRef.set(newOrder.toMap());

      cartVM.clearCart();

      await fetchOrderHistory();

      return true;
    } catch (e) {
      debugPrint("Firestore Place Order Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
