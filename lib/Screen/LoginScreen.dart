import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'PinCodeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Size size;
  final _formKey = GlobalKey<FormState>();
  var token;
  TextEditingController mobileTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  void _doSomething() async {
    RequestHelper.LoginRegister(mobile: mobileTextEditingController.text)
        .then((value) {
      print(value.data);
      if (value.isDone) {
        print("ok");
        Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: PinCodeScreen(mobile: mobileTextEditingController.text,),
                ),
              );
      } else {
        print("no");
        ViewHelper.showErrorDialog(context,"ارسال کد با خطا مواجه شد");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/iPhone 12 Pro Max – 6.png"),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Stack(
                      children: [
                        _mobileTextField(),
                        _submitBtn(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mobileTextField() {
    return Align(
      alignment: Alignment.center,
      child: WidgetHelper.textField(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * .015),
          child: Image.asset(
            "assets/images/smartphone.png",
            color: Color(0xff0B7572),
          ),
        ),
        text: "موبایل",
        hintText: "شماره تلفن همراه",
        width: size.width,
        height: size.height * .07,
        margin: EdgeInsets.symmetric(horizontal: size.width * .08),
        size: size,
        fontSize: 16,
        onChange: (value) {
          setState(() {
            WidgetHelper.onChange(value, mobileTextEditingController);
          });
          if (value.isEmpty) {
            return "لطفا شماره تفلن همراه خود را وارد کنید";
          }
        },
        controller: mobileTextEditingController,
        maxLine: 1,
        keyBoardType: TextInputType.number,
        obscureText: false,
        maxLength: 11,
        color: Color(0xff28F6E7),
        formKey: _formKey,
        function: (value) {
          if (value.isEmpty) {
            return "لطفا شماره تفلن همراه خود را وارد کنید";
          }
        },
      ),
    );
  }

  _submitBtn() {
    return Padding(
      padding: EdgeInsets.only(top: size.height * .25),
      child: Center(
        child: RoundedLoadingButton(
          height: size.height * .055,
          width: size.width * .4,
          successColor: Color(0xff077F7F),
          color: Color(0xff077F7F),
          child: AutoSizeText(
            "ارسال",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          controller: _btnController1,
          animateOnTap: true,
          onPressed: () {
            if(_formKey.currentState.validate()){
              _doSomething();
              _btnController1.reset();
            }else{
              _btnController1.stop();
            }
          },
        ),
      ),
    );
  }
}
