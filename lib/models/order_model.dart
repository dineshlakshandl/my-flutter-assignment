import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String recipientName;
  final String address;
  final String phone;
  final String paymentMethod;
  final List<CartItemModel> items;
  final double total;
  final DateTime date;
  final String status;

  OrderModel({
    required this.id,
    required this.recipientName,
    required this.address,
    required this.phone,
    required this.paymentMethod,
    required this.items,
    required this.total,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipientName': recipientName,
      'address': address,
      'phone': phone,
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, String docId) {
    final List<dynamic> itemsList = map['items'] as List<dynamic>? ?? [];
    return OrderModel(
      id: docId,
      recipientName: map['recipientName'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      items: itemsList.map((item) => CartItemModel.fromMap(Map<String, dynamic>.from(item))).toList(),
      total: (map['total'] ?? 0.0).toDouble(),
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      status: map['status'] ?? 'In Transit',
    );
  }
}
