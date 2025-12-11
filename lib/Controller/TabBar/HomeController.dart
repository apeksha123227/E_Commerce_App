import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Model/Products.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxList<String> bannerList = <String>[
    "assets/images/banner_1.png",
    "assets/images/banner_2.png",
    "assets/images/banner_3.png",
  ].obs;
  RxString selectedId = "".obs;
  RxList<Products> productsList = <Products>[].obs;
  RxBool isLoading = false.obs;
  final apiService = ApiService();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getRcentProducts();
  }

  getRcentProducts() async {
    isLoading.value = true;
    final response = await apiService.getData(
      "${ApiEndPoints.getProducts}?offset=0&limit=10",
    );

    try {
      if (response.statusCode == 200) {
        print("product get success ");
        List<dynamic> jsonList = jsonDecode(response.body);
        productsList.value = jsonList.map((e) => Products.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error occured :- ${response.statusCode}');
    }
    isLoading.value = false;
  }
}
