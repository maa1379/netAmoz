import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:share/share.dart';

class InviteFriendScreen extends StatelessWidget {
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
                      size: size, context: context, text: "دعوت از دوستان"),
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
                SizedBox(
                  height: size.height * .05,
                ),
                _buildInviteTextContainer(),
                _buildBtn(),
                SizedBox(
                  height: size.height * .1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                  child: AutoSizeText(
                    "سلام، برای کسب امتیاز از طریق دعوت کافی است که پیام فوق یا هر پیامی که دوست دارید را برای هر کدام از مخاطبین خود که سلامتی آنها برای شما مهم است بفرستید و سپس دوست شما شماره همراه شما (09128540400) را در قسمت دریافت امتیاز ثبت کند. لازم به ذکر است که شما بی نهایت فرد را می توانید به این خانواده بزرگ دعوت کنید.",
                    maxLines: 8,
                    maxFontSize: 28,
                    minFontSize: 12,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
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
                "میلاد سعیدی",
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
                "مدیر کل",
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
                    "09371516803",
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

  _buildBtn() {
    return GestureDetector(
      onTap: () {
        Share.share(
            'سلام، یه برنامه نصب کردم خیلی عالیه، هم اطلاعات و آموزش تغذیه سالم و طبی زیر نظر حکیم دکتر روازاده داره و هم اگر سوال پزشکی داشتی کارشناس های دکتر پاسخ سوالتون رو رایگان میدن. حتما نصبش کنید.\n لینک نصب: https://ravazadeh.com/app',
            subject: 'عضویت در نت آموز');
      },
      child: Container(
        margin:
            EdgeInsets.only(right: size.width * .04, top: size.height * .03),
        height: size.height * .05,
        width: size.width * .4,
        decoration: BoxDecoration(
          color: Color(0xff28F6E7),
          gradient: LinearGradient(
            colors: [
              Color(0xff1ED4C9),
              Color(0xff047677),
            ],
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: AutoSizeText(
            "اشتراک گذاری",
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

  _buildInviteTextContainer() {
    return Container(
      height: size.height * .2,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: size.width * .05),
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 5),
          ]),
      child: Center(
        child: AutoSizeText(
          "سلام، یه برنامه نصب کردم خیلی عالیه، هم اطلاعات و آموزش تغذیه سالم و طبی زیر نظر حکیم دکتر روازاده داره و هم اگر سوال پزشکی داشتی کارشناس های دکتر پاسخ سوالتون رو رایگان میدن. حتما نصبش کنید. لینک نصب: https://ravazadeh.com/app",
          maxLines: 6,
          maxFontSize: 28,
          minFontSize: 12,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ),
    );
  }
}
