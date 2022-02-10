import 'dart:developer';

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

class ConsultingController extends GetxController {
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


  RxList<GetTicketModel> getTicketList = <GetTicketModel>[].obs;

  RxString filter = "all".obs;
  RxBool isFilter = false.obs;

  getTicketData({String token, String filters = "all"}) async {
    RequestHelper.getTickets(
            token: await PrefHelpers.getToken(), filter: filters)
        .then((value) {
      if (value.isDone) {
        getTicketList.clear();
        print("***ok***");
        for (var i in value.data) {
          getTicketList.add(GetTicketModel.fromJson(i));
          // isFilter = false.obs;
        }
      } else {
        print("***error***");
      }
    });
  }
}

class DetailConsultingController extends GetxController {
  @override
  void onInit() {
    TicketList.clear();
    getDetailTicketData();
    EasyLoading.show(
        dismissOnTap: true, indicator: CircularProgressIndicator());
    super.onInit();
  }

  TextEditingController textController = TextEditingController();
  RxList<AnswerList> TicketList = <AnswerList>[].obs;

  getDetailTicketData() async {
    RequestHelper.getDetailTicket(
            id: Get.arguments['ticket_id'].toString(),
            token: await PrefHelpers.getToken())
        .then((value) async {
      if (value.isDone) {
        print("***ok***");
        getDetailTicketBlocInstance
            .getProfile(GetDetailTicketModel.fromJson(value.data));
        await Future.delayed(Duration(seconds: 5)).then((value) {
          TicketList.add(
            AnswerList(
                user: "کاربر",
                text: getDetailTicketBlocInstance.data.requestText,
                createdAt: getDetailTicketBlocInstance.data.createdAt,
                file: getDetailTicketBlocInstance.data.file),
          );
          EasyLoading.dismiss();
        });
        for (var i in value.data['answers']) {
          TicketList.add(AnswerList.fromJson(i));
        }
      } else {
        print("***error***");
      }
    });
  }

  createAnswer(String text) async {
    RequestHelper.sendAnswer(
            token: await PrefHelpers.getToken(),
            text: text,
            ticket_id: getDetailTicketBlocInstance.data.id.toString())
        .then((value) {
      print(value.data);
      if (value.isDone || value.statusCode == 201) {
        print("send");
        FocusScope.of(Get.context).unfocus();
      } else if (!value.isDone || value.statusCode == 400) {
        print("can not send");
        FocusScope.of(Get.context).unfocus();
        ViewHelper.showErrorDialog(
            Get.context, "شما به حداکثر تعداد مجاز پاسخ به سوال رسیده اید");
      } else {
        print("faild");
        FocusScope.of(Get.context).unfocus();
        ViewHelper.showErrorDialog(Get.context, "ارسال با خطا مواجه شد");
      }
    });
  }
}
