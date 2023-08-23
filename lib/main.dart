import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider_app/Services/fcm/local_notification.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/Home/view/home_view.dart';
import 'package:provider_app/screens/Splash_Screen/splash_view.dart';
import 'package:provider_app/screens/auth/login/View/login_view.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
String globalValue = "";
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<bool> checkSharedPreferenceExists() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool exists = prefs.containsKey('id'); // Replace 'your_key' with the actual key you want to check
  return exists;
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  checkSharedPreferenceExists();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });


  await Firebase.initializeApp();
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(Application());
}


int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String? token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkSharedPreferenceExists(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate
            ],
            supportedLocales: [
              const Locale('en', 'US'), // English
              const Locale('ru', 'RU'), // Russian
              // Add more locales if needed
            ],
            locale: const Locale('ru', 'RU'),
            title: 'Provider App',
            home:  PersisNavBar(currentIndex: 0),
          );
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate
            ],
            supportedLocales: [
              const Locale('en', 'US'), // English
              const Locale('ru', 'RU'), // Russian
              // Add more locales if needed
            ],
            locale: const Locale('ru', 'RU'),
            title: 'Provider App',
            home: LoginScreen(),
          );
        }
      },
    );
  }
}

/// Renders the example application.
class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {

  String? _token;
  String FCM_TOKEN = "";
  bool isNotification = false;

  late Stream<String> _tokenStream;

  void setToken(String? token) {
    log('FCM Token: $token');
    setState(() {
      _token = token;
      FCM_TOKEN = token!;
    });
    debugPrint('******************************************');
    debugPrint('FCM Token: ${FCM_TOKEN}');
    debugPrint('******************************************');
  }

  void messagePop() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('A new onMessageOpenedApp event was published!     $message');
    });
  }

  @override
  void initState() {
    super.initState();
    messagePop();
    log("Hamza Not...");
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {}
    });
    log("Hamza All...");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Received...");
      log("Hamza NOTI...");


      if(message.data["type"]=="provider" && message.data["key1"]=="ProfileActive")
      {
        debugPrint("Hamza...");
        Get.put(ProfileController()).profBusinessData(Get.put(ProfileController()).userId.value);
        Get.put(ProfileController()).notData();


      }
      else if(message.data["type"]=="provider" && message.data["key1"]=="NewJob"){
        Get.put(ProfileController()).searchJobData("all", Get.put(ProfileController()).userId.value);
        Get.offAll(PersisNavBar(currentIndex: 0));

      }
      else if(message.data["type"]=="provider" && message.data["key1"]=="ProviderSelect"){
        Get.offAll(PersisNavBar(currentIndex: 0));
        Get.put(ProfileController()).notData();
        Get.put(BidsController()).bidData(Get.put(ProfileController()).userId.value);
        Get.put(BidsController()).rejectData(Get.put(ProfileController()).userId.value);

      }
      else if(message.data["type"]=="provider" && message.data["key1"]=="rejectProvider"){
        Get.put(BidsController()).bidData(Get.put(ProfileController()).userId.value);
        Get.put(BidsController()).rejectData(Get.put(ProfileController()).userId.value);

      }
      else if(message.data["type"]=="provider" && message.data["key1"]=="reviewProvider"){
        Get.put(BidsController()).bidData(Get.put(ProfileController()).userId.value);
        Get.put(BidsController()).rejectData(Get.put(ProfileController()).userId.value);
        Get.put(ProfileController()).profData(Get.put(ProfileController()).userId.value);
        Get.put(ProfileController()).profBusinessData(Get.put(ProfileController()).userId.value);

      }
      else if(message.data["type"]=="user" && message.data["key"]=="token"){
        Get.put(ProfileController()).chatData();
        Get.put(ProfileController()).notData();

      }

      log(message.data.toString());
      log(message.toString());
      log(message.data.toString());

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        NotificationService().showNotifications(
            id: 1,
            title: message.notification!.title,
            body: message.notification!.body,
          payload: message.data["key1"]

        );
        globalValue =message.data["key1"];
        setState(() {
          isNotification = true;
          //ApiConstants.bidSlug = message.data["bid"].toString();
        });
        log("Hamza...Sabir");
        log("hy");
        log(isNotification.toString());
        log(isNotification.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}
