import 'package:get/get.dart';

class CartController extends GetxController {
  var quantity = <int, int>{}.obs;

  void addtocart(int productId) {
    quantity[productId] = 1;
  }

  void increment(int productId) {
    quantity[productId] = (quantity[productId] ?? 0) + 1;
  }

  void decrement(int productId) {
    if (quantity[productId]! > 1) {
      quantity[productId] = quantity[productId]! - 1;
    } else {
      quantity.remove(productId);
    }
  }

  bool isInCart(int productId) {
    return quantity.containsKey(productId);
  }

  int Quantity(int productId) {
    return quantity[productId] ?? 0;
  }
}
