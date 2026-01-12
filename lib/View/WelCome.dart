import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/WelCome_Controller.dart';
import 'package:e_commerce_app/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelCome extends StatelessWidget {
   WelCome({super.key});
  final welcomeController =Get.put(WelCome_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: AppColors.blackText,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to E Commerce App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.tabUnselectedColor,
                ),
              ),
              SizedBox(height: 50),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(LoginScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tabSelectedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: AppColors.tabSelectedColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.tabSelectedColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Sign Up Using",
                style: TextStyle(
                  color: AppColors.tabUnselectedColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
