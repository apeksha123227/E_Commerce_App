import 'package:e_commerce_app/Controller/TabBar/Add_To_Cart_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Add_To_Cart extends StatelessWidget {
  const Add_To_Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    final addtocart_Controller = Get.find<Add_To_Cart_Controller>();

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: SvgPicture.asset("assets/images/back.svg"),
        ),
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

            var item = addtocart_Controller.productsDetails[0];
            return addtocart_Controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Image.network(item.images![0],
                        height: 600,
                      ),
                      Text("${item.title}"),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
