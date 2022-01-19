import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ehyasalamat/bloc/ProfileBloc.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:ehyasalamat/models/ProfileModel.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfileWidget extends StatefulWidget {
  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  Size size;
  int selected = 0;
  String gender;
  String _value = "";
  String madrak = "انتخاب کنید";
  String city = "انتخاب کنید";
  String province = "انتخاب کنید";
  String _datetime = '';
  String _format = 'yyyy-mm-dd';
  String _valuePiker = '';
  final bool showTitleActions = false;

  List madarek = [
    "سیکل و پایین تر",
    "دیپلم",
    "کارشناسی",
    "کارشناسی ارشد",
    "دکترا و بالاتر",
  ];

  List listOfCity = [
    "کرج",
    "محمدشهر",
    "آزادگان",
  ];

  List listOfProvince = [
    "البرز",
    "تهران",
    "مشهد",
  ];

  void _showDatePicker() async {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(context,
        minYear: 1300,
        maxYear: 1450,
/*      initialYear: 1368,
      initialMonth: 05,
      initialDay: 30,*/
        confirm: Text(
          'تایید',
          style: TextStyle(color: Colors.red),
        ),
        cancel: Text(
          'لغو',
          style: TextStyle(color: Colors.cyan),
        ),
        dateFormat: _format, onChanged: (year, month, day) {
      if (!showTitleActions) {
        _changeDatetime(year, month, day);
      }
    }, onConfirm: (year, month, day) {
      _changeDatetime(year, month, day);
      _valuePiker =
          " تاریخ ترکیبی : $_datetime  \n سال : $year \n  ماه :   $month \n  روز :  $day";
    });
  }

  void _changeDatetime(int year, int month, int day) {
    setState(() {
      _datetime = '$year-$month-$day';
    });
  }

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  FocusNode nameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController fieldOfStudyController = TextEditingController();
  TextEditingController BerthDeyController = TextEditingController();

  // PersianDate persianDate = PersianDate();
  // String _datetime = '';
  // String _format = 'yyyy-mm-dd';
  // String _value = '';
  // String _valuePiker = '';
  // DateTime selectedDate = DateTime.now();
  //
  // Future _selectDate() async {
  //   String picked = await jalaliCalendarPicker(
  //       context: context,
  //       convertToGregorian: false,
  //       showTimePicker: true,
  //       hore24Format: true);
  //   if (picked != null) setState(() => _value = picked);
  // }

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  void _doSomething() async {
    RequestHelper.updateProfile(
            token: await PrefHelpers.getToken(),
            last_name: lNameController.text,
            birthday: _datetime.toString(),
            city: city,
            degree: madrak,
            field_of_study: fieldOfStudyController.text,
            first_name: nameController.text,
            job: jobController.text,
            province: province,
            gender: gender)
        .then(
      (value) {
        print(value.data);
        if (value.isDone) {
          getProfileBlocInstance.getProfile(ProfileModel.fromJson(value.data));
          ViewHelper.showSuccessDialog(
              context, "پروفایل شما با موفقیت بروزرسانی شد");
        } else {
          ViewHelper.showErrorDialog(context, "رسال اطلاعات با خطا مواجه شد");
        }
      },
    );
  }

  @override
  void initState() {
    if (getProfileBlocInstance.profile.gender == "مرد") {
      setState(() {
        selected = 2;
      });
    } else if (getProfileBlocInstance.profile.gender == "زن") {
      setState(() {
        selected = 1;
      });
    }

    nameController.text = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.firstName;
    lNameController.text = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.lastName;
    phoneController.text = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.phoneNumber;
    province = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.province;
    city = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.city;
    jobController.text = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.job;
    madrak = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.degree;
    fieldOfStudyController.text = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.degree;

    _datetime = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.birthday;
    gender = (getProfileBlocInstance.profile == null)
        ? ""
        : getProfileBlocInstance.profile.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return _buildBody();
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Container(
        // height: size.height,
        width: size.width,
        margin: EdgeInsets.all(size.width * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            _buildTopContainer(),
            _buildText(),
            _buildMain(),
          ],
        ),
      ),
    );
  }

  _buildTopContainer() {
    return Container(
      margin: EdgeInsets.all(size.width * .03),
      height: size.height * .2,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ]),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size.height * .03),
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
                nameController.text + " " + lNameController.text,
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
                (getProfileBlocInstance.profile == null)
                    ? ""
                    : getProfileBlocInstance.profile.role,
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
          Align(
            alignment: Alignment.center,
            child: Container(
              height: size.height * .04,
              width: size.width * .2,
              margin: EdgeInsets.only(
                  left: size.width * .05, top: size.height * .06),
              decoration: BoxDecoration(
                color: Color(0xffFFCF1B),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: AutoSizeText(
                  "امتیاز ${(getProfileBlocInstance.profile == null) ? "0" : getProfileBlocInstance.profile.points.toString()}",
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: size.height * .03,
                  left: size.width * .05,
                  right: size.width * .05),
              child: Divider(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: size.height * .02,
                  left: size.width * .05,
                  right: size.width * .08),
              child: Container(
                margin: EdgeInsets.only(right: size.width * .4),
                height: size.height * .05,
                width: size.width * .1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                    child: Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.black54,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildText() {
    return Container(
      height: size.height * .035,
      color: Colors.white,
      width: size.width,
      margin: EdgeInsets.only(right: size.width * .08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            "جهت تغییر هر یک از مقادیر زیر لطفا بر روی آن ضربه بزنید.",
            maxLines: 1,
            maxFontSize: 20,
            minFontSize: 6,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.black54, fontSize: 10),
          ),
          AutoSizeText(
            "تکمیل همه مغادیر جهت پرسش و پاسخ پزشکی، ضروری می باشند.",
            maxLines: 1,
            maxFontSize: 20,
            minFontSize: 6,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.redAccent, fontSize: 10),
          ),
        ],
      ),
    );
  }

  _buildMain() {
    return Column(
      children: [
        SizedBox(
          height: size.height * .05,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: size.height * .04,
            width: size.width * .35,
            child: Column(
              children: [
                AutoSizeText(
                  "اطلاعات",
                  maxLines: 1,
                  maxFontSize: 24,
                  minFontSize: 10,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Color(0xff3385FF), fontSize: 14),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                  child: Divider(),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: size.height * .05,
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * .05),
          padding: EdgeInsets.symmetric(horizontal: size.width * .05),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "شماره موبایل:",
                maxLines: 1,
                maxFontSize: 24,
                minFontSize: 10,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * .1),
                child: AutoSizeText(
                  phoneController.text,
                  maxLines: 1,
                  maxFontSize: 24,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Image.asset(
                "assets/images/pin.png",
                width: size.width * .05,
              )
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildNameField(),
              _buildLNameField(),
              _buildFieldOfStudyField(),
              _buildJobField(),
              SizedBox(
                height: size.height * .01,
              ),
              _buildProvinceField(),
              _buildCityField(),
              _buildDegreeField(),
              SizedBox(
                height: size.height * .01,
              ),
              _BDayField(),
              ListTile(
                title: Text("زن"),
                leading: Radio(
                  value: 1,
                  groupValue: selected,
                  onChanged: (value) {
                    setState(() {
                      selected = value;
                      // selected = 1;

                      gender = "زن";
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
              ListTile(
                title: Text("مرد"),
                leading: Radio(
                  value: 2,
                  groupValue: selected,
                  onChanged: (value) {
                    setState(() {
                      selected = value;
                      // selected = 2;
                      gender = "مرد";
                      // getProfileBlocInstance.profile.gender;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
              _submitBtn(),
              SizedBox(
                height: size.height * .02,
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildNameField() {
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * .06),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "نام خود را وارد کنید";
          }
        },
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        controller: nameController,
        decoration: InputDecoration(
          // suffixIcon: Icon(
          //   Icons.add,
          //   color: Colors.amber,
          // ),
          hintText: "نام خود را وارد کنید",
          hintStyle: TextStyle(fontSize: 12),
          labelText: "نام",
          labelStyle: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  _buildLNameField() {
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * .06),
      child: TextFormField(
        controller: lNameController,
        validator: (value) {
          if (value.isEmpty) {
            return "نام خانوادگی خود را وارد کنید";
          }
        },
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            // suffixIcon: Icon(
            //   Icons.add,
            //   color: Colors.amber,
            // ),
            hintText: "نام خانوادگی خود را وارد کنید",
            hintStyle: TextStyle(fontSize: 12),
            labelText: "نام خانوادگی",
            labelStyle: TextStyle(color: Colors.black87)),
      ),
    );
  }

  // _buildPhoneNumberField() {
  //   return Container(
  //     height: size.height * .06,
  //     width: size.width,
  //     padding: EdgeInsets.symmetric(horizontal: size.width * .06),
  //     child: TextFormField(
  //
  //       controller: phoneController,
  //       onChanged: (value) {
  //         setState(() {
  //           WidgetHelper.onChange(value, phoneController);
  //         });
  //       },
  //       validator: (value) {
  //         if (value.isEmpty) {
  //           return "شماره موبایل خود را وارد کنید";
  //         } else {
  //           return "";
  //         }
  //       },
  //       textInputAction: TextInputAction.next,
  //       textAlign: TextAlign.center,
  //       decoration: InputDecoration(
  //           // suffixIcon: Icon(
  //           //   Icons.add,
  //           //   color: Colors.amber,
  //           // ),
  //           hintText: "شماره موبایل خود را وارد کنید",
  //           hintStyle: TextStyle(fontSize: 12),
  //           labelText: "شماره موبایل",
  //           labelStyle: TextStyle(color: Colors.black87)),
  //     ),
  //   );
  // }

  _buildProvinceField() {
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * .06),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * .05, vertical: size.height * .02),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
      ]),
      child: _buildDropDown3(),
    );
  }

  _buildCityField() {
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * .06),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * .05, vertical: size.height * .02),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
      ]),
      child: _buildDropDown2(),
    );
  }

  _buildDegreeField() {
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * .06),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * .05, vertical: size.height * .02),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
      ]),
      child: _buildDropDown(),
    );
  }

  _buildFieldOfStudyField() {
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * .06),
      child: TextFormField(
        controller: fieldOfStudyController,
        validator: (value) {
          if (value.isEmpty) {
            return "رشته تحصیلی خود را وارد کنید";
          }
        },
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            // suffixIcon: Icon(
            //   Icons.add,
            //   color: Colors.amber,
            // ),
            hintText: "رشته تحصیلی خود را وارد کنید",
            hintStyle: TextStyle(fontSize: 12),
            labelText: "رشته تحصیلی",
            labelStyle: TextStyle(color: Colors.black87)),
      ),
    );
  }

  _buildJobField() {
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * .06),
      child: TextFormField(
        controller: jobController,
        validator: (value) {
          if (value.isEmpty) {
            return "شغل خود را وارد کنید";
          }
        },
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            // suffixIcon: Icon(
            //   Icons.add,
            //   color: Colors.amber,
            // ),
            hintText: "شغل خود را وارد کنید",
            hintStyle: TextStyle(fontSize: 12),
            labelText: "شغل",
            labelStyle: TextStyle(color: Colors.black87)),
      ),
    );
  }

