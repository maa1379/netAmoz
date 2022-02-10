import 'dart:developer';

import 'package:ehyasalamat/Screen/NotificationScreen.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:ehyasalamat/models/InformsModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  RxList<InformsModel> informsList = <InformsModel>[].obs;
  RxBool loading = false.obs;

  getNotifications({String role}) async {
    RequestHelper.informs(role: role, token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone) {
        for (var i in value.data) {
          informsList.add(InformsModel.fromJson(i));
        }
        loading.value = true;
      } else {
        loading.value = false;
        ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
      }
    });
  }
}

class PushNotificationsController extends GetxController {
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  getNot() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String token = await messaging.getToken();
      log(token ?? '');
    } catch (e) {}
    log('firebase start');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.to(NotificationScreen());
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
  }
}
