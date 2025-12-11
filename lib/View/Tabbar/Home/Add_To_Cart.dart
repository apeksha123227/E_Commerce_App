import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Add_To_Cart_Controller.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Add_To_Cart extends StatelessWidget {
  const Add_To_Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    final addtocart_Controller = Get.put(Add_To_Cart_Controller());

    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset("assets/images/back.svg"),
        title: Text(
          "Details product",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: SvgPicture.asset("assets/images/cart.svg"),
          ),
        ],
      ),
      body: Container(
        height: scrren_height,
        width: scrren_width,
        child: SingleChildScrollView(
          child: Obx(() {
            if (addtocart_Controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final item = addtocart_Controller.productsDetails.value;
            if (item == null) {
              return Center(child: Text("No product found"));
            }

            return addtocart_Controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Image.network(
                          item!.images![0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Custom_Functions.getTextStyle_16_blackTxt(
                                      "${item!.title ?? ""}",
                                      fontweight: FontWeight.w500,

                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "₹ ${item!.price ?? ""}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                SvgPicture.asset("assets/images/cart.svg")
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "choose the Products",
                              style: TextStyle(
                                color: AppColors.tabUnselectedColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
