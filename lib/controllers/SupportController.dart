import 'package:ehyasalamat/Screen/SupportScreen.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ehyasalamat/bloc/GetDetailSupportTicketBloc.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/models/GetSupportChat.dart';
import 'package:ehyasalamat/models/GetSupportSectionModel.dart';
import 'package:ehyasalamat/models/GetSupportTicketList.dart';
import 'package:ehyasalamat/widgets/supportWidget.dart';

class SupportStepperController extends GetxController {
  RxList<GetSupportSectionModel> supportSectionList =
      <GetSupportSectionModel>[].obs;

  RxList<GetSupportTicketList> supportTicketList = <GetSupportTicketList>[].obs;

  sentStepperTicket({String topic, String text, String section_id}) async {
    RequestHelper.sendSupportTicket(
            token: await PrefHelpers.getToken(),
            text: text,
            topic: topic,
            section_id: section_id)
        .then((value) {
      if (value.isDone || value.statusCode == 201) {
        print(value.data);
        supportTicketList.clear();
        getSupportTicketList();
        Get.off(SupportScreen());
        EasyLoading.dismiss();
      } else {
        print("failed");
      }
    });
  }

  getSupportSection() async {
    RequestHelper.getSupportSection().then((value) {
      if (value.isDone) {
        for (var i in value.data) {
          supportSectionList.add(GetSupportSectionModel.fromJson(i));
          print("*******");
        }
      } else {
        print("failed");
      }
    });
  }

  getSupportTicketList() async {
    RequestHelper.getSupportTicketList(token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone) {
        print(value.data);
        for (var i in value.data) {
          supportTicketList.add(GetSupportTicketList.fromJson(i));
        }
      } else {
        print("failed");
      }
    });
  }

  @override
  void onInit() {
    getSupportSection();
    getSupportTicketList();
    super.onInit();
  }
}

class SupportTicketDetailController extends GetxController {
  TextEditingController textController = TextEditingController();
  RxList<AnswerListSupport> TicketList = <AnswerListSupport>[].obs;

  getSupportTicketChat() async {
    RequestHelper.getSupportTicketChat(
            token: await PrefHelpers.getToken(), ticket_id: Get.arguments['supportChat_id'].toString())
        .then((value) async {
      if (value.statusCode == 200) {
        print(value.data);
        getDetailSupportTicketBlocInstance
            .getSupportTicket(GetSupportChat.fromJson(value.data2));
        print(getDetailSupportTicketBlocInstance.data.topic);
        await Future.delayed(Duration(seconds: 5)).then((value) {
          TicketList.add(
            AnswerListSupport(
              user: "کاربر",
              text: getDetailSupportTicketBlocInstance.data.requestText,
              createdAt: getDetailSupportTicketBlocInstance.data.createdAt,
            ),
          );
          EasyLoading.dismiss();
        });
        for (var i in value.data2['answers']) {
          TicketList.add(AnswerListSupport.fromJson(i));
        }
      } else {
        print("**failed**");
      }
    });
  }


  createAnswer(String text) async {
    RequestHelper.sendSupportAnswer(
        token: await PrefHelpers.getToken(),
        text: text,
        ticket_id: getDetailSupportTicketBlocInstance.data.id.toString())
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


  @override
  void onInit() {
    TicketList.clear();
    getSupportTicketChat();
    EasyLoading.show(
        dismissOnTap: true, indicator: CircularProgressIndicator());
    super.onInit();
  }
}
