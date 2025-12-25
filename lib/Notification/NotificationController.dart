import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController extends GetxController {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    requestPermission();
    initLocalNotification();
    getFCMTOken();
    foregroundNotification();
    //backgroundNotification();
  }

  Future<void> requestPermission() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Get FCM Token
  Future<void> getFCMTOken() async {
    String? token = await firebaseMessaging.getToken();
    print(" get FCM Token => ${token}");
  }

  //Local notification init
  Future<void> initLocalNotification() async {
    AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    InitializationSettings settings = InitializationSettings(android: android);

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        if (details.payload != null) {
         // openScreen(details.payload!);
        }
      },
    );
  }

  // Navigation logic
 /*void openScreen(String type) {
     if (type == "order") {
      Get.to(() => History());
    } else
    if (type == "product") {
      Get.to(() => ProductDetail());
    }
  }*/


  // foregroundNotification

  Future<void> foregroundNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      {
         if (message.notification != null) {
          Get.snackbar(
            message.notification!.title ?? "",
            message.notification!.body ?? "",
          );
        }
 const AndroidNotificationDetails androidDetails =
            AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              importance: Importance.max,
              priority: Priority.high,
            );

        NotificationDetails details = NotificationDetails(
          android: androidDetails,
        );
        flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          details,
          payload: message.data['type'],
        );

      }
    });
  }

  // Background
  Future<void> backgroundNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
     // openScreen(message.data['type']);
    });
  }
}
