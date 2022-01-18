import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
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
                      size: size, context: context, text: "تماس با ما"),
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
        child: Column(
          children: [
            SizedBox(height: size.height * .15,),
            AutoSizeText(
              "جهت تماس با هر بخش بر روی آن بخش ضربه بزنید",
              maxLines: 1,
              maxFontSize: 28,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            SizedBox(height: size.height * .05,),
            _buildBoxContainer(
                text: "روابط عمومی: 02166920128",
                color1: Color(0xff3A3985),
                color2: Color(0xff3499FF),
                onTap: (){
                  launch("tel://02166920128");
                }
            ),
            _buildBoxContainer(
                text: "مطب: 02166425483",
                color1: Color(0xff047677),
                color2: Color(0xff28F6E7),
                onTap: (){
                  launch("tel://02166425483");
                }
            ),
            _buildBoxContainer(
                text: "واحد آموزش: 02166925508",
                color1: Color(0xffF650A0),
                color2: Color(0xffFF9897),
                onTap: (){
                  launch("tel://02166925508");
                }
            ),
            _buildBoxContainer(
                text: "واحد آموزش: 02166925508",
                color1: Color(0xffFF8818),
                color2: Color(0xffFFCF1B),
                onTap: (){
                  launch("tel://02166925508");
                }
            ),
          ],
        ),
      ),
    );
  }

  _buildBoxContainer({String text, Color color1, Color color2 , Function onTap}) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        height: size.height * .06,
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05,vertical: size.height * .01),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                color1,
                color2,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            )),
        child: Center(
          child: AutoSizeText(
            text,
            maxLines: 1,
            maxFontSize: 28,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
