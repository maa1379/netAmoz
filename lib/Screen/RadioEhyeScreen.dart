import 'dart:convert';

import 'package:animate_icons/animate_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/MediaModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'SingleRadioScreen.dart';

extension jalalDate on Jalali {
  String jDate() {
    return "${this.formatter.yyyy}/${this.formatter.mm}/${this.formatter.dd}";
  }
}

class RadioEhyeScreen extends StatefulWidget {
  @override
  _RadioEhyeScreenState createState() => _RadioEhyeScreenState();
}

class _RadioEhyeScreenState extends State<RadioEhyeScreen> {
  Size size;
  int _current = 0;
  bool isActive = false;
  bool grid = false;
  ScrollController scrollController = ScrollController();
  CarouselController buttonCarouselController = CarouselController();

  List get imgList => [
        "assets/images/drravazadeh.png",
        "assets/images/drravazadeh.png",
        "assets/images/drravazadeh.png",
      ];

  TextEditingController searchTextEditingController = TextEditingController();


  // List get imgList => this.listOfAudios.map((e) => e.);

  int specialId = 15646;
  int mainId = 15648;
  AnimateIconController c1;

  bool isLoading = true;

  int page = 1;

  List<MediaModel> listOfAudios = [];
  FRefreshController controller = FRefreshController();

  @override
  void initState() {
    c1 = AnimateIconController();
    this.getPosts();
    super.initState();
  }

  bool onEndIconPress(BuildContext context) {
    setState(() {
      this.grid = false;
    });
    return true;
  }

  bool onStartIconPress(BuildContext context) {
    setState(() {
      this.grid = true;
    });
    return true;
  }

