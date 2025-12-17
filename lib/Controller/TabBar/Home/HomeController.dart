import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Categories.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxList<String> bannerList = <String>[
    "assets/images/banner_1.png",
    "assets/images/banner_2.png",
    "assets/images/banner_3.png",
  ].obs;

 // RxString selectedId = "".obs;
  RxList<Products> productsList = <Products>[].obs;
  RxList<Categories> categoryList = <Categories>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedCategoriesId = "".obs;
  RxString selectedCatName="".obs;


  final apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    getRecentProducts();
  }

  Future<void> getRecentProducts() async {
    try {
      isLoading.value = true;

      final responses = await Future.wait([
        apiService.getDataApiList("${ApiEndPoints.getProducts}?offset=0&limit=10"),
        apiService.getDataApiList(ApiEndPoints.getCategories),
      ]);

      productsList.value = (responses[0] as List)
          .map((e) => Products.fromJson(e))
          .toList();

      categoryList.value = (responses[1] as List)
          .map((e) => Categories.fromJson(e))
          .toList();

      print("Products & Categories loaded successfully");
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
