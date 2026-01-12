import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/TabBar/Account/CartController.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/HomeController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/Firebase/FirebaseService.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Categories.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ViewAllProducts_By_Categorie_Controller extends GetxController {
  final cartController = Get.find<CartController>();
  RxString getSelectedCategorieId = "".obs;
  RxBool isLoading = true.obs;
  final apiService = ApiService();
  RxList<Products> productList = <Products>[].obs;
  RxString getselectedName = "".obs;
  RxSet<String> cartIds = <String>{}.obs;
  RxList<Products> cartList = <Products>[].obs;
  bool isInCart(String id) => cartIds.contains(id);
  final FirebaseService service = FirebaseService();
  RxInt selectedIndex = 0.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    print("Selected id is ${getSelectedCategorieId.value}");
    loadCartList();
    await getProductDetails();
  }

  Future<void> loadCartList() async {
    isLoading.value = true;
    final cartData = await service.getcart();

    cartList.assignAll(cartData);
    cartIds.assignAll(cartData.map((e) => e.id.toString()));
    isLoading.value = false;
  }

  Future<void> addToCart(Products product) async {
    cartIds.add(product.id.toString());
    cartList.add(product);

    try {
      await Custom_Functions().addtoCart(product, selectedIndex.value);
    } catch (e) {
      cartIds.remove(product.id.toString());
      cartList.remove(product);

      Get.snackbar(
        "Error",
        "Failed to add item to cart",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> removeFromCart(String productId) async {
    final removedProduct = cartList.firstWhereOrNull(
          (p) => p.id.toString() == productId,
    );
    // 1. Instant UI update
    cartIds.remove(productId);
    cartList.removeWhere((p) => p.id.toString() == productId);

    try {
      await service.deleteCart(productId);
    } catch (e) {

      cartIds.add(productId);
    }
  }



  Future<void> getProductDetails() async {
    isLoading.value = true;
    if (Get.arguments != null) {
      getSelectedCategorieId.value = Get.arguments["CategoriesID"];
      getselectedName.value = Get.arguments["CategoriesName"];
    }
    //  getselectedName.value = homeController.selectedCatName.value;

    try {
      /*  final data = await apiService.getData(ApiEndPoints.getCategories);
      productList.value = data.map((e) => Products.fromJson(e)).toList();*/
      final response = await ApiService.getCategoryProducts(
        getSelectedCategorieId.value,
      );
      /*  productList.assignAll(
          response.map((e) => Products.fromJson(e)).toList());*/
      print("List length: ${productList.length}");
      if (response is List) {
        productList.assignAll(
          response.map((e) => Products.fromJson(e)).toList(),
        );
        print("List length: ${productList.length}");
      } else {
        print("API returned unexpected data: $response");
        productList.clear();
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
}
