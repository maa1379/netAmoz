import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ehyasalamat/Screen/RadioEhyeScreen.dart';
import 'package:ehyasalamat/bloc/ProfileBloc.dart';
import 'package:ehyasalamat/helpers/AlertHelper.dart';
import 'package:ehyasalamat/helpers/NavHelper.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/DrawerModel.dart';
import 'package:ehyasalamat/models/TabBarModel.dart';
import 'package:ehyasalamat/widgets/ConsultingWidget.dart';
import 'package:ehyasalamat/widgets/EditProfileWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'AboutUsScreen.dart';
import 'CategoryTapbarScreen.dart';
import 'ContactUsScreen.dart';
import 'EditProfileScreen.dart';
import 'EhyaTvScreen.dart';
import 'IncreasePointsScreen.dart';
import 'InviteFriendScreen.dart';
import 'SupportScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size size;
  int _index = 0;
  int isPage = 2;
  bool isActive = false;
  PageController pageController = PageController();
  PageController controller = PageController(initialPage: 2);
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey<NavigatorState> _key = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!getProfileBlocInstance.profile.profileDone) {
        AlertHelpers.UpdateProfileDialog(
            size: size,
            context: Get.context,
            func: () {
              NavHelper.push(context, EditProfileScreen());
            },
            func2: () {
              Navigator.of(context).pop();
            });
      } else {
        print("profile ok***");
      }
    });
  }

  List<TabBarModel> TabBarList = [
    TabBarModel(
      id: 1,
      selected: true,
      title: "دسته بندی",
      image: "assets/images/041-folder.png",
    ),
    TabBarModel(
      id: 2,
      selected: false,
      title: "احیا تی وی",
      image: "assets/images/Component 18 – 1.png",
    ),
    TabBarModel(
      id: 3,
      selected: false,
      title: "رادیو احیا",
      image: "assets/images/Component 18 – 1.png",
    ),
  ];

  List<DrawerModel> DrawerList = [
    DrawerModel(
      id: 1,
      title: "پروفایل من",
      icon: "assets/images/1.png",
      func: EditProfileScreen(),
    ),
    DrawerModel(
      id: 2,
      title: "افزایش امتیاز",
      icon: "assets/images/2.png",
      func: IncreasePointsScreen(),
    ),
    DrawerModel(
      id: 3,
      title: "پشتیبانی",
      icon: "assets/images/3.png",
      func: SupportScreen(),
    ),
    DrawerModel(
      id: 4,
      title: "آموزش کار با اپلیکیشن",
      icon: "assets/images/4.png",
    ),
    DrawerModel(
      id: 5,
      title: "بیوگرافی حکیم دکتر روازاده",
      icon: "assets/images/5.png",
    ),
    DrawerModel(
      id: 6,
      title: "دعوت از دوستان",
      icon: "assets/images/6.png",
      func: InviteFriendScreen(),
    ),
    DrawerModel(
      id: 7,
      title: "درباره ما",
      icon: "assets/images/7.png",
      func: AboutUsScreen(),
    ),
    DrawerModel(
      id: 8,
      title: "تماس با ما",
      icon: "assets/images/8.png",
      func: ContactUsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => AlertHelpers.ExitDialog(size: size, context: context),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: key,
          drawer: Align(
            alignment: Alignment.bottomCenter,
            child: WidgetHelper.drawerWidget(
                size: size, itemList: DrawerList, context: context, key: key),
          ),
          bottomNavigationBar: _buildNavBar(),
          body: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (isPage == 0)
                    ? AssetImage("assets/images/radioEhya-back.png")
                    : (isPage == 1)
                        ? AssetImage("assets/images/home_back.png")
                        : (isPage == 2)
                            ? AssetImage("assets/images/home_back.png")
                            : (isPage == 3)
                                ? AssetImage("assets/images/back 1.png")
                                : AssetImage("assets/images/Ganjineh.png"),
              ),
            ),
            child: Column(
              children: [
                (isPage == 2)
                    ? Container()
                    : WidgetHelper.appBar(
                        size: size, key: key, context: context),
                Expanded(
                  child: Container(
                    height: double.maxFinite,
                    width: size.width,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller,
                      onPageChanged: (page) {
                        setState(
                          () {
                            isPage = page;
                          },
                        );
                      },
                      children: [
                        EditProfileWidget(),
                        ConsultingWidget(),
                        _buildCategories(),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildCategories() {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: (_index == 0)
              ? AssetImage("assets/images/home_back.png")
              : (_index == 1)
                  ? AssetImage("assets/images/back 1.png")
                  : (_index == 2)
                      ? AssetImage("assets/images/radioEhya-back.png")
                      : (_index == 3)
                          ? AssetImage("assets/images/back 1.png")
                          : AssetImage("assets/images/Ganjineh.png"),
        ),
      ),
      child: Column(
        children: [
          WidgetHelper.appBar(size: size, key: key, context: context),
          _buildTapBar(),
          Expanded(
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
                CategoryTapbarScreen(),
                EhyaTvScreen(),
                RadioEhyeScreen(),
              ],
            ),
          ),
        ],
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

  _buildNavBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: isPage,
      letIndexChange: (index) => true,
      items: [
        Image.asset(
          "assets/images/user.png",
          width: 30,
        ),
        Image.asset(
          "assets/images/pm.png",
          width: 30,
        ),
        Image.asset(
          "assets/images/home.png",
          width: 30,
        ),
        Image.asset(
          "assets/images/tabadol.png",
          width: 30,
        ),
        Image.asset(
          "assets/images/ganjine.png",
          width: 30,
        ),
      ],
      height: 60,
      onTap: (index) {
        setState(() {
          isPage = index;
          controller.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
        });
      },
    );
  }
}
