import 'package:e_commerce_app/Controller/TabBar/Home/HomeController.dart';
import 'package:e_commerce_app/Firebase/FirebaseService.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<Products> cartlist = <Products>[].obs;
  RxBool isLoading = false.obs;

  var quantity = <int, int>{}.obs;
  final FirebaseService service = FirebaseService();
  RxSet<String> cartProductIds = <String>{}.obs;
  double platformchrage = 20;
  RxString appliedCoupon = "".obs;
  RxDouble discountAmount = 0.0.obs;
  final couponController = TextEditingController();
 // final homeController = Get.find<HomeController>();


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

  double calculateTotal(/*List<Products> cartItems*/) {
    double total = 0;
    for (var item in cartlist) {
      total += item.price! * item.quantity!;
    }
    return total;
  }


  Future<void> increment(int productId) async {
    //    isLoading.value = true;
    try {
      await service.increaseQuantity(productId.toString());

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    //  isLoading.value = false;
  }

  Future<void> decrement(int productId) async {
    //    isLoading.value = true;
    try {
      await service.decreseQuantity(productId.toString());

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    //  isLoading.value = false;
  }

  void applyCoupon(String code) {
    if (code.isEmpty) return;
    double total = calculateTotal();

    appliedCoupon.value = code;
    couponController.text = code;
    if (code == "SAVE10" && total >= 500) {
      discountAmount.value = total * 0.10;
    }
    else if (code == "FLAT50") {
      discountAmount.value = 50;
    }
    else {
      discountAmount.value = 0;
      Get.snackbar("Invalid Coupon", "This coupon is not valid");
      return;
    }

    Get.snackbar(
      "Coupon Applied",
      "You saved ₹${discountAmount.value.toStringAsFixed(0)}",
    );
  }

  double finalAmount() {
    return calculateTotal() + platformchrage - discountAmount.value;
  }

  void removeCoupon() {
    appliedCoupon.value = '';
    discountAmount.value = 0.0;
    couponController.clear();
  }
}
