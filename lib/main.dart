import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notifications/empty_page.dart';
import 'package:flutter_push_notifications/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.instance.getToken().then((value) {
    print("getToken : $value");
  });

  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      Navigator.pushNamed(
        navigatorKey.currentState!.context,
        '/push-page',
        arguments: {"message", json.encode(message.data)},
      );
    },
  );

  FirebaseMessaging.instance.getInitialMessage().then(
    (RemoteMessage? message) {
      if (message != null) {
        Navigator.pushNamed(
          navigatorKey.currentState!.context,
          '/push-page',
          arguments: {"message", json.encode(message.data)},
        );
      }
    },
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("_firebaseMessagingBackgroundHandler: $message");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      routes: {
        '/': ((context) => const EmptyPage()),
        '/push-page': ((context) => const HomePage()),
      },
    );
  }
}
