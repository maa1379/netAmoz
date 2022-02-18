import 'dart:developer';
import 'package:ehyasalamat/models/TreasureModel.dart';
import 'package:ehyasalamat/widgets/ConsultingWidget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ehyasalamat/bloc/GetDetailConsultingBloc.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:ehyasalamat/models/GetDetailTicketModel.dart';
import 'package:ehyasalamat/models/GetTicketModel.dart';

class TreasureController extends GetxController {
  @override
  void onInit() {
    getNot();
    getTicketData();
    super.onInit();
  }



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
      getTicketData();
      Get.to(ConsultingWidget());
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        getTicketData();
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


  RxList<TreasureModel> getTicketList = <TreasureModel>[].obs;

  RxString filter = "all".obs;
  RxBool isFilter = false.obs;

  getTicketData({String token}) async {
    RequestHelper.getTreasure(
        token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone) {
        getTicketList.clear();
        print("***ok***");
        for (var i in value.data) {
          getTicketList.add(TreasureModel.fromJson(i));
          // isFilter = false.obs;
        }
      } else {
        print("***error***");
      }
    });
  }
}

class DetailTreasureController extends GetxController {

  RxBool loading = false.obs;

  @override
  void onInit() {
    getDetailTicketData();
    super.onInit();
  }

  TextEditingController textController = TextEditingController();
  TreasureModel TicketList;

  getDetailTicketData() async {
    RequestHelper.getTreasureRetrieve(
        id: Get.arguments['treasure_id'].toString(),
        token: await PrefHelpers.getToken())
        .then((value) async {
      if (value.isDone) {
          TicketList = TreasureModel.fromJson(value.data);
          loading.value = true;
      } else {
          loading.value = false;
        print("***error***");
      }
    });
  }
}
