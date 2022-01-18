import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ehyasalamat/plugins/flushbar/flushbar.dart';


class ViewHelper {
  static Image pattern = Image.asset('assets/images/pattern.jpg');

  static void showMobileValidation(BuildContext context) {
    ViewHelper.showErrorDialog(
      context,
      "لطفا شماره موبایل را به درستی وارد کنید",
    );
  }

  static void chooseAddressPlease(BuildContext context, double height) {
    ViewHelper._baseWarning(
      context: context,
      iconData: Icons.warning_amber_outlined,
      backgroundColor: Colors.blue,
      height: height,
      text: "لطفا ابتدا یک آدرس را انتخاب کنید",
      textColor: Colors.white,
      borderAndIconColor: Colors.red,
      borderWidth: 1.0,
    );
  }

  static void showNameValidation(BuildContext context) {
    ViewHelper.showErrorDialog(
      context,
      "لطفا نام خود را به صورت کامل وارد کنید",
    );
  }

  // static String moneyFormat(double price) {
  //   return FlutterMoneyFormatter(amount: price).output.withoutFractionDigits;
  // }

  static void showErrorDialog(BuildContext context,
      [String text = "خطایی رخ داد"]) {
    Flushbar(
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      borderColor: Colors.red,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 150.0,
      ),
      animationDuration: Duration(milliseconds: 500),
      messageText: AutoSizeText(
        "$text",
        maxLines: 1,
        minFontSize: 3,
        maxFontSize: 12.0,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      icon: Icon(
        Icons.error_outline,
        size: 28.0,
        color: Colors.red,
      ),
      duration: Duration(seconds: 1),
    )..show(context);
  }

  static void _baseWarning({
    BuildContext context,
    double height,
    String text,
    Color textColor,
    Color backgroundColor,
    IconData iconData,
    Color borderAndIconColor,
    double borderWidth = 1.0,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      margin: EdgeInsets.symmetric(vertical: height, horizontal: 5.0),
      borderRadius: 10.0,
      borderWidth: borderWidth,
      isDismissible: true,
      backgroundColor: backgroundColor,
      animationDuration: Duration(milliseconds: 500),
      messageText: AutoSizeText(
        "$text",
        maxLines: 1,
        minFontSize: 3,
        maxFontSize: 12.0,
        style: TextStyle(
          color: textColor,
        ),
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      borderColor: borderAndIconColor,
      icon: Icon(
        iconData,
        size: 28.0,
        color: borderAndIconColor,
      ),
      duration: duration,
    )..show(context);
  }

  static void showRulesValidation(BuildContext context) {
    ViewHelper.showErrorDialog(
      context,
      "لطفا قوانین و مقررات سندباد را مطالعه کرده و آن را بپذیرید",
    );
  }

  static void showSuccessDialog(BuildContext context, String text) {
    Flushbar(
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      borderColor: Colors.green.shade700,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
      animationDuration: Duration(milliseconds: 500),
      messageText: AutoSizeText(
        "$text",
        maxLines: 1,
        minFontSize: 3,
        maxFontSize: 12.0,
        style: TextStyle(
          color: Colors.green.shade700,
        ),
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      icon: Icon(
        Icons.check_circle,
        size: 28.0,
        color: Colors.green.shade700,
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}

// class ChoseRoleAlert extends StatelessWidget {
//   Size size;
//
//   // List<SelectModelRole> roleList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//
//     // roleList.add(
//     //   SelectModelRole(
//     //     title: 'فروشنده',
//     //     selected: true,
//     //     image: 'assets/images/sale.png',
//     //     id: 1,
//     //   ),
//     // );
//     // roleList.add(
//     //   SelectModelRole(
//     //     title: 'خریدار',
//     //     selected: false,
//     //     image: 'assets/images/businessman.png',
//     //     id: 2,
//     //   ),
//     // );
//     // roleList.add(
//     //   SelectModelRole(
//     //     title: 'پیک',
//     //     selected: false,
//     //     image: 'assets/images/delivery.png',
//     //     id: 3,
//     //   ),
//     // );
//
//     return Scaffold(
//       body: Align(
//         alignment: Alignment.topRight,
//         child: Container(
//           height: size.height * .3,
//           width: size.width * .4,
//           margin: EdgeInsets.only(
//             top: size.height * .15,
//             left: 12,
//             right: 12,
//             bottom: 50,
//           ),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: radiusAll12,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 5.0,
//                   spreadRadius: 1,
//                 )
//               ]),
//           child: ListView.builder(
//             // itemCount: roleList.length,
//             itemBuilder: (context, int index) {
//               return GestureDetector(
//                 onTap: () {},
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.0),
//                   child: AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     height: size.height * .05,
//                     // decoration: BoxDecoration(
//                     //   boxShadow: [
//                     //     BoxShadow(
//                     //         color: (roleList[index].selected)
//                     //             ? ColorsHelper.colorOrange.withOpacity(.2)
//                     //             : Colors.transparent,
//                     //         spreadRadius: 5.0,
//                     //         blurRadius: 10.0)
//                     //   ],
//                     //   borderRadius: BorderRadius.circular(12.0),
//                     //   color: (roleList[index].selected)
//                     //       ? ColorsHelper.colorOrange
//                     //       : Colors.white,
//                     //   border: Border.all(
//                     //     color: (roleList[index].selected)
//                     //         ? ColorsHelper.colorOrange
//                     //         : Colors.grey,
//                     //     width: .8,
//                     //   ),
//                     // ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Padding(
//                         //   padding: const EdgeInsets.all(6.0),
//                         //   child: Image(
//                         //     image: AssetImage(
//                         //       roleList[index].image,
//                         //     ),
//                         //   ),
//                         // ),
//                         // AutoSizeText(
//                         //   roleList[index].title,
//                         //   maxFontSize: 20.0,
//                         //   minFontSize: 10.0,
//                         //   maxLines: 1,
//                         //   style: TextStyle(
//                         //     color: (roleList[index].selected)
//                         //         ? Colors.white
//                         //         : ColorsHelper.colorBlack,
//                         //     fontSize: 14.0,
//                         //   ),
//                         // )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class DigitInputFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue,
      {String separator = ","}) {
    //remove ',' symbol of text
    String number = newValue.text.replaceAll(RegExp(','), '');
    String str = "";
    for (var i = number.length; i > 0;) {
      if (i > 3)
        str = separator + number.substring(i - 3, i) + str;
      else
        str = number.substring(0, i) + str;
      i = i - 3;
    }
    return newValue.copyWith(
        text: str, selection: new TextSelection.collapsed(offset: str.length));
  }
}
