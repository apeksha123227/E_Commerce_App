import 'package:e_commerce_app/Controller/LoginScreen_Controller.dart';
import 'package:e_commerce_app/Storage/AppStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("${AppStorage.email}", style: TextStyle(fontSize: 25)),
    );
  }
}
