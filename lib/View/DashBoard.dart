import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/DashboardController.dart';
import 'package:e_commerce_app/View/Tabbar/Account/Account.dart';
import 'package:e_commerce_app/View/Tabbar/History.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Home.dart';
import 'package:e_commerce_app/View/Tabbar/Wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});
  final dashboard_Controller = Get.put(DashBoardController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    final screen_width = MediaQuery.of(context).size.width;
    final screen_height = MediaQuery.of(context).size.height;

    final screens = [Home(), Wishlist(), History(), Account()];

    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: dashboard_Controller.selectedIndex.value,
          onTap: dashboard_Controller.changeIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.tabSelectedColor,
          unselectedItemColor: AppColors.tabUnselectedColor ,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/Home.svg',
                color: dashboard_Controller.selectedIndex.value == 0
                    ? AppColors.tabSelectedColor
                    : AppColors.tabUnselectedColor,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/wishlist.svg',
                color: dashboard_Controller.selectedIndex.value == 1
                    ? AppColors.tabSelectedColor
                    :AppColors.tabUnselectedColor,
              ),
              label: "Wishlist",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/History.svg',
                color: dashboard_Controller.selectedIndex.value == 2
                    ? AppColors.tabSelectedColor
                    : AppColors.tabUnselectedColor,
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/Profile.svg',
                color: dashboard_Controller.selectedIndex.value == 3
                    ? AppColors.tabSelectedColor
                    :AppColors.tabUnselectedColor,
              ),
              label: "Account",
            ),
          ],
        ),
        body: screens[dashboard_Controller.selectedIndex.value],
      ),
    );
  }
}
