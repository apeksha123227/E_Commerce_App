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
    calculateTotal();
    isLoading.value = false;
  }

  Future<void> removeFromCart(String id, int index) async {
    await service.deleteCart(id);
    cartlist.removeAt(index);
  }

  /*  void addtocart(int productId) {
    quantity[productId] = 1;
  }*/
  double calculateTotal(/*List<Products> cartItems*/) {
    double total = 0;
    for (var item in cartlist) {
      total += item.price! * item.quantity!;
    }
    return total;
  }

  /* void increment(int productId) {
    quantity[productId] = (quantity[productId] ?? 0) + 1;
  }


  void decrement(int productId) {
    if (quantity[productId]! > 1) {
      quantity[productId] = quantity[productId]! - 1;
    } else {
      quantity.remove(productId);
    }
  }
*/

  Future<void> increment(int productId) async {
    //    isLoading.value = true;
    try {
      await service.increaseQuantity(productId.toString());
      /*int index = cartlist.indexWhere((e) => e.id == productId);
      if (index != -1) {
       //  cartlist[index].quantity = (cartlist[index].quantity ?? 0) + 1;
        quantity[productId] = (quantity[productId] ?? 0) + 1;
        cartlist.refresh();
      }*/
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    //  isLoading.value = false;
  }

  Future<void> decrement(int productId) async {
    //    isLoading.value = true;
    try {
      await service.decreseQuantity(productId.toString());
      /*if (quantity[productId]! > 1) {
        quantity[productId] = quantity[productId]! - 1;
      } else {
        quantity.remove(productId);
      }*/
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    //  isLoading.value = false;
  }

  /* void decrement(int productId) {
    if (quantity[productId]! > 1) {
      quantity[productId] = quantity[productId]! - 1;
    } else {
      quantity.remove(productId);
    }
  }*/

  /*

  bool isInCart(int productId) {
    return cartProductIds.contains(productId);
  }
*/

  /*  int Quantity(int productId) {
    return quantity[productId] ?? 0;
  }*/

  /*
  Future<void> getCartProducts() async {
    final ids = await service.getcart();
    cartProductIds.addAll(ids as Iterable<String>);
  }
*/
}
