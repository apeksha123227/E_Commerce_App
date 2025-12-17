import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/AllCategories_Controller.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/View/Tabbar/Home/ViewAllProducts_By_Categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    final all_Categories = Get.put(AllCategories_Controller());
    return Scaffold(
      appBar: Custom_Functions.getAppbar("All Categories"),
      body: Container(
        height: scrren_height,
        width: scrren_width,
        child: Obx(() {
          return all_Categories.categoryList.isEmpty &&
                  all_Categories.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: all_Categories.categoryList.length,
                    itemBuilder: (context, index) {
                      final item = all_Categories.categoryList[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(
                                ViewAllProducts_By_Categorie(),
                                arguments: {
                                  "CategoriesID": item.id.toString(),
                                  "CategoriesName": item.name.toString(),
                                },
                              );
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(right: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  item.image ?? "",
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return /*Image.network(
                                      "https://via.placeholder.com/150",
                                    );*/
                                      Image.asset( "assets/images/placholder.png",fit: BoxFit.fill,);
                                    //Container();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: 50,
                            child: Text(
                              textAlign: TextAlign.center,
                              item.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.tabUnselectedColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
        }),
      ),
    );
  }
}
