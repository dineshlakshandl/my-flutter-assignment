import 'product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel product;
  final String size;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.product,
    required this.size,
    required this.quantity,
  });

  CartItemModel copyWith({
    String? id,
    ProductModel? product,
    String? size,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': {
        'id': product.id,
        'name': product.name,
        'brand': product.brand,
        'description': product.description,
        'price': product.price,
        'rating': product.rating,
        'reviewsCount': product.reviewsCount,
        'image': product.image,
        'category': product.category,
      },
      'size': size,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    final productData = Map<String, dynamic>.from(map['product'] ?? {});
    return CartItemModel(
      id: map['id'] ?? '',
      product: ProductModel.fromJson(productData),
      size: map['size'] ?? '',
      quantity: (map['quantity'] ?? 0).toInt(),
    );
  }
}
