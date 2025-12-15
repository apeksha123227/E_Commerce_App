import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/TabBar/HomeController.dart';
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

  // RxList<String> productImagesList = <String>[].obs;
  var imageSelectedId = "".obs;
  RxInt selectedIndex = 0.obs;
  RxBool isChecked = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await getProductDetails();
  }

  Future<void> getProductDetails() async {
    isLoading.value = true;
    // getId.value = homeController.selectedId.value;
    if (Get.arguments != null) {
      getId.value = Get.arguments["ID"];
    }

    final response = await apiService.getData(
      "${ApiEndPoints.getProducts}/${getId.value}",
    );
    try {
      if (response.statusCode == 200) {
        print("product get success ");
        final data = jsonDecode(response.body);
        productsDetails.value = Products.fromJson(data);

        // var imageList = productsDetails.value?.images ?? [];

        // if (imageList.isNotEmpty) {
        //   imageSelectedId.value = imageList[0];
        // }
        /*  if (productImagesList.isNotEmpty) {
          imageSelectedId.value = productImagesList[0];
        }*/
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
    isLoading.value = false;
  }
}
