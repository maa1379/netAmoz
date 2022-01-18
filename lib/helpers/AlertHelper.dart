import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AlertHelpers {
  static ExitDialog({
    BuildContext context,
    Size size,
  }) {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 50.0,
          content: Container(
            height: size.height * .25,
            width: size.width,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset("assets/anim/close.json",
                      width: size.width * .4),
                ),
                SizedBox(height: size.height * .01,),
                AutoSizeText(
                  "آیا قصد خروج از برنامه را دارید؟",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: size.height * .015,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: (){
                          exit(0);
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],),
                          child: Center(
                            child: AutoSizeText(
                              "خروج",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],),
                          child: Center(
                            child: AutoSizeText(
                              "برگشت",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  static ClearDialog({
    BuildContext context,
    Size size,
    Function func,
  }) {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 50.0,
          content: Container(
            height: size.height * .25,
            width: size.width,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset("assets/anim/close.json",
                      width: size.width * .4),
                ),
                SizedBox(height: size.height * .01,),
                AutoSizeText(
                  "آیا قصد حذف تاریخچه جستجو را دارید؟",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: size.height * .015,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: (){
                          func();
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],),
                          child: Center(
                            child: AutoSizeText(
                              "حذف تاریحچه",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop;
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],),
                          child: Center(
                            child: AutoSizeText(
                              "برگشت",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  static UpdateProfileDialog({
    BuildContext context,
    Size size,
    Function func,
    Function func2,
  }) {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 50.0,
          content: Container(
            height: size.height * .26,
            width: size.width,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset("assets/anim/edit_profile.json",
                      repeat: false,
                      width: size.width * .3),
                ),
                SizedBox(height: size.height * .01,),
                AutoSizeText(
                  "پروفایل خود را تکمیل کنید!!!",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: size.height * .015,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: (){
                          func();
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],),
                          child: Center(
                            child: AutoSizeText(
                              "تکیمل پروفایل",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: (){
                          func2();
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],),
                          child: Center(
                            child: AutoSizeText(
                              "بعدا",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  static CheckProfileDialog({
    BuildContext context,
    Size size,
    Function func,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 50.0,
          content: Container(
            height: size.height * .26,
            width: size.width,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset("assets/anim/edit_profile.json",
                      repeat: false,
                      width: size.width * .3),
                ),
                SizedBox(height: size.height * .01,),
                AutoSizeText(
                  "برای استفاده از این بخش باید پروفایل خود را تکمیل کنید!!!",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: size.height * .015,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: (){
                      func();
                    },
                    child: Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],),
                      child: Center(
                        child: AutoSizeText(
                          "تکیمل پروفایل",
                          maxLines: 1,
                          maxFontSize: 22,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
