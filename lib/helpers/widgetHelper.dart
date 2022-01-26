import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/Screen/LoginScreen.dart';
import 'package:ehyasalamat/Screen/NotificationScreen.dart';
import 'package:ehyasalamat/bloc/ProfileBloc.dart';
import 'package:ehyasalamat/controllers/PostController.dart';
import 'package:ehyasalamat/helpers/NavHelper.dart';
import 'package:ehyasalamat/models/DrawerModel.dart';
import 'package:ehyasalamat/widgets/SearchModalWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'AlertHelper.dart';
import 'PrefHelpers.dart';

class WidgetHelper {
  static Widget textField({
    String text,
    TextEditingController controller,
    double height,
    double width,
    EdgeInsets margin,
    int maxLine,
    double fontSize,
    Function function,
    Function onChange,
    Size size,
    GlobalKey formKey,
    int maxLength,
    bool obscureText,
    TextInputType keyBoardType,
    String errorText,
    String hintText,
    bool enabled,
    Widget icon,
    Color color,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        child: TextFormField(
          enabled: enabled,
          onChanged: onChange,
          maxLength: maxLength,
          obscureText: obscureText,
          controller: controller,
          maxLines: maxLine,
          keyboardType: keyBoardType,
          validator: function,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: icon,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(.40)),
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: text,
            hintText: hintText,
            // contentPadding: EdgeInsets.all(size.width * .03),
            labelStyle: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(.40),
            ),
            counter: Offstage(),
            errorText: errorText,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(.40)),
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(.40),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(.40)),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            hintStyle:
                TextStyle(fontSize: 12, color: Colors.grey.withOpacity(.20)),
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget drawerWidget({
    Size size,
    BuildContext context,
    // String name,
    // String userType,
    // String squer,
    // String date,
    GlobalKey<ScaffoldState> key,
    List<DrawerModel> itemList,
  }) {
    return Container(
      width: size.width,
      height: size.height * .88,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        child: Drawer(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    iconSize: size.width * .1,
                    icon: Icon(Icons.close),
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: size.height * .2,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/profile.png"),
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: size.width * .1, top: size.height * .01),
                        child: Image.asset(
                          "assets/images/prof.png",
                          width: size.width * .3,
                        ),
                      ),
                      alignment: Alignment.topRight,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: size.width * .13, bottom: size.height * .01),
                        child: AutoSizeText(
                          "تاریخ عضویت: 1400/05/24",
                          maxLines: 1,
                          maxFontSize: 26,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.width * .1, right: size.width * .1),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: AutoSizeText(
                              getProfileBlocInstance.profile.firstName +
                                  " " +
                                  getProfileBlocInstance.profile.lastName,
                              maxLines: 1,
                              maxFontSize: 28,
                              minFontSize: 12,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: AutoSizeText(
                              getProfileBlocInstance.profile.role,
                              maxLines: 1,
                              maxFontSize: 28,
                              minFontSize: 12,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: size.height * .04,
                            width: size.width * .2,
                            decoration: BoxDecoration(
                              color: Color(0xffFFCF1B),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                "امتیاز: " +
                                    getProfileBlocInstance.profile.points
                                        .toString(),
                                maxLines: 1,
                                maxFontSize: 28,
                                minFontSize: 12,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: size.height * .12, left: size.width * .05),
                        child: GestureDetector(
                          onTap: () {
                            PrefHelpers.removeToken();
                            Get.to(LoginScreen());
                          },
                          child: Image.asset(
                            "assets/images/exit.png",
                            width: size.width * .25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = itemList[index];
                    return GestureDetector(
                      onTap: () {
                        NavHelper.push(context, item.func);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        height: size.height * .05,
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        item.icon,
                                        width: size.width * .08,
                                      ),
                                      SizedBox(
                                        width: size.width * .03,
                                      ),
                                      AutoSizeText(
                                        item.title,
                                        maxLines: 1,
                                        maxFontSize: 28,
                                        minFontSize: 12,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: size.width * .035,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget btnHelper({
    double width,
    Widget child,
    Function func,
    Size size,
    double height,
    Color color,
    Color color1,
    Color color2,
    double radius,
    Color borderColor,
    Color shadowColor,
    double borderWidth,
    double elevation,
    double spreadRadius,
    double blurRadius,
    EdgeInsets padding,
    EdgeInsets margin,
  }) {
    return GestureDetector(
      onTap: () {
        func();
      },
      child: Container(
        margin: margin,
        height: size.height * height,
        width: size.width * width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topLeft,
                colors: [
                  color1,
                  color2,
                ]),
            color: color,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: blurRadius,
                  spreadRadius: spreadRadius)
            ]),
        child: Center(child: child),
      ),
    );
  }

  static void onChange(
      String string, TextEditingController textEditingController) {
    if (textEditingController.text.length == 11) {}
    List<String> list = string.split('');
    if (list.length > 0) {
      switch (list.length) {
        case 1:
          if (list[0] == '0') {
            textEditingController.text = '0';
          } else {
            textEditingController.clear();
          }
          break;
        case 2:
          if (list[1] == '9') {
            textEditingController.text = '09';
          } else {
            textEditingController.text = '0';
          }

          break;
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
          list.removeAt(0);
          list.removeAt(0);
          textEditingController.text = '09' + list.join('');
          break;
      }
      Future.delayed(
        Duration.zero,
        () => textEditingController.selection = TextSelection.fromPosition(
          TextPosition(
            offset: textEditingController.text.length,
          ),
        ),
      );
    }
  }

  static Widget appBar(
      {Size size, GlobalKey<ScaffoldState> key, BuildContext context}) {
    return Container(
      height: size.height * .08,
      width: size.width,
      margin: EdgeInsets.only(top: size.height * .05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: size.width * .04),
            child: GestureDetector(
              onTap: () {
                key.currentState.openDrawer();
              },
              child: Image.asset(
                "assets/images/menu.png",
                width: size.width * .06,
              ),
            ),
          ),
          Container(
            height: size.height * .05,
            width: size.width * .5,
            margin: EdgeInsets.only(right: size.width * .1),
            padding: EdgeInsets.symmetric(horizontal: size.width * .03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/ehyalogo.png",
                  width: size.width * .08,
                ),
                AutoSizeText(
                  "حکیم دکتر روازاده",
                  maxLines: 1,
                  maxFontSize: 26,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * .05,
            width: size.width * .3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Image.asset(
                    "assets/images/search.png",
                    width: size.width * .06,
                  ),
                  onTap: () {
                    showMaterialModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isDismissible: true,
                      enableDrag: false,
                      context: Get.context,
                      builder: (context) {
                        return SearchModalWidget();
                      },
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    NavHelper.push(context, NotificationScreen());
                  },
                  child: Image.asset(
                    "assets/images/alarm.png",
                    width: size.width * .06,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget ItemContainer({
    Size size,
    Color gColor1,
    Color gColor2,
    String text,
    String icon,
  }) {
    return Container(
      alignment: Alignment.center,
      height: size.height * .05,
      width: size.width * .24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black12, spreadRadius: 1),
        ],
      ),
      child: Stack(
        children: [
          Transform.rotate(
            angle: 2.38,
            child: Container(
              height: size.height * .08,
              width: size.width * .18,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.centerRight,
                    colors: [
                      gColor1,
                      gColor2,
                    ]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            height: size.height * .08,
            width: size.width * .18,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    gColor2,
                    gColor1,
                  ],
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  icon,
                  width: size.width * .08,
                  color: Colors.white,
                ),
                AutoSizeText(
                  text,
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget SupportItemContainer({
    Size size,
    Color gColor1,
    Color gColor2,
    String text,
    String icon,
  }) {
    return Container(
      alignment: Alignment.center,
      height: size.height * .05,
      width: size.width * .24,
      child: Stack(
        children: [
          Transform.rotate(
            angle: 2.38,
            child: Container(
              height: size.height * .08,
              width: size.width * .18,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            height: size.height * .08,
            width: size.width * .18,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                )),
            child: Container(
              height: size.height * .05,
              width: size.width * .1,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff64E8DE),
                      Color(0xff8A64EB),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "شناسه",
                    maxLines: 1,
                    maxFontSize: 22,
                    minFontSize: 10,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  AutoSizeText(
                    text,
                    maxLines: 1,
                    maxFontSize: 22,
                    minFontSize: 10,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget ItemPostContainer({
    Size size,
    String text,
    String image,
    Function func,
  }) {
    return GestureDetector(
      onTap: () {
        func();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * .02,
          vertical: size.height * .005,
        ),
        height: size.height * .12,
        width: size.width * .28,
        padding: EdgeInsets.symmetric(vertical: size.height * .01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black12, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: size.width * .03),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Get.find<PostController>().loading.value == true
                      ? FadeInImage.assetNetwork(
                          placeholder: "assets/anim/loading.gif",
                          image: image,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/anim/loading.gif"),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: AutoSizeText(
                text,
                maxLines: 1,
                maxFontSize: 22,
                minFontSize: 10,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * .04),
                height: size.height * .02,
                width: size.width,
                decoration: BoxDecoration(
                  color: Color(0xff7366FF),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: AutoSizeText(
                    "ادامه مطلب",
                    maxLines: 1,
                    maxFontSize: 18,
                    minFontSize: 6,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget PopNavigator({Size size, BuildContext context, String text}) {
    return Container(
      height: size.height * .05,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: size.width * .38),
            child: AutoSizeText(
              text,
              maxLines: 1,
              maxFontSize: 22,
              minFontSize: 6,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: size.height * .04,
              width: size.width * .2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black12,
                      spreadRadius: 2,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "بازگشت",
                    maxLines: 1,
                    maxFontSize: 22,
                    minFontSize: 6,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    size: size.width * .05,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
