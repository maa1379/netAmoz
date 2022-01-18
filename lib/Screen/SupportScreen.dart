import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/widgets/supportWidget.dart';


class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  Size size;


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
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
            Expanded(child: SupportWidget()),
          ],
        ),
      ),
    );
  }


}
