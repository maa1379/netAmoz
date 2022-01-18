import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ehyasalamat/bloc/ProfileBloc.dart';
import 'package:ehyasalamat/helpers/NavHelper.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:ehyasalamat/helpers/prefHelper.dart';
import 'package:ehyasalamat/models/ProfileModel.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'HomeScareen.dart';

class PinCodeScreen extends StatefulWidget {
  String mobile;

  PinCodeScreen({this.mobile});

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  Size size;
  final _formKey = GlobalKey<FormState>();
  TextEditingController pinCodeController = TextEditingController();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
  StreamController<ErrorAnimationType> errorController;
  String currentText = "";
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();

  void _doSomething() async {
    RequestHelper.LoginOtp(mobile: widget.mobile, code: pinCodeController.text)
        .then((value) async{
      print(value.data);
      if (value.isDone) {
        print("ok");
        PrefHelpers.setToken(value.data['access'].toString());
        await getProfileByToken();
      } else {
        print("no");
        ViewHelper.showErrorDialog(context, "ورود با خطا مواجه شد");
      }
    });
  }


  getProfileByToken()async{
    RequestHelper.getProfile(token: await PrefHelpers.getToken()).then((value){
      print(value.data);
      if(value.isDone){
        getProfileBlocInstance
            .getProfile(ProfileModel.fromJson(value.data));
        Get.to(HomeScreen());
      }else{
        print("faild");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/iPhone 12 Pro Max – 8.png"),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * .125),
                  child: Align(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "کد ارسال شده به شماره ${widget.mobile.toString()} را وارد کنید",
                      maxLines: 1,
                      maxFontSize: 22,
                      minFontSize: 10,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff0B7572), fontSize: 12),
                    ),
                  ),
                ),
                _buildPinPut(),
                _submitBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }




  Widget _buildPinPut() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .15, vertical: size.height * .1),
        child: PinCodeTextField(
          errorTextSpace: 25,
          length: 4,
          appContext: context,
          obscureText: false,
          controller: pinCodeController,
          keyboardType: TextInputType.number,
          animationType: AnimationType.fade,
          errorAnimationController: errorController,
          pinTheme: PinTheme(
            inactiveFillColor: Color(0xffF2F2F2),
            selectedFillColor: Color(0xffF2F2F2),
            selectedColor: Color(0xffF2F2F2),
            inactiveColor: Color(0xffF2F2F2),
            activeColor: Colors.green,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Color(0xffF2F2F2),
          ),
          animationDuration: Duration(milliseconds: 300),
          enableActiveFill: true,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          onCompleted: (v) {
            print("Completed");
          },
          onChanged: (value) {
            print(value);
            setState(() {
              currentText = value;
            });
          },
          validator: (value) {
            if (value.isEmpty) {
              return "!لطفا کد ارسال شده را وارد کنید";
            } else if (value.length < 4) {
              return "!کد کم تر از حد مجاز است";
            }
            return null;
          },
          beforeTextPaste: (text) {
            print("$text");
            return true;
          },
        ),
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
          successColor: Color(0xff647AD2),
          color: Color(0xff647AD2),
          child: AutoSizeText(
            "ورود",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          controller: _btnController1,
          animateOnTap: true,
          onPressed: () {
            if (pinCodeController.text == 0 ||
                pinCodeController.text != 11 ||
                _formKey.currentState.validate()) {
              _doSomething();
              _btnController1.reset();
            } else {
              _btnController1.stop();
            }
          },
        ),
      ),
    );
  }
}
