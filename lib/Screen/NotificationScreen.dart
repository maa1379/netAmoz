import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/controllers/NotificationsController.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/models/InformsModel.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ehyasalamat/models/TabBarModel.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Size size;
  int _index = 0;
  bool isActive = false;
  PageController pageController = PageController();
  List<TabBarModel> TabBarList = [
    TabBarModel(
        id: 1,
        selected: true,
        title: "عمومی",
        image: "assets/images/public.png",
        func: () {}),
    TabBarModel(
      id: 2,
      selected: false,
      title: "خصوصی",
      image: "assets/images/secret.png",
    ),
    TabBarModel(
      id: 3,
      selected: false,
      title: "اختصاصی",
      image: "assets/images/secret2.png",
    ),
  ];

  List textList = [
    "اطلاعیه مهم احیای صحت و سلامت در این بخش قرار میگیرد نشانه گذاری های این اطلاعیه ها بسیار مهم و حائز اهمیت است. برای اینکه بیشتر با اطلاعیه ها آشنا شوید روی دکمه زیر ضربه بزنید.",
    "بار دیگر ما شاهد رفتارهای مشعشع از سوی کسانی هستیم که به جای اینکه در خدمت پزشکان باشند، علیه آنها فعالیت می کنند و خود را به صورت غیر قانونی جای قاضی نشانده و حکم صادر می کنند. کما فی السابق، این سازمان دست از دشمنی با بنده برنداشته و تمام توانش را به کار بسته تا در مسير سالیان طولانی خدمت به مردم کشورم و طب ایرانی – اسلامی، مانع ایجاد کند."
        "                            سازمان نظام پزشکی حکم یک اتحادیه را دارد که موظف است به پزشکان خدمات رسانی کند و اگر اختلاف یا دعوایی بین پزشکان و سازمان روی دهد، مسأله درون صنفی است و اگر حقیقت هم داشته باشد، نباید در رسانه ها منتشر شود. هرگاه قوه قضاییه از تعطیلی مطب اینجانب؛ حکیم دکتر حسین روازاده بحثی به میان آورد، قانونی و لازم الإجرا است."
        "                          سازمان نظام پزشکی حق تعطیل نمودن هيچ مطبی را ندارد و با انتشار حکم خلاف، خطای قانونی انجام داده است. این سازمان به دروغ درباره موضوعی که قوه قضاییه هیچ دستوری پیرامون آن صادر نکرده، اقدام غیر قانونی انجام داده و حتی اگر قوه قضاییه نيز حکم داده باشد که نداده است! به منظور صيانت از آبروی هم صنفان سازمانی خود، نمی بایست موضوع را رسانه ای کند. این سازمان، هم خلاف قانونی انجام داده و هم کار غیر اخلاقی مرتكب شده است."
        "                          این نیت و این حرکت کثیف از طرف کسانی است که چوب فعالیت های تشکیلات قدرتمند احیای سلامت، جامعه اسلامی حامیان کشاورزی ایران و کنفرانس بین المللی طب ایرانی – اسلامی را خورده و هلاک شده اند. بهتر است بدانند ما کار خود را در ترویج و تثبیت گفتمان طب ایرانی – اسلامی و اصلاح سبک زندگی انجام داده ایم و هرگز اجازه نمي دهيم نفوذی ها، سبک زندگی غربی را بر مردم تحمیل کنند.",
  ];

  NotificationsController notificationsController =
      Get.put(NotificationsController());

  @override
  void initState() {
    notificationsController.getNotifications(role: "public");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(()=>Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: (_index == 0)
                  ? AssetImage("assets/images/home_back.png")
                  : (_index == 1)
                  ? AssetImage("assets/images/ehyaTv-back.png")
                  : AssetImage("assets/images/radioEhya-back.png"),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .06,
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * .02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: size.height * .04,
                      width: size.width * .2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black12,
                              spreadRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "بازگشت",
                            maxLines: 1,
                            maxFontSize: 22,
                            minFontSize: 6,
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.black87, fontSize: 12),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            size: size.width * .05,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              _buildTapBar(),
              _buildPageView(),
            ],
          ),
        ),),
      ),
    );
  }

  _buildTapBar() {
    return Container(
      height: size.height * .08,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: size.width * .02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: TabBarList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .07),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TabBarList.forEach(
                          //   (element) {
                          //     element.selected = false;
                          //     setState(
                          //       () {
                          //         TabBarList[index].selected = true;
                          //         this.isActive = TabBarList[index].selected;
                          //       },
                          //     );
                          //     pageController.animateToPage(
                          //       index,
                          //       curve: Curves.easeIn,
                          //       duration: Duration(microseconds: 175),
                          //     );
                          //   },
                          // );
                          notificationsController.informsList.clear();
                          if (TabBarList[index].id == 1) {
                            notificationsController.getNotifications(
                                role: "public");
                            TabBarList.forEach(
                              (element) {
                                element.selected = false;
                                setState(
                                  () {
                                    TabBarList[index].selected = true;
                                    this.isActive = TabBarList[index].selected;
                                  },
                                );
                                pageController.animateToPage(
                                  index,
                                  curve: Curves.easeIn,
                                  duration: Duration(microseconds: 175),
                                );
                              },
                            );
                          }

                          if (TabBarList[index].id == 2) {
                            notificationsController.getNotifications(
                                role: "personal");
                            TabBarList.forEach(
                              (element) {
                                element.selected = false;
                                setState(
                                  () {
                                    TabBarList[index].selected = true;
                                    this.isActive = TabBarList[index].selected;
                                  },
                                );
                                pageController.animateToPage(
                                  index,
                                  curve: Curves.easeIn,
                                  duration: Duration(microseconds: 175),
                                );
                              },
                            );
                          }

                          if (TabBarList[index].id == 3) {
                            notificationsController.getNotifications(
                                role: "roles");
                            TabBarList.forEach(
                              (element) {
                                element.selected = false;
                                setState(
                                  () {
                                    TabBarList[index].selected = true;
                                    this.isActive = TabBarList[index].selected;
                                  },
                                );
                                pageController.animateToPage(
                                  index,
                                  curve: Curves.easeIn,
                                  duration: Duration(microseconds: 175),
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .17,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                TabBarList[index].image,
                                width: size.width * .06,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: size.height * .005,
                              ),
                              AutoSizeText(
                                TabBarList[index].title,
                                maxLines: 1,
                                maxFontSize: 22,
                                minFontSize: 10,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      (TabBarList[index].selected)
                          ? Container(
                              // margin: EdgeInsets.only(left: this.size.width * .01),
                              height: size.height * .002,
                              width: this.size.width * .2,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildPageView() {
    return Expanded(
      child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(
            () {
              this._index = page;
            },
          );
        },
        children: [
          _buildPublicNot(),
          _buildPublicNot(),
          _buildPublicNot(),
        ],
      ),
    );
  }

  _buildPublicNot() {
    if(!notificationsController.loading.value){
     return LoadingDialog();
    }
    return Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.only(top: size.height * .02),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: notificationsController.informsList.length,
          itemBuilder: _itemBuilder),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    InformsModel inform = notificationsController.informsList[index];
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * .02, horizontal: size.width * .02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            // delay: Duration(milliseconds: 150),
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 100.0,
              child: FadeInAnimation(
                curve: Curves.easeInOutCubic,
                child: widget,
              ),
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05, vertical: size.height * .01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        AutoSizeText(
                          inform.topic,
                          maxFontSize: 22,
                          minFontSize: 10,
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: size.height * .03,
                      width: size.width * .15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                        color: Colors.white,
                        gradient: LinearGradient(
                            colors: [
                              Color(0xffFF8818),
                              Color(0xffFFCF1B),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          inform.classification,
                          maxFontSize: 22,
                          minFontSize: 8,
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.black87, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .06),
                child: AutoSizeText(
                  inform.text,
                  maxFontSize: 22,
                  minFontSize: 10,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              // Container(
              //   height: size.height * .05,
              //   width: size.width * .35,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(50),
              //     color: Colors.white,
              //     gradient: LinearGradient(colors: [
              //       Color(0xff047677),
              //       Color(0xff28F6E7),
              //     ], begin: Alignment.topRight, end: Alignment.bottomLeft),
              //   ),
              //   child: Center(
              //     child: AutoSizeText(
              //       "اطلاعات بیشتر",
              //       maxFontSize: 22,
              //       minFontSize: 8,
              //       softWrap: true,
              //       textAlign: TextAlign.justify,
              //       style: TextStyle(color: Colors.white, fontSize: 16),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: size.height * .05,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .05, bottom: size.height * .01),
                  child: AutoSizeText(
                    inform.createdAt,
                    maxFontSize: 22,
                    minFontSize: 10,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
