import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Add_To_Cart_Controller.dart';
import 'package:e_commerce_app/Controller/TabBar/HomeController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Add_To_Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    final home_Controller = Get.put(HomeController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: scrren_height,
          width: scrren_width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery address",
                            style: TextStyle(
                              color: AppColors.LightGreyText,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            "Delivery address",
                            style: TextStyle(
                              color: AppColors.blackText,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        'assets/images/cart.svg',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 15),
                      SvgPicture.asset(
                        'assets/images/Notification.svg',
                        width: 22,
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    cursorColor: AppColors.tabUnselectedColor,
                    decoration: InputDecoration(
                      hintText: "Search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.tabUnselectedColor,
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: AppColors.LightGreyText, // hint text color
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.tabUnselectedColor,
                      fontSize: 15, // text color
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Obx(() {
                return SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: home_Controller.bannerList.length,
                      itemBuilder: (context, index) {
                        final item = home_Controller.bannerList[index];
                        return Container(
                          width: 260,
                          margin: EdgeInsets.only(right: 3),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(item, fit: BoxFit.fill),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Custom_Functions.getTextStyle_16_blackTxt(
                  "Category",
                  fontweight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Obx(() {
                      return Expanded(
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: home_Controller.bannerList.length,
                              itemBuilder: (context, index) {
                                final item = home_Controller.bannerList[index];
                                return Container(
                                  width: 50,
                                  margin: EdgeInsets.only(right: 3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(item, fit: BoxFit.fill),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    Spacer(),
                    Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/All.svg',
                          width: 45,
                          height: 45,
                        ),
                        Text(
                          "All",
                          style: TextStyle(
                            color: AppColors.tabUnselectedColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Custom_Functions.getTextStyle_16_blackTxt(
                      "Recent product",
                      fontweight: FontWeight.w500,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        /* Text(
                          "Filters",
                          style: TextStyle(
                            color: AppColors.blackText,
                            fontSize: 16,
                          ),
                        ),*/
                        Custom_Functions.getTextStyle_16_blackTxt("text"),
                        SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/images/Filter.svg',
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              /*Obx(() {
                return home_Controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: home_Controller.productsList.length,
                          itemBuilder: (context, index) {
                            var item = home_Controller.productsList[index];
                            String imageUrl = "";
                            if (item.images != null &&
                                item.images!.isNotEmpty &&
                                item.images![0] != null &&
                                item.images![0].toString().startsWith("http")) {
                              imageUrl = item.images![0];
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),

                                    child: Image.network(
                                      imageUrl,
                                      // item.images![0],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          " ${item.title}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.blackText,
                                          ),
                                        ),
                                        Text(
                                          " ${item.price}",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: AppColors.blackText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.tabSelectedColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Add to Cart",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
              }),*/
              Obx(() {
                return home_Controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: home_Controller.productsList.length,
                          itemBuilder: (context, index) {
                            var item = home_Controller.productsList[index];

                            String imageUrl = "";
                            if (item.images != null &&
                                item.images!.isNotEmpty &&
                                item.images![0] != null &&
                                item.images![0].toString().startsWith("http")) {
                              imageUrl = item.images![0];
                            } else {
                              imageUrl = "https://via.placeholder.com/150";
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Container(
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // IMAGE
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        imageUrl,
                                        height: 120,
                                        width: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title ?? "No Title",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.blackText,
                                            ),
                                          ),

                                          SizedBox(height: 4),

                                          Text(
                                            "₹ ${item.price}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.blackText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(height: 8),

                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.tabSelectedColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                home_Controller
                                                    .selectedId
                                                    .value = item.id
                                                    .toString();
                                                Get.to(Add_To_Cart());
                                              },
                                              child: Text(
                                                "Add to Cart",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
