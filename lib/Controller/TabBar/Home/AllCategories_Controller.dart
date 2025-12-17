import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/HomeController.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Categories.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllCategories_Controller extends GetxController {


  RxList<Categories> categoryList = <Categories>[].obs;
  RxBool isLoading = false.obs;
  final homeController=Get.find<HomeController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    categoryList=homeController.categoryList;


  }
}
