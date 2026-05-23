// lib/models/product_model.dart

class ProductModel {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final double rating;
  final int reviewsCount;
  final String image; 
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.image,
    required this.category,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return ProductModel(
      id: documentId,
      name: data['name'] ?? '',
      brand: data['brand'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviewsCount: (data['reviewsCount'] ?? 0).toInt(),
      image: data['image'] ?? '', //
      category: data['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'image': image,
      'category': category,
    };
  }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: (json['reviewsCount'] ?? 0).toInt(),
      image: json['image'] ?? '',
      category: json['category'] ?? '',
    );
  }
}