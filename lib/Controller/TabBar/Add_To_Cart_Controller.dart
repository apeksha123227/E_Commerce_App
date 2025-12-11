import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/TabBar/HomeController.dart';
import 'package:e_commerce_app/Model/Products.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Add_To_Cart_Controller extends GetxController {
  final homeController = Get.find<HomeController>();

  RxString getId = "".obs;
  RxBool isLoading = true.obs;
  final apiService = ApiService();
  RxList<Products> productsDetails = <Products>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getProductDetails();
  }

  getProductDetails() async {
    isLoading.value = true;
    final response = await apiService.getData(
        "${ApiEndPoints.getProducts}/${getId.value}"
    );
    try {
      if (response.statusCode == 200) {
        print("product get success ");
        List<dynamic> jsonList = jsonDecode(response.body);
        productsDetails.value = jsonList.map((e) => Products.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error occured :- ${response.statusCode}');
    }
    isLoading.value = false;
  }
}


