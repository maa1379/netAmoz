import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ehyasalamat/Screen/ConsultingScreen.dart';
import 'package:ehyasalamat/Screen/ConsultingStepperScreen.dart';
import 'package:ehyasalamat/Screen/EditProfileScreen.dart';
import 'package:ehyasalamat/bloc/ProfileBloc.dart';
import 'package:ehyasalamat/controllers/ConsultingController.dart';
import 'package:ehyasalamat/helpers/AlertHelper.dart';
import 'package:ehyasalamat/helpers/NavHelper.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';

class ConsultingWidget extends StatefulWidget {
  @override
  _ConsultingWidgetState createState() => _ConsultingWidgetState();
}

class _ConsultingWidgetState extends State<ConsultingWidget> {
  Size size;

  ConsultingController ticketController = Get.put(ConsultingController());

  final _formKey = GlobalKey<FormState>();

  String value = "فیلتر کن";

  TextEditingController searchTextEditingController = TextEditingController();

  RxList _filtered = [].obs;

  _searchFunction() {
    _filtered = [].obs;
    for (int i = 0; i < ticketController.getTicketList.length; ++i) {
      var item = ticketController.getTicketList[i];
      if (item.topic
          .toLowerCase()
          .contains(searchTextEditingController.text.toLowerCase())) {
        _filtered.add(item);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return _buildBody();
  }

  _buildBody() {
    return Container(
      height: size.height,
      width: size.width,
      margin: EdgeInsets.all(size.width * .02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Obx(
        () => Column(
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            _buildTopContainer(),
            _buildButtonNewChat(),
            _buildFilterBar(),
            SizedBox(
              height: size.height * .02,
            ),
            if (ticketController.getTicketList.length == 0)
              Padding(
                padding: EdgeInsets.only(top: size.height * .2),
                child: Text(
                  "هیچ تیکتی دریافت نشد!",
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              )
            else
              _buildListView(),
          ],
        ),
      ),
    );
  }

  _buildTopContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/22.png",
            width: size.width * .22,
          ),
          Image.asset(
            "assets/images/11.png",
            width: size.width * .22,
          ),
          Image.asset(
            "assets/images/33.png",
            width: size.width * .22,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/images/44.png",
                width: size.width * .22,
              )),
        ],
      ),
    );
  }

  _buildButtonNewChat() {
    return GestureDetector(
      onTap: () {
        if (getProfileBlocInstance.profile.profileDone == false) {
          AlertHelpers.CheckProfileDialog(
            size: size,
            context: Get.context,
            func: () {
              NavHelper.pushR(context, EditProfileScreen());
            },
          );
        } else {
          NavHelper.push(context, ConsultingStepperScreen());
          print("profile ok");
        }
      },
      child: Container(
        height: size.height * .05,
        width: size.width,
        margin: EdgeInsets.only(
            top: size.height * .03,
            left: size.width * .02,
            right: size.width * .02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: [
              Color(0xffFFCF1B),
              Color(0xffFF8818),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: AutoSizeText(
            "+ ثبت درخواست جدید",
            maxLines: 1,
            maxFontSize: 28,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  _buildFilterBar() {
    return Container(
      height: size.height * .08,
      width: size.width,
      margin: EdgeInsets.only(top: size.height * .02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _searchTextField(),
              _buildDropDownContainer(),
            ],
          ),
          (ticketController.isFilter == true)
              ? GestureDetector(
                  onTap: () async {
                    ticketController.isFilter = false.obs;
                    ticketController.getTicketData(
                        token: await PrefHelpers.getToken(), filters: "all");
                    value = "فیلتر کن";
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * .13),
                        child: Text(
                          "حذف فیلتر",
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      )))
              : Container()
        ],
      ),
    );
  }

  _buildDropDown() {
    return DropdownButton(
      hint: value == null
          ? Center(child: Text('Dropdown'))
          : Center(
              child: Text(
                value,
                style: TextStyle(color: Colors.blue),
              ),
            ),
      underline: Container(),
      isExpanded: true,
      iconSize: 30.0,
      // borderRadius: BorderRadius.circular(15),
      style: TextStyle(color: Colors.blue),
      items: ['جدید', 'درحال بررسی', 'پاسخ داده شده', 'بسته شده'].map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Container(
              height: size.height * .03,
              width: size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff6454F0),
                    Color(0xff6EE2F5),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Center(
                child: Text(
                  val,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ).toList(),
      onChanged: (val) async {
        value = val;
        // ticketController.loading = false.obs;
        if (val == "جدید") {
          ticketController.filter = "1".obs;
          ticketController.getTicketList.clear();
          ticketController.isFilter = true.obs;
          ticketController.getTicketData(
              token: await PrefHelpers.getToken(),
              filters: ticketController.filter.toString());
        } else if (val == "درحال برسی") {
          ticketController.filter = "2".obs;
          ticketController.getTicketList.clear();
          ticketController.isFilter = true.obs;
          ticketController.getTicketData(
              token: await PrefHelpers.getToken(),
              filters: ticketController.filter.toString());
        } else if (val == "پاسخ داده شده") {
          ticketController.filter = "3".obs;
          ticketController.getTicketList.clear();
          ticketController.isFilter = true.obs;
          ticketController.getTicketData(
              token: await PrefHelpers.getToken(),
              filters: ticketController.filter.toString());
        } else {
          ticketController.filter = "4".obs;
          ticketController.getTicketList.clear();
          ticketController.isFilter = true.obs;
          ticketController.getTicketData(
              token: await PrefHelpers.getToken(),
              filters: ticketController.filter.toString());
        }
      },
    );
  }

  Widget _searchTextField() {
    return WidgetHelper.textField(
      icon: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * .015),
        child: Image.asset(
          "assets/images/search.png",
          color: Colors.black45,
        ),
      ),
      text: "جستجو",
      hintText: "جستجو ...",
      width: size.width * .5,
      height: size.height * .06,
      // color: Color(0xfff5f5f5),
      size: size,
      fontSize: 16,
      controller: searchTextEditingController,
      onChange: (text) {
        _searchFunction();
      },
      maxLine: 1,
      keyBoardType: TextInputType.text,
      obscureText: false,
      maxLength: 11,
      formKey: _formKey,
    );
  }

  _buildDropDownContainer() {
    return Container(
      height: size.height * .03,
      width: size.width * .3,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
          ]),
      child: _buildDropDown(),
    );
  }

  _buildListView() {
    return Expanded(
      child: ListView.builder(
        reverse: true,
          physics: BouncingScrollPhysics(),
          itemCount: searchTextEditingController.text.isEmpty
              ? ticketController.getTicketList.length
              : _filtered.length,
          itemBuilder: _buildListItem),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    var item = ticketController.getTicketList[index];
    return Obx(
      () {
        if (ticketController.getTicketList.length == 0) {
          return Center(child: Text("تیکتی ثبت نشده است"));
        }
        return GestureDetector(
          onTap: () {
            Get.to(ConsultingScreen(),
                arguments: {"ticket_id": item.id.toString()});
          },
          child: Container(
            height: size.height * .12,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ]),
            margin: EdgeInsets.only(
                top: (index == 0) ? 0 : size.height * .01,
                right: size.width * .03,
                left: size.width * .03,
                bottom: size.height * .02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * .1,
                      width: size.width * .25,
                      child: WidgetHelper.SupportItemContainer(
                        size: size,
                        text: item.id.toString(),
                        gColor1: Colors.blue,
                        gColor2: Colors.white,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          item.topic,
                          maxLines: 1,
                          maxFontSize: 28,
                          minFontSize: 10,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        AutoSizeText(
                          item.requestText,
                          maxLines: 1,
                          maxFontSize: 24,
                          minFontSize: 6,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black45, fontSize: 12),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        AutoSizeText(
                          "تاریخ ثبت: ${item.createdAt}",
                          maxLines: 1,
                          maxFontSize: 24,
                          minFontSize: 6,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black45, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Container(
                      height: size.height * .03,
                      width: size.width * .25,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff6454F0),
                            Color(0xff6EE2F5),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: AutoSizeText(
                           item.statusForUser,
                          maxLines: 1,
                          maxFontSize: 24,
                          minFontSize: 6,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
