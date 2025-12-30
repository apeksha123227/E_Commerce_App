import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/LoginScreen_Controller.dart';
import 'package:e_commerce_app/Controller/TabBar/Account/AccountController.dart';
import 'package:e_commerce_app/Controller/TabBar/Cart/CartController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/Storage/AppStorage.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:e_commerce_app/View/WelCome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce_app/View/Tabbar/Account/CartScreen.dart';

import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';

class Account extends StatelessWidget {
  Account({super.key});

  final accountController = Get.put(Accountcontroller());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var item = accountController.usermodel.value;

      if (accountController.isLoading.value) {
        return CircularProgressIndicator();
      }

      print("Usre NAME${item!.name.toString()}");
      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 300,
                //color: AppColors.tabSelectedColor,
                decoration: BoxDecoration(color: AppColors.tabUnselectedColor),
              ),

              Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: ClipOval(
                        child: Image.network(
                          item!.avatar ?? "",
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
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.email.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(width: 15),
                      InkWell(
                        onTap: () async {
                          await Get.bottomSheet(
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 30,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Icon(
                                            Icons.cancel,
                                            color: AppColors.tabSelectedColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        "Update Details",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.tabUnselectedColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.mode_edit, color: Colors.white),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
          SizedBox(height:30),
          InkWell(
            onTap: () async {
              Get.to(Cartscreen());
            },
            child: accountRows('assets/images/cart.svg',"Your Cart"),
          ),
          InkWell(
            onTap: () async {
              await SecureStorageHelper.instance.delete_all();
              Get.offAll(WelCome());
            },
            child: accountRows('assets/images/cart.svg',"logout"),

          ),
        ],
      );
    });
  }

  Padding accountRows(String img,String text) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Row(
              children: [
                /* Icon(
                  Icons.cart,
                  color: AppColors.tabSelectedColor,
                  size: 20,
                ),*/
                SvgPicture.asset(img),
                SizedBox(width: 15),
                Custom_Functions.getTextStyle_16_blackTxt(
                  text,
                  fontweight: FontWeight.w500,
                ),
              ],
            ),
          );
  }
}
