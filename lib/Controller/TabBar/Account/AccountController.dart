import 'dart:convert';

import 'package:e_commerce_app/Api/ApiService.dart';
import 'package:e_commerce_app/Controller/LoginScreen_Controller.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:get/get.dart';

class Accountcontroller extends GetxController {
  RxBool isLoading = false.obs;

  Rxn<UserModel> usermodel = Rxn<UserModel>();
  final apiService = ApiService();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserProfile();
  }


  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;

      String? accesstoken = await SecureStorageHelper.instance
          .get_AccessToken();
      print("get User ${accesstoken}");
      if (accesstoken != null) {
        usermodel.value = await ApiService.getUserProfile(accesstoken);
        print("get User profile success");
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
}
