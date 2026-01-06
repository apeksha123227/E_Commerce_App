import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Account/CartController.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/HomeController.dart';
import 'package:e_commerce_app/Firebase/FirebaseService.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:e_commerce_app/View/Tabbar/Account/CartScreen.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Custom_Functions {
  final FirebaseService service = FirebaseService();
  static final cartController = Get.find<CartController>();

  static Widget getTextStyle_16_blackTxt(
    String text, {
    FontWeight? fontweight,
  }) {
    return Text(
      "${text}",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.blackText,
        fontSize: 16,
        fontWeight: fontweight,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static PreferredSizeWidget getAppbar(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      leading: InkWell(
        onTap: Get.back,
        child: Center(
          child: SvgPicture.asset(
            "assets/images/back.svg",
            height: 30,
            width: 30,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Stack(
            children: [
              InkWell(
                onTap:(){
                  Get.to(Cartscreen());
                },
                  child: SvgPicture.asset("assets/images/cart.svg")),
              if (cartController.cartlist.length > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Obx(() {
                      return Text(
                        '${cartController.cartlist.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<bool> isInCart(String productId) async {
    bool value = await service.isProductInCart(productId);
    return value;
  }

  Future<void> addtoCart(Products product, int selectedIndex) async {
    List<String> selectedImage = [];
    /* final selectedImage = product.images != null && product.images!.isNotEmpty
        ? [product.images![selectedIndex]]
        : <String>[];*/
    if (product.images != null && product.images!.isNotEmpty) {
      // Clamp selectedIndex so it never goes out of range
      int index = selectedIndex.clamp(0, product.images!.length - 1);
      selectedImage = [product.images![index]];
    }

    await service.addtoCart(
      Products(
        id: product.id,
        quantity: 1,
        price: product.price,
        images: selectedImage,
        title: product.title,
        categoryName: product.category?.name,
      ),
    );
    // cartProductIds.add(product.id.toString());
  }
}
