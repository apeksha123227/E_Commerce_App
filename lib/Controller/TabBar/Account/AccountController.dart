import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/LoginScreen_Controller.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Accountcontroller extends GetxController {
  RxBool isLoading = false.obs;

  Rxn<UserModel> usermodel = Rxn<UserModel>();
  final apiService = ApiService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserProfile();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
      await updateProfileWithImage();
    }
  }

  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;

      String? accesstoken = await SecureStorageHelper.instance
          .get_AccessToken();
      print("get User ${accesstoken}");
      if (accesstoken != null) {
        final user = await ApiService.getUserProfile(accesstoken);
        print("get User profile success");

        usermodel.value = user;

        nameController.text = user.name!;
        emailController.text = user.email!;

        //save userID
        await SecureStorageHelper.instance.save_UserId(
          userid: usermodel!.value!.id.toString(),
        );
        print("userId ${usermodel!.value!.id.toString()}");
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
  }) async {
    try {
      isLoading.value = true;
      String? token = await SecureStorageHelper.instance.get_AccessToken();
      String? userId = await SecureStorageHelper.instance.get_UserId();

      if (token == null || userId == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }
      if (nameController.text.trim() == usermodel.value?.name &&
          emailController.text.trim() == usermodel.value?.email) {
        Get.snackbar("Info", "No changes detected");
        return;
      }

      final response = await apiService.updateUserProfile(
        int.parse(userId),
        nameController.text.trim(),
        emailController.text.trim(),
        token,
      );

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(jsonDecode(response.body));

        usermodel.value = updatedUser;

        Get.snackbar(
          "Success",
          "Profile updated successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          "Update failed (${response.statusCode})",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Update error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfileWithImage() async {
    isLoading.value = true;

    try {
      String? token = await SecureStorageHelper.instance.get_AccessToken();
      String? userId = await SecureStorageHelper.instance.get_UserId();

      if (token == null || userId == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      if (selectedImage.value == null) {
        Get.snackbar("Error", "Please select an image first");
        return;
      }

      final response = await apiService.updateProfileImage(
        int.parse(userId),
        token,
        selectedImage.value!,
      );

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(jsonDecode(response.body));
        usermodel.value = updatedUser;

        selectedImage.value = null;

        Get.snackbar(
          "Success",
          "Profile updated successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          "Update failed (${response.statusCode})",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Update error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
