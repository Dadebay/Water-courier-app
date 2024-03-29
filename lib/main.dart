import 'dart:convert';
import 'dart:io';
import 'package:akar_suw_2/controllers/HomePageController.dart';
import 'package:akar_suw_2/models/AuthModel.dart';
import 'package:akar_suw_2/screens/HomePage.dart';
import 'package:akar_suw_2/utils/translations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/AllContollerBindings.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

final HomePageController homePageController = Get.put(HomePageController());

AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    showBadge: true);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.data["order"] == null || message.data["order"].isEmpty || message.data["order"] == "") {
    flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data["message"],
      "",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          styleInformation: const BigTextStyleInformation(''),
          color: Colors.white,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  } else {
    final responseJson = jsonDecode(message.data["order"]);
    homePageController.list.add({
      "id": responseJson["id"],
      "location": responseJson["location"],
      "phone": responseJson["phone"],
      "quantity": responseJson["quantity"],
      "status_id": responseJson["status_id"],
      "accepted_time": responseJson["accepted_time"],
      "comment": responseJson["comment"],
    });
    flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      responseJson["location"],
      responseJson["comment"],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          styleInformation: const BigTextStyleInformation(''),
          color: Colors.white,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.black,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyAppRun());
}

class MyAppRun extends StatefulWidget {
  const MyAppRun({Key? key}) : super(key: key);

  @override
  State<MyAppRun> createState() => _MyAppRunState();
}

class _MyAppRunState extends State<MyAppRun> {
  final storage = GetStorage();
  String token = "";
  getToken() async {
    final token2 = await Auth().getToken();
    if (token2 != null) {
      setState(() {
        token = token2;
      });
    } else {
      setState(() {
        token = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
    FirebaseMessaging.instance.subscribeToTopic('Events');
    FirebaseMessaging.instance.getToken().then((value) {
      homePageController.writeFirebaseToken(token: value!);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print(message.data);
      if (message.data["order"] == null || message.data["order"].isEmpty || message.data["order"] == "") {
        flutterLocalNotificationsPlugin.show(
          message.data.hashCode,
          message.data["message"],
          "",
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              styleInformation: const BigTextStyleInformation(''),
              color: Colors.white,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      } else {
        final responseJson = jsonDecode(message.data["order"]);
        homePageController.list.add({
          "id": responseJson["id"],
          "location": responseJson["location"],
          "phone": responseJson["phone"],
          "quantity": responseJson["quantity"],
          "status_id": responseJson["status_id"],
          "accepted_time": responseJson["accepted_time"],
          "comment": responseJson["comment"],
        });
        flutterLocalNotificationsPlugin.show(
          message.data.hashCode,
          responseJson["location"],
          responseJson["comment"],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              styleInformation: const BigTextStyleInformation(''),
              color: Colors.white,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.to(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      initialBinding: AllControllerBindings(),
      locale: storage.read('langCode') != null
          ? Locale(storage.read('langCode'))
          : const Locale(
              'tr',
            ),
      fallbackLocale: const Locale("tr"),
      translations: MyTranslations(),
      defaultTransition: Transition.cupertinoDialog,
      debugShowCheckedModeBanner: false,
      // home: const MyWidget(),
      home: const HomePage(),
    );
  }
}
