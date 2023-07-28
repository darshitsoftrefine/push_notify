import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:own_proj/main.dart';
import 'package:own_proj/notification_page.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi {

  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage (RemoteMessage? message) {
    if(message == null) return;

    navigatorKey.currentState?.pushNamed(NotificationPage.route, arguments: message);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('$fCMToken');
    initPushNotifications();

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future initPushNotifications()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}