//   void _showDatePicker() {
//     final bool showTitleActions = false;
//     DatePicker.showDatePicker(context,
//         minYear: 1300,
//         maxYear: 1450,
// /*      initialYear: 1368,
//       initialMonth: 05,
//       initialDay: 30,*/
//         confirm: Text(
//           'تایید',
//           style: TextStyle(color: Colors.red),
//         ),
//         cancel: Text(
//           'لغو',
//           style: TextStyle(color: Colors.cyan),
//         ),
//         dateFormat: _format,
//         onChanged: (year, month, day) {
//           if (!showTitleActions) {
//             _changeDatetime(year, month, day);
//           }
//         },
//         onConfirm: (year, month, day) {
//           _changeDatetime(year, month, day);
//           _valuePiker =
//           " تاریخ ترکیبی : $_datetime  \n سال : $year \n  ماه :   $month \n  روز :  $day";
//         });
//   }
//
//   void _changeDatetime(int year, int month, int day) {
//     setState(() {
//       _datetime = '$year-$month-$day';
//     });
//   }

  _submitBtn() {
    return Center(
      child: RoundedLoadingButton(
        height: size.height * .055,
        width: size.width * .4,
        successColor: Color(0xff077F7F),
        color: Color(0xff077F7F),
        child: AutoSizeText(
          "ذخیره اطلاعات",
          maxLines: 1,
          maxFontSize: 22,
          minFontSize: 10,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        controller: _btnController1,
        animateOnTap: true,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _doSomething();
            _btnController1.reset();
          } else {
            _btnController1.stop();
          }
        },
      ),
    );
  }

  _BDayField() {
    return GestureDetector(
      onTap: () {
        _showDatePicker();
      },
      child: Container(
        height: size.height * .06,
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: size.width * .06),
        padding: EdgeInsets.all(size.width * .02),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
            ]),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                "تاریخ تولد:",
                maxLines: 1,
                maxFontSize: 24,
                minFontSize: 10,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
            SizedBox(
              width: size.width * .18,
            ),
            AutoSizeText(
              _datetime,
              maxLines: 1,
              maxFontSize: 24,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  _buildDropDown() {
    return DropdownButton(
      hint: madrak == null
          ? Center(child: Text('انتخاب کنید'))
          : Center(
              child: Text(
                madrak,
                style: TextStyle(color: Colors.black),
              ),
            ),
      underline: Container(),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.blue),
      items: madarek.map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Center(
              child: Text(val),
            ),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            madrak = val;
          },
        );
      },
    );
  }

  _buildDropDown2() {
    return DropdownButton(
      hint: city == null
          ? Center(child: Text('انتخاب کنید'))
          : Center(
              child: Text(
                city,
                style: TextStyle(color: Colors.black),
              ),
            ),
      underline: Container(),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.blue),
      items: listOfCity.map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Center(
              child: Text(val),
            ),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            city = val;
          },
        );
      },
    );
  }

  _buildDropDown3() {
    return DropdownButton(
      hint: province == null
          ? Center(child: Text('انتخاب کنید'))
          : Center(
              child: Text(
                province,
                style: TextStyle(color: Colors.black),
              ),
            ),
      underline: Container(),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.blue),
      items: listOfProvince.map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Center(
              child: Text(val),
            ),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            province = val;
          },
        );
      },
    );
  }
}
