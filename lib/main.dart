
import 'package:e_commerce_app/Notification/NotificationController1.dart';
import 'package:e_commerce_app/View/Registration.dart';
import 'package:e_commerce_app/View/Splash.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

 Get.put(NotificationController1()).init();
  Stripe.publishableKey = "pk_test_xxxxxxxxxxxxxxxxx";
  await Stripe.instance.applySettings();


//  Get.put(HomeController(), permanent: true);
 // Get.put(CartController()/*, permanent: true*/);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: Splash());
  }
}
