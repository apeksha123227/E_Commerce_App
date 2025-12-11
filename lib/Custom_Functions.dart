import 'package:e_commerce_app/AppColors.dart';
import 'package:flutter/widgets.dart';

class Custom_Functions {


 static Widget  getTextStyle_16_blackTxt(String text, {FontWeight? fontweight}) {
   return Text("${text}", style: TextStyle(
      color: AppColors.blackText,
      fontSize: 16,
      fontWeight: fontweight,
     overflow: TextOverflow.ellipsis
    ),);
  }

}