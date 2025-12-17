import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Storage/AppStorage.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:e_commerce_app/View/DashBoard.dart';
import 'package:e_commerce_app/View/WelCome.dart';
import 'package:get/get.dart';

class Splash_Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    String? accesstoken = await SecureStorageHelper.instance.get_AccessToken();

    if (accesstoken != null && accesstoken.isNotEmpty) {
      Get.offAll(() => DashBoard());
    } else {
      Get.offAll(() => WelCome());
    }
  }
}
