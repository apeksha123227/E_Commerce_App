import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  //final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var user = Rxn<UserModel>();
  final apiService = ApiService();

  Future<void> registration() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final response = await apiService.postData(ApiEndPoints.registration, {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });
      isLoading.value = false;

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Registration successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
        print("Error: ${response.body}");
      } else {
        Get.snackbar("Registration Failed", "Invalid credentials");
        print("Registration failed");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    }

    isLoading.value = false;
  }
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}
