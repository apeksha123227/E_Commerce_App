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
  Rxn<Products> productsDetails = Rxn<Products>();

  @override
  Future<void> onInit() async {
    super.onInit();

    await getProductDetails();
  }

  getProductDetails() async {
    isLoading.value = true;
    getId.value = homeController.selectedId.value;

    final response = await apiService.getData(
      "${ApiEndPoints.getProducts}/${getId.value}",
    );
    try {
      if (response.statusCode == 200) {
        print("product get success ");
        final data = jsonDecode(response.body);
        productsDetails.value = Products.fromJson(data);
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
    isLoading.value = false;
  }
}
