import '../models/product_model.dart';

class CartViewModel {
  List<Product> cartItems = [];

  void addToCart(Product product) {
    cartItems.add(product);
  }

  double getTotal() {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }
}