import 'dart:ffi';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/HomeController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/Firebase/FirebaseService.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Categories.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product_Detail_Controller extends GetxController {
  final homeController = Get.find<HomeController>();

  RxString getId = "".obs;
  RxBool isLoading = true.obs;
  final apiService = ApiService();
  Rxn<Products> productsDetails = Rxn<Products>();
  final FirebaseService service = FirebaseService();
  RxSet<String> cartIds = <String>{}.obs;
  RxList<Products> cartList = <Products>[].obs;
  bool isInCart(String id) => cartIds.contains(id);
  RxInt selectedIndex = 0.obs;
  RxBool isChecked = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
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
    // getId.value = homeController.selectedId.value;
    if (Get.arguments != null) {
      getId.value = Get.arguments["ID"].toString();
    }

    final response = await apiService.getData(
      "${ApiEndPoints.getProducts}/${getId.value}",
    );
    try {
      if (response.statusCode == 200) {
        print("product get success ");
        final data = jsonDecode(response.body);
        productsDetails.value = Products.fromJson(data);
        await getwishlist();
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
    isLoading.value = false;
  }

  //add

  /*Future<void> addWishList({
    required String productId,
    required String title,
    required String price,
   // required String images,
    // required String catrgorie
  }) async {
    await service.addWishListCollection(
      Products(
        id: int.parse(productId),
        */ /*   description: description,*/ /*
        price: int.parse(price),
        title: title,

      //  images: images,
      ),
    );
    isChecked.value = true;
    await getwishlist();
  }
*/
  Future<void> addWishList() async {
    if (productsDetails.value == null) return;

    final product = productsDetails.value!;
      final selectedImage = product.images != null && product.images!.isNotEmpty
        ? [product.images![selectedIndex.value]]
        : <String>[];
// String  selectedImage= product.images![selectedIndex.value];

    await service.addWishListCollection(
      Products(
        id: product.id,
        title: product.title,
        price: product.price,
        images: selectedImage,
        categoryName: product.category?.name,
      ),
    );
  }

  //get

  Future<void> getwishlist() async {
    if (productsDetails.value == null) return;
    final productId = productsDetails.value!.id.toString();
    isChecked.value = await service.isProductInWishlist(productId);
    /* isLoading.value = true;
    productsDetails.value = service.getwishlist() as Products?;
    isLoading.value = false;*/
  }

  //delete

  Future<void> removefrowishlist(String id) async {
    await service.deleteUser(id);
    isChecked.value = false;
  }

 /* Future<bool> isInCart(String productId) {
    return service.isProductInCart(productId);
  }

  Future<void> addtoCart(Products product) async {
    final selectedImage = product.images != null && product.images!.isNotEmpty
        ? [product.images![selectedIndex.value]]
        : <String>[];
    await service.addtoCart(
      Products(
        id: product.id,
        quantity: 1,
        price: product.price,
        images: selectedImage,
        title: product.title,
        categoryName: product.category?.name,
      ),
    );
    // cartProductIds.add(product.id.toString());
  }
*/
}
