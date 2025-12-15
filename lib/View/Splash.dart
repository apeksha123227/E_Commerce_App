import 'dart:async';

import 'package:e_commerce_app/View/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(() => const HomePage());
    });

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
