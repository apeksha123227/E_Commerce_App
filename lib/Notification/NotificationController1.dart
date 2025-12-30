import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:e_commerce_app/View/Tabbar/Wishlist/Wishlist.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController1 extends GetxService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<NotificationController1> init() async {
    await requestPermission();
    await initLocalNotification();
    await getFCMToken();
    foregroundNotification();
    backgroundNotification();
    return this;
  }

  // Permission
  Future<void> requestPermission() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // FCM Token
  Future<String?> getFCMToken() async {
    String? token = await firebaseMessaging.getToken();
    print("FCM Token => $token");
    return token;
  }

  // Local Notification Init
  Future<void> initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          openScreen(details.payload!);
        }
      },
    );

    // Create channel (IMPORTANT)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel',
      'General',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  // Foreground Notification
  void foregroundNotification() {
    FirebaseMessaging.onMessage.listen((message) {
      showLocalNotification(message);
    });
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const android = AndroidNotificationDetails(
      'default_channel',
      'General',
      importance: Importance.high,
      priority: Priority.high,
    );

    const ios = DarwinNotificationDetails();

    await flutterLocalNotificationsPlugin.show(
      id,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(android: android, iOS: ios),
      payload: message.data['type'],
      // payload: "product",
    );
  }

  // Background
  void backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      openScreen(message.data['type']);
    });
  }

  // Navigation
  void openScreen(String type) {
    if (type == "product") {
      Get.to(() => ProductDetail());
    }
    else{
      if (type == "wishlist") {
        Get.to(() => Wishlist());
      }
    }
  }
}
