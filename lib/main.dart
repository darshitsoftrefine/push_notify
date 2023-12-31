import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:own_proj/api/firebase_api.dart';
import 'package:own_proj/home_page.dart';
import 'package:own_proj/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      home: HomePage(),
      routes: {
        NotificationPage.route: (context) => const NotificationPage()
      },
    );
  }
}
