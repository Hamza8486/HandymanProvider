import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider_app/main.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/Home/view/home_view.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationService {
  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    //Initialization Settings for iOS
    //  IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );
    //Initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        // iOS: initializationSettingsIOS

    );
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
   );
  }
  onSelectNotification(String? payload) async {
    log(payload.toString());
    log(globalValue.toString());
    if(payload.toString()=="NewJob" ){
      Get.put(ProfileController()).searchJobData("all", Get.put(ProfileController()).userId.value);
      Get.offAll(PersisNavBar(currentIndex: 0));
    }
    else if(payload.toString()=="ProviderSelect"){
      Get.offAll(PersisNavBar(currentIndex: 0));
      Get.put(ProfileController()).notData();
      Get.put(BidsController()).bidData(Get.put(ProfileController()).userId.value);
      Get.put(BidsController()).rejectData(Get.put(ProfileController()).userId.value);

    }
    else if(payload.toString()=="reviewProvider"){
      Get.offAll(PersisNavBar(currentIndex: 0));
      Get.put(BidsController()).bidData(Get.put(ProfileController()).userId.value);
      Get.put(BidsController()).rejectData(Get.put(ProfileController()).userId.value);
      Get.put(ProfileController()).profData(Get.put(ProfileController()).userId.value);
      Get.put(ProfileController()).profBusinessData(Get.put(ProfileController()).userId.value);

    }
    else if(payload.toString()=="ProfileActive"){
      Get.put(ProfileController()).profBusinessData(Get.put(ProfileController()).userId.value);
      Get.put(ProfileController()).notData();

    }
    else{
      Get.put(ProfileController()).chatData();
      Get.put(ProfileController()).notData();
    }
  }
  requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  Future<void> showNotifications({id, title, body, var payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        icon: ('@mipmap/ic_launcher'),
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }
  Future<void> scheduleNotifications({id, title, body, time}) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(time, tz.local),
          const NotificationDetails(
              // iOS: IOSNotificationDetails(subtitle: ""),
              android: AndroidNotificationDetails(
                  'your channel id', 'your channel name',
                  channelDescription: 'your channel description')),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      print(e);
    }
  }
}