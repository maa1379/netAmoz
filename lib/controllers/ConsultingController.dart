import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    getTicketData();
    super.onInit();
  }

  RxList<GetTicketModel> getTicketList = <GetTicketModel>[].obs;

  RxString filter = "all".obs;
  RxBool isFilter = false.obs;

  getTicketData({String token, String filters = "all"}) async {
    RequestHelper.getTickets(
            token: await PrefHelpers.getToken(), filter: filters)
        .then((value) {
      if (value.isDone) {
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
