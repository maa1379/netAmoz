import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:ehyasalamat/controllers/SupportController.dart';

import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/SectionModel.dart';

class SupportStepperScreen extends StatefulWidget {
  @override
  _SupportStepperScreenState createState() => _SupportStepperScreenState();
}

class _SupportStepperScreenState extends State<SupportStepperScreen> {
  SupportStepperController supportStepperController =
      Get.put(SupportStepperController());

  Size size;
  String value = "انتخاب کنید";
  int _currentStep = 0;
  TextEditingController answerTextEditingController = TextEditingController();
  TextEditingController topicTextEditingController = TextEditingController();
  String status = '';
  String error = 'Error';
  List<SectionModel> sectionList = [];

  List<Step> _myStep() {
    List<Step> _steps = [
      Step(
        title: Text("عنوان"),
        content: _buildStepper1(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text("بخش"),
        content: _buildStepper2(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text("درخواست"),
        content: _buildStepper3(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text("ثبت نهایی"),
        content: _buildStepper3(),
        isActive: _currentStep >= 0,
        state: StepState.complete,
      ),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/home_back.png"),
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
                      size: size, context: context, text: "پشتیبانی"),
                ),
              ),
              SizedBox(
                height: size.height * .05,
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
        child: Column(
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            _buildStepper(),
          ],
        ),
      ),
    );
  }

  _buildStepper() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .015),
        child: Stepper(
          currentStep: this._currentStep,
          onStepTapped: (step) {
            setState(
              () {
                this._currentStep = step;
              },
            );
          },
          onStepCancel: () {
            setState(
              () {
                if (this._currentStep > 0) {
                  this._currentStep = this._currentStep - 1;
                } else {
                  this._currentStep = 0;
                }
              },
            );
          },
          onStepContinue: () {
            setState(
              () {
                if (this._currentStep < this._myStep().length - 1) {
                  this._currentStep = this._currentStep + 1;
                } else {
                  EasyLoading.show(
                      indicator: CircularProgressIndicator(),
                      dismissOnTap: true);
                  supportStepperController.sentStepperTicket(
                      section_id: value.toString(),
                      text: answerTextEditingController.text,
                      topic: topicTextEditingController.text);
                }
              },
            );
            FocusScope.of(context).unfocus();
          },
          steps: _myStep(),
          type: StepperType.vertical,
        ),
      ),
    );
  }

  _buildStepper1() {
    return Container(
      height: size.height * .1,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _titleTextField(),
        ],
      ),
    );
  }

  _buildStepper2() {
    return Container(
      height: size.height * .15,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AutoSizeText(
            "سوال شما مربوط به کدام بخش است؟",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          Container(
              height: size.height * .05,
              width: size.width * .6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 5, spreadRadius: 2),
                  ]),
              child: _buildDropDown())
        ],
      ),
    );
  }

  _buildStepper3() {
    return Container(
      height: size.height * .25,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _messageTextField(),
        ],
      ),
    );
  }

  Widget _titleTextField() {
    return WidgetHelper.textField(
        icon: Text(""),
        text: "عنوان درخواست را وارد کنید",
        hintText: "عنوان",
        width: size.width,
        height: size.height * .08,
        // color: Color(0xfff5f5f5),
        size: size,
        controller: topicTextEditingController,
        fontSize: 12,
        maxLine: 1,
        keyBoardType: TextInputType.text,
        obscureText: false,
        maxLength: 40,
        function: (value) {
          if (value == "") {
            return "عنوان درخواست را وارد کنید";
          }
        });
  }

  Widget _messageTextField() {
    return ConstrainedBox(
      //  fit: FlexFit.loose,
      constraints: BoxConstraints(
        maxHeight: size.height * .2,
        maxWidth: size.width,
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: answerTextEditingController,
        maxLength: 500,
        minLines: 1,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(.40)),
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: "متن درخواست خود را بنویسید",
          hintText: "متن پیام",
          // contentPadding: EdgeInsets.all(size.width * .03),
          labelStyle: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(.40),
          ),
          counter: Offstage(),
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
    );
  }

  _buildDropDown() {
    return DropdownButton(
      hint: value == "انتخاب کنید"
          ? Center(child: Text('انتخاب کنید'))
          : Center(
              child: Text(
                value,
                style: TextStyle(color: Colors.blue),
              ),
            ),
      underline: Container(),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.blue),
      items: supportStepperController.supportSectionList.map(
        (val) {
          return DropdownMenuItem<String>(
            value: val.id.toString(),
            child: Center(
              child: Text(val.name),
            ),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            value = val;
          },
        );
      },
    );
  }
}
