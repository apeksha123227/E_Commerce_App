import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Account/CartController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/View/Tabbar/Account/Payment.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Cartscreen extends StatelessWidget {
  Cartscreen({super.key});

  final cart_Controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Custom_Functions.getAppbar("Your Cart"),
      body: Container(
        height: scrren_height,
        width: scrren_width,
        child: Column(
          children: [
            Divider(thickness: 0.4, color: Colors.grey.shade300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Custom_Functions.getTextStyle_16_blackTxt(
                      "Delivery to",
                    ),
                  ),
                  Obx(() {
                    return Expanded(
                      child:  Text(
                        "${cart_Controller.homeController.address.value}",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color:
                          AppColors.tabUnselectedColor,
                          fontSize: 14,
                        ),
                      ),
                      /*Custom_Functions.getTextStyle_16_blackTxt(
                        "${cart_Controller.homeController.address.value}",
                      ),*/
                    );
                  }),
                ],
              ),
            ),
            Divider(thickness: 0.4, color: Colors.grey.shade300),
            Expanded(
              child: Obx(() {
                return cart_Controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : cart_Controller.cartlist.isEmpty
                    ? const Center(child: Text("Your cart is empty"))
                    : RefreshIndicator(
                        onRefresh: () async =>
                            await cart_Controller.loadCartList(),

                        child: ListView.builder(
                          itemCount: cart_Controller.cartlist.length,
                          itemBuilder: (context, index) {
                            final item = cart_Controller.cartlist[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("Cart Id ${item.id.toString()}");
                                      Get.to(
                                        ProductDetail(),
                                        arguments: {"ID": item.id},
                                      );
                                    },
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          item.images![0],
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/images/placholder.png",
                                                  fit: BoxFit.fill,
                                                );
                                              },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Custom_Functions.getTextStyle_16_blackTxt(
                                            item!.title ?? "",
                                            fontweight: FontWeight.w500,
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            item.categoryName ?? "",
                                            style: TextStyle(
                                              color:
                                                  AppColors.tabUnselectedColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Expanded(
                                                child:
                                                    Custom_Functions.getTextStyle_16_blackTxt(
                                                      item!.price.toString(),
                                                      fontweight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  cart_Controller.decrement(
                                                    item.id!,
                                                  );
                                                  if (cart_Controller
                                                          .quantity ==
                                                      1) {
                                                    cart_Controller
                                                        .removeFromCart(
                                                          item.id.toString(),
                                                          index,
                                                        );
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 0.6, // lite stroke
                                                    ),
                                                  ),
                                                  child: /* SvgPicture.asset(
                                                    "assets/images/delete.svg",
                                                    height: 17,
                                                    width: 17,
                                                    color: AppColors
                                                        .tabUnselectedColor,
                                                  ),*/ Icon(
                                                    Icons.remove,
                                                    color: AppColors
                                                        .tabUnselectedColor,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Custom_Functions.getTextStyle_16_blackTxt(
                                                item.quantity.toString(),
                                              ),
                                              SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  cart_Controller.increment(
                                                    item.id!,
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 0.6, // lite stroke
                                                    ),
                                                  ),
                                                  child: /*SvgPicture.asset(
                                                    "assets/images/delete.svg",
                                                    height: 17,
                                                    width: 17,
                                                    color: AppColors
                                                        .tabUnselectedColor,
                                                  ),*/ Icon(
                                                    Icons.add,
                                                    color: AppColors
                                                        .tabUnselectedColor,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              //  if (item.quantity == 1)
                                              InkWell(
                                                onTap: () {
                                                  cart_Controller
                                                      .removeFromCart(
                                                        item.id.toString(),
                                                        index,
                                                      );
                                                  Get.snackbar(
                                                    '',
                                                    ' Successfully Deleted',
                                                  );
                                                },

                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 0.6, // lite stroke
                                                    ),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/images/delete.svg",
                                                    height: 17,
                                                    width: 17,
                                                    color: AppColors
                                                        .tabUnselectedColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
              }),
            ),

            //   cart_Controller.cartlist.isEmpty? SizedBox():
            Obx(() {
              return cart_Controller.cartlist.isEmpty
                  ? SizedBox()
                  : Card(
                      elevation: 3,
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Theme(
                                data: Theme.of(Get.context!).copyWith(
                                  dividerColor:
                                      Colors.transparent, // 👈 hides line
                                ),
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  title:
                                      Custom_Functions.getTextStyle_16_blackTxt(
                                        "Order Summary ",
                                        fontweight: FontWeight.bold,
                                      ),
                                  children: [
                                    // SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Apply Coupon : ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  AppColors.tabUnselectedColor,
                                            ),
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {
                                            showApplyCouponBottomSheet(
                                              cart_Controller,
                                            );
                                          },
                                          child: Obx(() {
                                            return cart_Controller
                                                    .appliedCoupon
                                                    .value
                                                    .isEmpty
                                                ? Icon(
                                                    Icons.card_giftcard,
                                                    color: AppColors
                                                        .tabSelectedColor,
                                                    size: 20,
                                                  )
                                                : InkWell(
                                                    onTap: cart_Controller
                                                        .removeCoupon,
                                                    child: Text(
                                                      "REMOVE",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  );
                                          }),
                                        ),
                                      ],
                                    ),

                                    /*   Obx(() {
                                if (cart_Controller.appliedCoupon.value.isEmpty) return SizedBox();
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Coupon (${cart_Controller.appliedCoupon.value})",
                                        style: TextStyle(color: AppColors.tabUnselectedColor),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: cart_Controller.removeCoupon,
                                      child: Text(
                                        "REMOVE",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),*/
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Total items : (${cart_Controller.cartlist.length})",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  AppColors.tabUnselectedColor,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "₹${cart_Controller.calculateTotal()}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.tabUnselectedColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Platform Charge ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  AppColors.tabUnselectedColor,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "₹${cart_Controller.platformchrage}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.tabUnselectedColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Coupon :",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  AppColors.tabUnselectedColor,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "₹${cart_Controller.appliedCoupon.value}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.tabUnselectedColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Total Price ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  AppColors.tabUnselectedColor,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "₹${cart_Controller.finalAmount()}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.tabUnselectedColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                      Payment(),
                                      arguments: {
                                        "Price": cart_Controller
                                            .finalAmount()
                                            .toString(),
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.tabSelectedColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: AppColors.LightGreyText,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      "Proceed to Payment",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

void showApplyCouponBottomSheet(CartController cartController) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Apply Coupon",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
            ],
          ),

          const SizedBox(height: 15),

          /// Coupon Input
          TextField(
            controller: cartController.couponController,
            decoration: InputDecoration(
              hintText: "Enter coupon code",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: TextButton(
                onPressed: () {},
                child: InkWell(
                  onTap: () {
                    cartController.applyCoupon(
                      cartController.couponController.text.trim(),
                    );
                  },
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text("APPLY"),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Available Coupons",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          couponTile("SAVE10", "10% off above ₹500", cartController),
          couponTile("FLAT50", "Flat ₹50 off", cartController),
          // couponTile("FREESHIP", "you get Free delivery", cartController),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

Widget couponTile(String code, String desc, CartController controller) {
  return Card(
    child: ListTile(
      title: Text(code, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(desc),
      trailing: TextButton(
        child: Text("APPLY"),
        onPressed: () {
          controller.applyCoupon(code);
          Get.back();
        },
      ),
    ),
  );
}
