import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController extends GetxService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<NotificationController> init() async {
      requestPermission();
 await   initLocalNotification();
    getFCMTOken();
    foregroundNotification();
    //backgroundNotification();
    return this;
  }

   Future<void> requestPermission() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Get FCM Token
  Future<String?> getFCMTOken() async {
    String? token = await firebaseMessaging.getToken();
    print(" get FCM Token => ${token}");
    return token;
  }

  //Local notification init
  Future<void> initLocalNotification() async {
    const AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const InitializationSettings settings = InitializationSettings(
      android: android,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
     /* onDidReceiveBackgroundNotificationResponse: (details) {
        if (details.payload != null) {
          // openScreen(details.payload!);
        }
      },*/
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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      {
       /* if (message.notification != null) {
          Get.snackbar(
            message.notification!.title ?? "",
            message.notification!.body ?? "",
          );
        }*/
        const AndroidNotificationDetails androidDetails =
            AndroidNotificationDetails(
              'default_channel',
              'General',
              importance: Importance.high,
              priority: Priority.high,
            );

        NotificationDetails details = NotificationDetails(
          android: androidDetails,
        );
      await  flutterLocalNotificationsPlugin.show(
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
