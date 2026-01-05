import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/RegistrationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    final registration_Controller = Get.put(RegistrationController());

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: registration_Controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Registration",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: AppColors.blackText,
                    ),
                  ),

                  SizedBox(height: 50),
                  Text(
                    "Name",
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
                      controller: registration_Controller.nameController,
                      cursorColor: AppColors.tabSelectedColor,

                      decoration: InputDecoration(
                        hintText: "Name",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
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
                      controller: registration_Controller.emailController,
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
                    style: TextStyle(fontSize: 15, color: AppColors.blackText),
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
                        controller: registration_Controller.passwordController,
                        obscureText:
                            !registration_Controller.isPasswordVisible.value,
                        cursorColor: AppColors.tabSelectedColor,

                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(
                            registration_Controller.isPasswordVisible.value
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                          ),
                        ),
                        onTap: () {
                          registration_Controller.isPasswordVisible.toggle();
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
                  Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 13, color: AppColors.blackText),
                  ),
                  SizedBox(height: 20),

                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                             registration_Controller.isLoading.value
                                ? null
                                :  () async {
                               if (registration_Controller.formKey.currentState!
                                   .validate()) {
                                 await registration_Controller.registration();
                          }};
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tabSelectedColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: registration_Controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Register",
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
