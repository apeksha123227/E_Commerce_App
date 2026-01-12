import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/TabBar/Account/CartController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/Firebase/FirebaseService.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Categories.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  RxList<String> bannerList = <String>[
    "assets/images/banner_1.png",
    "assets/images/banner_2.png",
    "assets/images/banner_3.png",
  ].obs;
  final FirebaseService service = FirebaseService();

  // RxString selectedId = "".obs;
  RxList<Products> productsList = <Products>[].obs;
  RxList<Categories> categoryList = <Categories>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedCategoriesId = "".obs;
  RxString txtadded = "Add to Cart".obs;
  RxString selectedCatName = "".obs;
  RxInt selectedIndex = 0.obs;
  final apiService = ApiService();

  //  final CartController cartController = Get.put(CartController());
  final searchController = TextEditingController();
  RxList<Products> filteredProducts = <Products>[].obs;
  RxList<Categories> filteredCategories = <Categories>[].obs;
  var address = ''.obs;
  RxBool showClearIcon = false.obs;
  RxSet<String> cartIds = <String>{}.obs;
  RxList<Products> cartList = <Products>[].obs;


  bool isInCart(String id) => cartIds.contains(id);

  @override
  void onInit() {
    super.onInit();
    loadCartList();
    getCurrentAddress();
    getRecentProducts();

    searchController.addListener(() {
      showClearIcon.value = searchController.text.isNotEmpty;
      searchProductsAndCategories(searchController.text);
    });
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

  Future<void> getRecentProducts() async {
    try {
      isLoading.value = true;

      final responses = await Future.wait([
        apiService.getDataApiList(
          "${ApiEndPoints.getProducts}?offset=0&limit=10",
        ),
        apiService.getDataApiList(ApiEndPoints.getCategories),
      ]);

      productsList.value = (responses[0] as List)
          .map((e) => Products.fromJson(e))
          .toList();

      categoryList.value = (responses[1] as List)
          .map((e) => Categories.fromJson(e))
          .toList();

      filteredProducts.assignAll(productsList);
      filteredCategories.assignAll(categoryList);

      print("Products & Categories loaded successfully");
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentAddress() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        address.value =
            '${place.street}, ${place.locality}, ${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}';
      }
    } catch (e) {
      address.value = "Could not get location";
      print(e);
    }
  }

  void searchProductsAndCategories(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(productsList);
      filteredCategories.assignAll(categoryList);
      return;
    }

    final search = query.toLowerCase().replaceAll(RegExp(r'\s+'), '');

    // Product search
    filteredProducts.assignAll(
      productsList.where((product) {
        return (product.title ?? '')
                .toLowerCase()
                .replaceAll(RegExp(r'\s+'), '')
                .contains(search) ||
            (product.slug ?? '').toLowerCase().contains(search);
      }),
    );

    // Category search
    filteredCategories.assignAll(
      categoryList.where((category) {
        return (category.name ?? '')
                .toLowerCase()
                .replaceAll(RegExp(r'\s+'), '')
                .contains(search) ||
            (category.slug ?? '').toLowerCase().contains(search);
      }),
    );
  }
}
