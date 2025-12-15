import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/HomeController.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Custom_Functions {
  static Widget getTextStyle_16_blackTxt(
    String text, {
    FontWeight? fontweight,
  }) {
    return Text(
      "${text}",
      style: TextStyle(
        color: AppColors.blackText,
        fontSize: 16,
        fontWeight: fontweight,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static PreferredSizeWidget  getAppbar(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      leading: InkWell(
        onTap: Get.back,
        child: Center(
          child:
            SvgPicture.asset(
              "assets/images/back.svg",
               height: 30,
              width: 30,
            ),

        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: SvgPicture.asset("assets/images/cart.svg"),
        ),
      ],
    );
  }


}
