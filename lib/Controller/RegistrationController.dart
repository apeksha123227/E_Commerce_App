import 'dart:io';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/LoginScreen.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /*
  final TextEditingController conpasswordController = TextEditingController();
*/
  final TextEditingController nameController = TextEditingController();

  //final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var user = Rxn<UserModel>();
  final apiService = ApiService();
  final imagePicker = ImagePicker();
  Rx<File?> avatarFile = Rx<File?>(null);

  /*  RxString strPassword="".obs;
  RxString strConform_Password="".obs;*/

  Future<void> pickAvatar(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image != null) {
      avatarFile.value = File(image.path);
    }
  }

  Future<String> uploadAvatar() async {
    if (avatarFile.value == null) return "";

    final url = ApiEndPoints.baseUrl + ApiEndPoints.registration;

    final request = MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await MultipartFile.fromPath('avatar', avatarFile.value!.path),
    );

    await request.send();
    return "https://picsum.photos/200";
  }

  Future<void> registration() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    String avatarUrl = avatarFile.value != null
        ? "https://picsum.photos/200"
        : "";

    try {
      final response = await apiService.postData(ApiEndPoints.registration, {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "avatar": avatarUrl,
      });

      isLoading.value = false;

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Registration successful!",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAll(LoginScreen());

        print("Response: ${response.body}");
      } else {
        Get.snackbar("Registration Failed", "Invalid credentials or data");
        print("Registration failed: ${response.body}");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
