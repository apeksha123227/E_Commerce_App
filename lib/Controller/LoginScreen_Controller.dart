import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/LoginScreen.dart';
import 'package:e_commerce_app/Storage/AppStorage.dart';
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

  RxBool isLogin = false.obs;
  RxString email = "".obs;
  final appstorage = AppStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLogin.value = AppStorage.isLoggedIn;
    email.value = AppStorage.email;
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
        //final data = jsonDecode(response.body);

        //save user
        await AppStorage.savedLogin(email: emailController.text.trim());
        isLogin.value = true;
        email.value = emailController.text.trim();
        Get.offAll(() => HomePage());
        print("${email.value}");
        print("IS LOGGED IN: ${AppStorage.isLoggedIn}");
      } else {
        Get.snackbar("Login Failed", "Invalid credentials");
        print("Login faild");
      }
    } catch (e) {
      print(e);
    }

    isLoading.value = false;
  }

  /*

  Future<void> logout() async {
    await AppStorage.logout();
    isLogin.value = false;
    email.value = "";
    Get.offAll(() => LoginScreen());
  }
*/

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
