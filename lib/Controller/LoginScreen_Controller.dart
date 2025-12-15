import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/View/HomePage.dart';
import 'package:e_commerce_app/View/Splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen_Controller extends GetxController {
  final apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> getLogin() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final response = await apiService.postData(ApiEndPoints.getLogin, {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });
      isLoading.value = false;

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
          "Login Success",
          "Welcome back!",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAll(Splash());
      } else {
        Get.snackbar(
          "Login Failed",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
        );
        print("Login faild");
      }
    } catch (e) {
      print(e);
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
