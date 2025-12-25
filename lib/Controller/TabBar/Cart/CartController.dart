import 'package:e_commerce_app/Firebase/FirebaseService.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:get/get.dart';

class CartController extends GetxController {

  RxList<Products> cartlist = <Products>[].obs;
  RxBool isLoading = false.obs;

  var quantity = <int, int>{}.obs;
  final FirebaseService service = FirebaseService();
  RxSet<String> cartProductIds = <String>{}.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadCartList();
  }

  Future<void> loadCartList() async {
    isLoading.value = true;
    cartlist.value = await service.getcart();
    isLoading.value = false;
  }


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
    return cartProductIds.contains(productId);
  }

  int Quantity(int productId) {
    return quantity[productId] ?? 0;
  }

/*
  Future<void> getCartProducts() async {
    final ids = await service.getcart();
    cartProductIds.addAll(ids as Iterable<String>);
  }
*/

}
