import 'dart:async';

import 'package:e_commerce_app/Controller/Splash_Controller.dart';
import 'package:e_commerce_app/LoginScreen.dart';
import 'package:e_commerce_app/Storage/AppStorage.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:e_commerce_app/View/DashBoard.dart';
import 'package:e_commerce_app/View/WelCome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Get.put(Splash_Controller());


    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            textAlign: TextAlign.center,
            "Welcome to E Commerce App",
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
