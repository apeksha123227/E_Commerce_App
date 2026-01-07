import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Account/AccountController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:e_commerce_app/View/WelCome.dart';
import 'package:e_commerce_app/View/Tabbar/Account/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce_app/LoginScreen.dart';
import 'package:image_picker/image_picker.dart';

class Account extends StatelessWidget {
  Account({super.key});

  final Accountcontroller accountController = Get.put(Accountcontroller());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (accountController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final user = accountController.usermodel.value;

      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: AppColors.tabUnselectedColor,
                ),
              ),
              Column(
                children: [
                  // Show profile only if user is logged in
                  if (user != null) ...[
                    Stack(
                      children: [
                        Obx(
                          () => CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: ClipOval(
                                child:
                                    accountController.selectedImage.value !=
                                        null
                                    ? Image.file(
                                        accountController.selectedImage.value!,
                                        width: 160,
                                        height: 160,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        accountController
                                                .usermodel
                                                .value
                                                ?.avatar ??
                                            "",
                                        width: 160,
                                        height: 160,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Image.asset(
                                                "assets/images/placholder.png",
                                                width: 160,
                                                height: 160,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              Custom_Functions().showAvatarPicker(
                                onPick: accountController.pickImage,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                user.email ?? "",
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(_updateBottomSheet());
                            },
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],

                  // Show Login button ONLY if user is NOT logged in
                  if (user == null) ...[
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => LoginScreen());
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),

          // CART → always visible
          InkWell(
            onTap: () {
              Get.to(() => Cartscreen());
            },
            child: accountRows('assets/images/cart.svg', "Your Cart"),
          ),
          Divider(thickness: 0.4, color: Colors.grey.shade300),

          // LOGOUT → always visible
          user == null
              ? InkWell(
                  onTap: () async {
                    Get.to(() => LoginScreen());
                  },
                  child: accountRows('assets/images/login.svg', "Login"),
                )
              : InkWell(
                  onTap: () async {
                    await SecureStorageHelper.instance.delete_all();
                    accountController.usermodel.value = null; // reset user
                    Get.offAll(() => WelCome());
                  },
                  child: accountRows('assets/images/logout.svg', "Logout"),
                ),
        ],
      );
    });
  }

  Padding accountRows(String img, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset(img, height: 22),
          const SizedBox(width: 15),
          Custom_Functions.getTextStyle_16_blackTxt(
            text,
            fontweight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _updateBottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: Get.back,
                child: SvgPicture.asset(
                  "assets/images/close.svg",
                  color: Colors.black,
                  height: 15,
                  width: 15,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Update Details",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 20),

            Text(
              "Name",
              style: TextStyle(fontSize: 15, color: AppColors.LightGreyText),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.tabSelectedColor,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                maxLines: 1,
                controller: accountController.nameController,
                cursorColor: AppColors.tabSelectedColor,

                decoration: InputDecoration(
                  hintText: "Enter your Name",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 15),

            Text(
              "Email",
              style: TextStyle(fontSize: 15, color: AppColors.LightGreyText),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.tabSelectedColor,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                maxLines: 1,
                controller: accountController.emailController,
                cursorColor: AppColors.tabSelectedColor,

                decoration: InputDecoration(
                  hintText: "abc@gmail.com",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  }
                  final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                  if (!gmailRegex.hasMatch(value)) {
                    return "Enter a valid Gmail address";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 15),

            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    accountController.isLoading.value
                        ? null
                        : accountController.updateUserProfile(
                            name: accountController.nameController.text.trim(),
                            email: accountController.emailController.text
                                .trim(),
                          );
                    ;
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tabSelectedColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: accountController.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
