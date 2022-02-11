import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/bloc/ProfileBloc.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:ehyasalamat/models/ProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';

class IncreasePointsScreen extends StatefulWidget {
  @override
  _IncreasePointsScreenState createState() => _IncreasePointsScreenState();
}

class _IncreasePointsScreenState extends State<IncreasePointsScreen> {
  Size size;
  TextEditingController mobileTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  getPoint()async{
    RequestHelper.referral(token: await PrefHelpers.getToken(),phoneNumber: mobileTextEditingController.text).then((value){
      if(value.isDone){
        getProfileByToken();
        ViewHelper.showSuccessDialog(context, "اطلاعات ذخیره شد");
      }else if (value.statusCode == 400){
        ViewHelper.showErrorDialog(context,"شما قبلا معرف خود را ثبت کردید");
      }else{
        ViewHelper.showErrorDialog(context,"ارتباط برقرار نشد");
      }
    });
  }

  getProfileByToken() async {
    RequestHelper.getProfile(token: await PrefHelpers.getToken()).then((value) {
      print(value.data);
      if (value.isDone) {
        getProfileBlocInstance.getProfile(ProfileModel.fromJson(value.data));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/Reward-Increase.png"),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * .05),
                  child: WidgetHelper.PopNavigator(
                      size: size, context: context, text: "ویرایش پروفایل"),
                ),
              ),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: Container(
        height: size.height,
        width: size.width,
        margin: EdgeInsets.all(size.width * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                _buildTopContainer(),
                _buildPoints(),
                _buildLevels(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildLevels() {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  right: size.width * .06, top: size.height * .05),
              child: AutoSizeText(
                "روش های افزایش اعتبار:",
                maxLines: 1,
                maxFontSize: 28,
                minFontSize: 12,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .05, vertical: size.height * .02),
              child: Column(
                children: [
                  AutoSizeText(
                    "اول - ارسال دعتوتنامه برای دوستان و درج شماره موبایل شما به عنوان معرف",
                    maxLines: 2,
                    maxFontSize: 28,
                    minFontSize: 12,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * .01, right: size.width * .08),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: size.height * .03,
                        width: size.width * .4,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadiusDirectional.circular(50)),
                        child: Center(
                          child: AutoSizeText(
                            "تعداد 10 امتیاز برای هر دو",
                            maxLines: 1,
                            maxFontSize: 22,
                            minFontSize: 10,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          _buildLevels2(),
          _buildLevels3(),
          _buildLevels4(),
          _buildBtn(),
        ],
      ),
    );
  }

  Widget _mobileTextField() {
    return Form(
      key: _formKey,
      child: WidgetHelper.textField(
        formKey: _formKey,
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * .015),
          child: Image.asset(
            "assets/images/smartphone.png",
            color: Color(0xff0B7572),
          ),
        ),
        text: "موبایل",
        hintText: " شماره تلفن همراه معرف",
        width: size.width,
        height: size.height * .07,
        margin: EdgeInsets.symmetric(horizontal: size.width * .12),
        size: size,
        fontSize: 16,
        onChange: (value) {
          setState(() {
            WidgetHelper.onChange(value, mobileTextEditingController);
          });
          if (value.isEmpty) {
            return "لطفا شماره تفلن همراه معرف را وارد کنید";
          }
        },
        controller: mobileTextEditingController,
        maxLine: 1,
        keyBoardType: TextInputType.number,
        obscureText: false,
        maxLength: 11,
        color: Color(0xff28F6E7),
        function: (value) {
          if (value.isEmpty) {
            return "لطفا شماره تفلن همراه معرف را وارد کنید";
          }
        },
      ),
    );
  }

  _buildLevels2() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            AutoSizeText(
              "دوم - درج شماره موبایل معرف در کادر زیر",
              maxLines: 2,
              maxFontSize: 28,
              minFontSize: 12,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _mobileTextField(),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * .01, right: size.width * .08),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: size.height * .03,
                  width: size.width * .3,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadiusDirectional.circular(50)),
                  child: Center(
                    child: AutoSizeText(
                      "تعداد 10 امتیاز",
                      maxLines: 1,
                      maxFontSize: 22,
                      minFontSize: 10,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  _buildLevels3() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .05, vertical: size.height * .02),
        child: Column(
          children: [
            AutoSizeText(
              "سوم - درج نظرات و تجارب شخصی تایید شده در بخش مطالب، احیاتی وی و رادیو احیا",
              maxLines: 2,
              maxFontSize: 28,
              minFontSize: 12,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * .01, right: size.width * .08),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: size.height * .03,
                  width: size.width * .3,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadiusDirectional.circular(50)),
                  child: Center(
                    child: AutoSizeText(
                      "تعداد 1 امتیاز",
                      maxLines: 1,
                      maxFontSize: 22,
                      minFontSize: 10,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  _buildLevels4() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05,),
        child: Column(
          children: [
            AutoSizeText(
              "چهام - ورود روزانه به اپلیکیشن و کار با اپلیکیشن به مدت حداقل 5 دقیقه و نداشتن پیام خوانده نشده",
              maxLines: 2,
              maxFontSize: 28,
              minFontSize: 12,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * .01, right: size.width * .08),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: size.height * .03,
                  width: size.width * .3,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadiusDirectional.circular(50)),
                  child: Center(
                    child: AutoSizeText(
                      "تعداد 1 امتیاز",
                      maxLines: 1,
                      maxFontSize: 22,
                      minFontSize: 10,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  _buildTopContainer() {
    return Container(
      height: size.height * .18,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * .06),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/prof.png",
                width: size.width * .3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * .05, right: size.width * .08),
            child: Align(
              alignment: Alignment.topRight,
              child: AutoSizeText(
                getProfileBlocInstance.profile.firstName + " " + getProfileBlocInstance.profile.lastName,
                maxLines: 1,
                maxFontSize: 28,
                minFontSize: 12,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff0066FF), fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * .085, right: size.width * .08),
            child: Align(
              alignment: Alignment.topRight,
              child: AutoSizeText(
                getProfileBlocInstance.profile.role,
                maxLines: 1,
                maxFontSize: 28,
                minFontSize: 12,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff0066FF), fontSize: 14),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * .12, right: size.width * .08),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: size.height * .03,
                width: size.width * .4,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadiusDirectional.circular(50)),
                child: Center(
                  child: AutoSizeText(
                    getProfileBlocInstance.profile.phoneNumber,
                    maxLines: 1,
                    maxFontSize: 28,
                    minFontSize: 12,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                // bottom: size.height * .03,
                  left: size.width * .05,
                  right: size.width * .05),
              child: Divider(),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/images/2.png",
                width: size.width * .08,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildPoints() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: size.height * .06,
        width: size.width * .35,
        margin: EdgeInsets.only(left: size.width * .05, top: size.height * .02),
        decoration: BoxDecoration(
          color: Color(0xffFFCF1B),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: AutoSizeText(
               "امتیاز شما: " + getProfileBlocInstance.profile.points.toString(),
            maxLines: 1,
            maxFontSize: 28,
            minFontSize: 12,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  _buildBtn() {
    return GestureDetector(
      onTap: (){
        if(_formKey.currentState.validate()){
        getPoint();
        }
        _formKey.currentState.save();
      },
      child: Container(
        margin: EdgeInsets.only(right: size.width * .04, top: size.height * .03),
        height: size.height * .05,
        width: size.width * .4,
        decoration: BoxDecoration(
          color: Color(0xff28F6E7),
          gradient: LinearGradient(colors: [
            Color(0xff1ED4C9),
            Color(0xff047677),
          ],
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: AutoSizeText(
            "ذخیره اطلاعات",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
