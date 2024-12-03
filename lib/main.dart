import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_test/core/network/global/dio_helper.dart';
import 'package:firebase_test/core/services/get_server_key.dart';
import 'package:firebase_test/core/network/local/shared_preference.dart';
import 'package:firebase_test/cubit/logic_cubit.dart';
import 'package:firebase_test/screens/home_screen.dart';
import 'package:firebase_test/screens/auth/login_screen.dart';
import 'package:firebase_test/firebase_options.dart';
import 'package:firebase_test/core/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPreferenceHelper.initSharedPreferenceHelper();
  await DioHelper.initDioHelper();
  await FirebaseMessaging.instance.getToken().then((value) {
    log("object $value");
    SharedPreferenceHelper.saveData(key: "tokeNotfication", value: value);
  });

  // print(SharedPreferenceHelper.getData(
  //     key:
  //         "uidUser")); // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   print('User granted permission');
  // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   print('User granted provisional permission');
  // } else {
  //   print('User declined or has not accepted permission');
  // }

  // FirebaseMessaging.onMessage.listen((value) {
  //   print(value.notification!.title);
  //   print(value.notification!.body);
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((value) {
  //   print(value.notification!.title);
  //   print(value.notification!.body);
  // });
  NotificationLocal.init();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "firebase",
        channelName: "firebase",
        channelDescription: "notification for firebase",
        importance: NotificationImportance.High,
        playSound: true,
        channelShowBadge: true,
        enableVibration: true,
        enableLights: true,
      )
    ],
  );
  await GetServerKey.getServerKeyToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SharedPreferenceHelper.getData(key: "uidUser") == null
            ? const LoginScreen()
            : const HomeScreen(),
      ),
    );
  }
}