  String value = "";

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: size.height,
        width: size.width,
        child: _buildCategoriesItem(),
      ),
    );
  }

  _buildCategoriesItem() {
    if (this.isLoading) {
      return LoadingDialog();
    }
    return SingleChildScrollView(
      child: AnimationLimiter(
        child: Stack(
          children: AnimationConfiguration.toStaggeredList(
            delay: Duration(milliseconds: 125),
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 100.0,
              child: FadeInAnimation(
                curve: Curves.easeInOutCubic,
                child: widget,
              ),
            ),
            children: [
              _buildMainItem(),
              _buildTopSlider(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTopSlider() {
    return Container(
      height: size.height * .25,
      width: size.width,
      margin: EdgeInsets.only(
        top: size.height * .02,
      ),
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: listOfAudios.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/636578_472.jpg",
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                      ),
                    );
                  },
                );
              }).toList(),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                reverse: false,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                height: size.width,
                onPageChanged: (page, reason) {
                  setState(() {
                    _current = page;
                  });
                },
                aspectRatio: 2.0,
                initialPage: _current,
              ),
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          AnimatedSmoothIndicator(
            activeIndex: _current,
            onDotClicked: (value) {
              setState(() {
                _current = value;
              });
            },
            count: listOfAudios.length,
            effect: ExpandingDotsEffect(
                activeDotColor: Colors.black54,
                dotWidth: size.width * .016,
                dotHeight: size.height * .008),
          )
        ],
      ),
    );
  }

  _buildMainItem() {
    return Container(
      height: size.height,
      width: size.width,
      margin: EdgeInsets.only(top: size.height * .173),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(150),
          topRight: Radius.circular(150),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height * .12,
          ),
          _buildItemList(),
          _buildIcon(),
          (this.grid) ? _buildListITem() : _buildGridITem(),
        ],
      ),
    );
  }

  _buildItemList() {
    return Container(
      height: size.height * .16,
      width: size.width,
      // margin: EdgeInsets.symmetric(horizontal: size.width * .02),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "بخش های ویژه",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff7366FF), fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    _buildAllCategoriesGridList();
                  },
                  child: Row(
                    children: [
                      AutoSizeText(
                        "مشاهده همه بخش ها",
                        maxLines: 1,
                        maxFontSize: 22,
                        minFontSize: 10,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff7366FF), fontSize: 12),
                      ),
                      SizedBox(
                        width: size.width * .01,
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: size.width * .03, color: Colors.black45),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .02,
                    vertical: size.height * .005,
                  ),
                  child: WidgetHelper.ItemContainer(
                      size: size,
                      icon: "assets/images/crona.png",
                      text: "بخش کرونا",
                      gColor1: Colors.red,
                      gColor2: Colors.blue),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildAllCategoriesGridList() {
    return showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: size.height * .2),
          child: Container(
            height: size.height * .6,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * .03),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              size: size.width * .1,
                              color: Color(0xff7366FF),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.width * .03),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            AutoSizeText(
                              "همه دسته بندی ها",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff7366FF), fontSize: 16),
                            ),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Image.asset(
                              "assets/images/copy.png",
                              width: size.width * .1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                    child: GridView.builder(
                      itemCount: 20,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 1,
                      ),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .005,
                              vertical: size.height * .005),
                          child: WidgetHelper.ItemContainer(
                              size: size,
                              icon: "assets/images/crona.png",
                              text: "بخش کرونا",
                              gColor1: Colors.red,
                              gColor2: Colors.blue),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildIcon() {
    return Container(
      height: size.height * .08,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: size.width * .06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container(
          //   height: size.height * .03,
          //   width: size.width * .3,
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(15),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.black12, blurRadius: 5, spreadRadius: 2),
          //       ]),
          //   child: _buildDropDown(),
          // ),
          SizedBox(
            height: size.width * .02,
          ),
          _searchTextField(),
          SizedBox(
            width: size.width * .02,
          ),
          AnimateIcons(
            startIcon: Icons.grid_on_outlined,
            endIcon: Icons.list_outlined,
            controller: c1,
            endIconColor: Colors.black54,
            startIconColor: Colors.black54,
            size: 35.0,
            duration: Duration(milliseconds: 250),
            onEndIconPress: () => onEndIconPress(context),
            onStartIconPress: () => onStartIconPress(context),
          )
        ],
      ),
    );
  }

  _buildDropDown() {
    return DropdownButton(
      hint: value == null
          ? Center(child: Text('Dropdown'))
          : Center(
              child: Text(
                value,
                style: TextStyle(color: Colors.blue),
              ),
            ),
      underline: Container(),
      isExpanded: true,
      iconSize: 30.0,
      // borderRadius: BorderRadius.circular(15),
      style: TextStyle(color: Colors.blue),
      items: ['One', 'Two', 'Three'].map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
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

  _buildListITem() {
    return Expanded(
      child: FRefresh(
        controller: controller,
        footerHeight: this.size.height / 8,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: this.listOfAudios.length,
          itemBuilder: itemBuilder,
        ),
        footer: Container(
          height: this.size.height / 8,
          child: LoadingDialog(),
        ),
        onLoad: () async {
          this.setState(() {
            this.page++;
          });
          await this.getPosts();
          controller.finishRefresh();
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    MediaModel post = this.listOfAudios[index];
    if (searchTextEditingController.text.isEmpty) {
      return GestureDetector(
        onTap: () {
          Get.to(SingleRadioScreen(
            post: post,
          ));
        },
        child: Container(
          height: size.height * .16,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: size.width * .02),
          margin: EdgeInsets.symmetric(
              horizontal: size.width * .05,
              vertical: (index == 0) ? 0 : size.height * .02),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Image.asset(
                  "assets/images/audio-thumbnail.png",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: size.height * .05,
                      width: size.width * .55,
                      margin: EdgeInsets.only(
                          right: size.width * .05, top: size.height * .01),
                      child: AutoSizeText(
                        post.title.rendered,
                        maxLines: 2,
                        maxFontSize: 22,
                        minFontSize: 12,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: size.height,
                      width: size.width * .55,
                      margin: EdgeInsets.only(
                          right: size.width * .05, top: size.height * .01),
                      child: Html(
                        data: post.caption.rendered,
                      ),
                      // AutoSizeText(
                      //
                      //       .replaceAll('<p>', '')
                      //       .replaceAll('</p>', ''),
                      //   maxLines: 4,
                      //   maxFontSize: 22,
                      //   minFontSize: 10,
                      //   textAlign: TextAlign.start,
                      //   softWrap: true,
                      //   style: TextStyle(
                      //     color: Colors.black38,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: size.height * .04,
                      width: size.width * .55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * .01,
                          ),
                          AutoSizeText(
                            "1400/05/23",
                            maxLines: 4,
                            maxFontSize: 22,
                            minFontSize: 6,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Image.asset(
                            "assets/images/Union 2.png",
                            width: size.width * .05,
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Image.asset("assets/images/Comment.png"),
                          Container(
                            margin: EdgeInsets.only(right: size.width * .04),
                            height: size.height * .025,
                            width: size.width * .2,
                            decoration: BoxDecoration(
                              color: Color(0xff28F6E7),
                              gradient: LinearGradient(colors: [
                                Color(0xff1ED4C9),
                                Color(0xff047677),
                              ]),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                "ادامه مطلب",
                                maxLines: 1,
                                maxFontSize: 18,
                                minFontSize: 6,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (post.title.rendered
            .toLowerCase()
            .contains(searchTextEditingController.text) ||
        post.title.rendered
            .toLowerCase()
            .contains(searchTextEditingController.text)) {
      return GestureDetector(
        onTap: () {
          Get.to(SingleRadioScreen(
            post: post,
          ));
        },
        child: Container(
          height: size.height * .16,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: size.width * .02),
          margin: EdgeInsets.symmetric(
              horizontal: size.width * .05,
              vertical: (index == 0) ? 0 : size.height * .02),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Image.asset(
                  "assets/images/audio-thumbnail.png",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: size.height * .05,
                      width: size.width * .55,
                      margin: EdgeInsets.only(
                          right: size.width * .05, top: size.height * .01),
                      child: AutoSizeText(
                        post.title.rendered,
                        maxLines: 2,
                        maxFontSize: 22,
                        minFontSize: 12,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: size.height,
                      width: size.width * .55,
                      margin: EdgeInsets.only(
                          right: size.width * .05, top: size.height * .01),
                      child: Html(
                        data: post.caption.rendered,
                      ),
                      // AutoSizeText(
                      //
                      //       .replaceAll('<p>', '')
                      //       .replaceAll('</p>', ''),
                      //   maxLines: 4,
                      //   maxFontSize: 22,
                      //   minFontSize: 10,
                      //   textAlign: TextAlign.start,
                      //   softWrap: true,
                      //   style: TextStyle(
                      //     color: Colors.black38,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: size.height * .04,
                      width: size.width * .55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * .01,
                          ),
                          AutoSizeText(
                            "1400/05/23",
                            maxLines: 4,
                            maxFontSize: 22,
                            minFontSize: 6,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Image.asset(
                            "assets/images/Union 2.png",
                            width: size.width * .05,
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Image.asset("assets/images/Comment.png"),
                          Container(
                            margin: EdgeInsets.only(right: size.width * .04),
                            height: size.height * .025,
                            width: size.width * .2,
                            decoration: BoxDecoration(
                              color: Color(0xff28F6E7),
                              gradient: LinearGradient(colors: [
                                Color(0xff1ED4C9),
                                Color(0xff047677),
                              ]),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                "ادامه مطلب",
                                maxLines: 1,
                                maxFontSize: 18,
                                minFontSize: 6,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _buildGridITem() {
    return Expanded(
      child: GridView.builder(
        itemCount: listOfAudios.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 0.6,
        ),
        itemBuilder: itemGridBuilder,
      ),
    );
  }

  Widget itemGridBuilder(BuildContext context, int index) {
    MediaModel post = this.listOfAudios[index];
    if (searchTextEditingController.text.isEmpty) {
      return GestureDetector(
        onTap: () {
          Get.to(SingleRadioScreen(
            post: post,
          ));
        },
        child: Container(
          height: size.height * .4,
          width: size.width * .3,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Image.asset(
                  "assets/images/audio-thumbnail.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: size.height * .005,
              ),
              Flexible(
                flex: 1,
                child: AutoSizeText(
                  post.title.rendered,
                  maxLines: 2,
                  maxFontSize: 22,
                  minFontSize: 12,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: size.height * .025,
                  width: size.width * .2,
                  decoration: BoxDecoration(
                    color: Color(0xff28F6E7),
                    gradient: LinearGradient(colors: [
                      Color(0xff1ED4C9),
                      Color(0xff047677),
                    ]),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      "ادامه مطلب",
                      maxLines: 1,
                      maxFontSize: 18,
                      minFontSize: 6,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .01, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .02,
                      ),
                      AutoSizeText(
                        Jalali.fromDateTime(post.date).jDate(),
                        maxLines: 4,
                        maxFontSize: 22,
                        minFontSize: 6,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        width: size.width * .01,
                      ),
                      Image.asset("assets/images/Union 2.png"),
                      SizedBox(
                        width: size.width * .01,
                      ),
                      Image.asset("assets/images/Comment.png"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (post.title.rendered
            .toLowerCase()
            .contains(searchTextEditingController.text) ||
        post.title.rendered
            .toLowerCase()
            .contains(searchTextEditingController.text)) {
      return GestureDetector(
        onTap: () {
          Get.to(SingleRadioScreen(
            post: post,
          ));
        },
        child: Container(
          height: size.height * .4,
          width: size.width * .3,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Image.asset(
                  "assets/images/audio-thumbnail.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: size.height * .005,
              ),
              Flexible(
                flex: 1,
                child: AutoSizeText(
                  post.title.rendered,
                  maxLines: 2,
                  maxFontSize: 22,
                  minFontSize: 12,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: size.height * .025,
                  width: size.width * .2,
                  decoration: BoxDecoration(
                    color: Color(0xff28F6E7),
                    gradient: LinearGradient(colors: [
                      Color(0xff1ED4C9),
                      Color(0xff047677),
                    ]),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      "ادامه مطلب",
                      maxLines: 1,
                      maxFontSize: 18,
                      minFontSize: 6,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .01, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .02,
                      ),
                      AutoSizeText(
                        Jalali.fromDateTime(post.date).jDate(),
                        maxLines: 4,
                        maxFontSize: 22,
                        minFontSize: 6,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        width: size.width * .01,
                      ),
                      Image.asset("assets/images/Union 2.png"),
                      SizedBox(
                        width: size.width * .01,
                      ),
                      Image.asset("assets/images/Comment.png"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _searchTextField() {
    return WidgetHelper.textField(
      icon: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * .015),
        child: Image.asset(
          "assets/images/search.png",
          color: Colors.black45,
        ),
      ),
      text: "جستجو",
      hintText: "جستجو ...",
      width: size.width * .65,
      height: size.height * .06,
      // color: Color(0xfff5f5f5),
      size: size,
      fontSize: 16,
      controller: searchTextEditingController,
      onChange: (text) {
        // _searchFunction();
      },
      maxLine: 1,
      keyBoardType: TextInputType.text,
      obscureText: false,
      maxLength: 11,
    );
  }

  void getPosts() async {
    this.setState(() {
      this.isLoading = page == 1;
    });
    ApiResult result = await RequestHelper.search(
      '',
      'media',
      'audio',
      this.page,
      this.mainId,
    );

    this.setState(() {
      this
          .listOfAudios
          .addAll(MediaModel.listFromJson(jsonDecode(result.data)));
      this.isLoading = false;
    });
  }
}
