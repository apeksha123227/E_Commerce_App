import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/TabBar/HomeController.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Categories.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ViewAllProducts_By_Categorie_Controller extends GetxController {
  final homeController = Get.find<HomeController>();
  RxString getSelectedCategorieId = "".obs;
  RxBool isLoading = true.obs;
  final apiService = ApiService();
  RxList<Products> productList = <Products>[].obs;
  RxString getselectedName="".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    print(
      "Selected id is ${getSelectedCategorieId.value = homeController.selectedCategoriesId.value}",
    );
    await getProductDetails();
  }

  Future<void> getProductDetails() async {
    isLoading.value = true;
    getSelectedCategorieId.value = homeController.selectedCategoriesId.value;
    getselectedName.value = homeController.selectedCatName.value;

    try {
      /*  final data = await apiService.getData(ApiEndPoints.getCategories);
      productList.value = data.map((e) => Products.fromJson(e)).toList();*/
      final response = await ApiService.getCategoryProducts(getSelectedCategorieId.value);
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
