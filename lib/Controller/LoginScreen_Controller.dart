import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/LoginScreen.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:e_commerce_app/Storage/AppStorage.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:e_commerce_app/View/DashBoard.dart';
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
  var user = Rxn<UserModel>();
  final appstorage = AppStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    /* isLogin.value = AppStorage.isLoggedIn;
    email.value = AppStorage.email;*/
    // getUserfromStorage();
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
        //add token
        final data = jsonDecode(response.body);
        final accesstoken = data['access_token'];
        final refreshtoken = data['refresh_token'];
        await SecureStorageHelper.instance.save_Token(
          accesstoken: accesstoken,
          refreshtoken: refreshtoken,
        );
        print("LOGIN CONTROLLER ACCESS TOKEN: ${accesstoken}");
        print("LOGIN CONTROLLER REFRESH TOKEN: ${refreshtoken}");

        //save User
        final userModel = UserModel.fromJson(data);
        await SecureStorageHelper.instance.saveUserDetails(userModel);
        user.value = userModel;
        print("User Save ${user.value?.name}");

        await Get.offAll(() => DashBoard());
      } else {
        Get.snackbar("Login Failed", "Invalid credentials");
        print("Login faild");
      }
    } catch (e) {
      print(e);
    }

    isLoading.value = false;
  }
}
