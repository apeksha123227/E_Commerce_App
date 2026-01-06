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
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: ClipOval(
                          child: Image.network(
                            user.avatar ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/placholder.png",
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.email ?? "",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(onTap: Get.back, child: const Icon(Icons.cancel)),
          ),
          const SizedBox(height: 10),
          const Text(
            "Update Details",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
