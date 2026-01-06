import 'package:e_commerce_app/Controller/LoginScreen_Controller.dart';
import 'package:e_commerce_app/View/Registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AppColors.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final login_Controller = Get.put(LoginScreen_Controller());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: login_Controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: AppColors.blackText,
                    ),
                  ),

                  SizedBox(height: 50),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.LightGreyText,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.tabSelectedColor,
                        width: 1.5,
                      ),
                    ),
                    child: TextFormField(
                      maxLines: 1,
                      controller: login_Controller.emailController,
                      cursorColor: AppColors.tabSelectedColor,

                      decoration: InputDecoration(
                        hintText: "Email",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email required";
                        }
                        final gmailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
                        );
                        if (!gmailRegex.hasMatch(value)) {
                          return "Enter a valid Gmail address";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),

                  Text(
                    "Password",
                    style: TextStyle(fontSize: 15, color: AppColors.LightGreyText),
                  ),
                  SizedBox(height: 10),

                  Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.tabSelectedColor,
                          width: 1.5,
                        ),
                      ),
                      child: TextFormField(
                        maxLines: 1,
                        controller: login_Controller.passwordController,
                        obscureText: !login_Controller.isPasswordVisible.value,
                        cursorColor: AppColors.tabSelectedColor,

                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(
                            login_Controller.isPasswordVisible.value
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                          ),
                        ),
                        onTap: () {
                          login_Controller.isPasswordVisible.toggle();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password required";
                          }
                          return null;
                        },
                      ),
                    );
                  }),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Already have an Account ?",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.blackText,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registration(),
                            ),
                          );
                        },
                        child: Text(
                          " Create an Account ",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.tabSelectedColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            login_Controller.isLoading.value
                                ? null
                                : await login_Controller.getLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tabSelectedColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: login_Controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
