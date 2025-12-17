import 'package:e_commerce_app/Controller/LoginScreen_Controller.dart';
import 'package:e_commerce_app/Storage/AppStorage.dart';
import 'package:e_commerce_app/View/DashBoard.dart';
import 'package:e_commerce_app/View/Splash.dart';
import 'package:e_commerce_app/View/WelCome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await AppStorage.init();

  //Get.put(LoginScreen_Controller());

 // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //dart pub global run flutterfire_cli:flutterfire configure
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: Splash());
  }
}
