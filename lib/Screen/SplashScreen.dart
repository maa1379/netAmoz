import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ehyasalamat/Screen/HomeScareen.dart';
import 'package:ehyasalamat/bloc/ProfileBloc.dart';
import 'package:ehyasalamat/helpers/NavHelper.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/models/ProfileModel.dart';
import 'IntroScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Size size;

  @override
  void initState() {
    getProfileByToken();
    super.initState();
  }

  getProfileByToken() async {
    RequestHelper.getProfile(token: await PrefHelpers.getToken()).then((value) {
      print(value.data);
      if (value.isDone) {
        getProfileBlocInstance.getProfile(ProfileModel.fromJson(value.data));
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
            ],
          ),
        ),
      ),
    );
  }
}
