import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/controllers/PostController.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ehyasalamat/Screen/HomeScareen.dart';
import 'package:ehyasalamat/bloc/ProfileBloc.dart';
import 'package:ehyasalamat/helpers/NavHelper.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/models/ProfileModel.dart';
import 'IntroScreen.dart';
import 'package:connectivity/connectivity.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Size size;


  void checkInternet() async {
    var con = await (Connectivity().checkConnectivity());
    if (con == ConnectivityResult.mobile || con == ConnectivityResult.wifi) {
      getProfileByToken();
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        ViewHelper.showErrorDialog(
            context, "اینترنت خود را بررسی کنید و مجدد وارد شوید");
      });
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  getProfileByToken() async {
    RequestHelper.getProfile(token: await PrefHelpers.getToken()).then((value) {
      print(value.data);
      if (value.isDone) {
        getProfileBlocInstance.getProfile(ProfileModel.fromJson(value.data));
        Get.put(PostController());
        Get.put(CategoryController());
        Future.delayed(Duration(seconds: 5)).then((value) {
          NavHelper.pushR(context, HomeScreen());
        });
      } else {
        Future.delayed(Duration(seconds: 5)).then((value) {
          NavHelper.pushR(context, IntroScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/iPhone 12 Pro Max – 9.png"),
            ),
          ),
          child: Stack(
            children: [
              Image.asset(
                "assets/images/iPhone 12 Pro Max – 9.png",
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset("assets/anim/loading (2).json",
                    width: size.width * .5),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * .105, bottom: Get.height * .017),
                  child: AutoSizeText(
                    "نظام پزشکی 58290",
                    maxFontSize: 22,
                    minFontSize: 4,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        fontFamily: "yekanB"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
