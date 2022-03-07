import 'package:animate_icons/animate_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ehyasalamat/controllers/PostController.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'SingleTvScreen.dart';

extension jalalDate on Jalali {
  String jDate() {
    return "${this.formatter.yyyy}/${this.formatter.mm}/${this.formatter.dd}";
  }
}

class EhyaTvScreen extends StatefulWidget {
  @override
  _EhyaTvScreenState createState() => _EhyaTvScreenState();
}

class _EhyaTvScreenState extends State<EhyaTvScreen> {
  PostController postController = Get.find<PostController>();

  Size size;
  int _current = 0;
  bool isActive = false;
  bool grid = false;
  CarouselController buttonCarouselController = CarouselController();
  TextEditingController searchTextEditingController = TextEditingController();

  // int page = 1;
  List get imgList => [
        "assets/images/drravazadeh.png",
        "assets/images/drravazadeh.png",
        "assets/images/drravazadeh.png",
      ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    postController.getTVPost();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    postController.tvPage + 1;
    postController.getTVPost();
    // if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  AnimateIconController c1;

  bool isLoading = true;

  // int page = 1;

  @override
  void initState() {
    c1 = AnimateIconController();
    // this.getPosts();
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
          child: Obx(
            () => _buildCategoriesItem(),
          )),
    );
  }

  _buildCategoriesItem() {
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
              items: postController.tvSpecialPostList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(SingleTvScreen(post: i));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          image: i.image,
                          placeholder: "assets/anim/loading.gif",
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                        ),
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
            count: postController.tvSpecialPostList.length,
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
      height: size.height * .2,
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
                  "پست های ویژه",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff7366FF), fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: postController.tvSpecialPostList.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .02,
                    vertical: size.height * .005,
                  ),
                  child: WidgetHelper.ItemPostContainer(
                    text: postController.tvSpecialPostList[index].title,
                    size: size,
                    image: postController.tvSpecialPostList[index].image,
                    func: () {
                      Get.to(
                        () => SingleTvScreen(
                          post: postController.tvSpecialPostList[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
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


  _buildListITem() {
    return Expanded(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Get.find<PostController>().tvPostList.length,
        itemBuilder: itemBuilder,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    Result post = Get.find<PostController>().tvPostList[index];

    if (searchTextEditingController.text.isEmpty) {
      return GestureDetector(
        onTap: () {
          Get.to(SingleTvScreen(
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
                child: FadeInImage.assetNetwork(
                  image: post.image,
                  placeholder: "assets/anim/loading.gif",
                  fit: BoxFit.cover,
                  width: double.maxFinite,
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
                        post.title,
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
                      child: Text(
                        post.shortDescription,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                            post.datePublished,
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
    } else if (post.title
            .toLowerCase()
            .contains(searchTextEditingController.text) ||
        post.title.toLowerCase().contains(searchTextEditingController.text)) {
      return GestureDetector(
        onTap: () {
          Get.to(SingleTvScreen(
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
                child: FadeInImage.assetNetwork(
                  image: post.image,
                  placeholder: "assets/anim/loading.gif",
                  fit: BoxFit.cover,
                  width: double.maxFinite,
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
                        post.title,
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
                        data: post.shortDescription,
                      ),
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
                            post.datePublished,
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
        child: SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("بکشید");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("درحال دریافت");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("درحال دریافت");
          } else {
            body = Text("اطللاعاتی دریافت نشد");
          }
          return Container(
            alignment: Alignment.center,
            height: Get.height * .15,
            width: Get.width * .2,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      scrollDirection: Axis.vertical,
      onLoading: _onLoading,
      child: GridView.builder(
        itemCount: Get.find<PostController>().tvPostList.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: itemGridBuilder,
      ),
    ));
  }

  Widget itemGridBuilder(BuildContext context, int index) {
    Result post = Get.find<PostController>().tvPostList[index];
    if (searchTextEditingController.text.isEmpty) {
      return GestureDetector(
        onTap: () {
          Get.to(SingleTvScreen(
            post: post,
          ));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * .02,
            // vertical: size.height * .005,
          ),
          child: WidgetHelper.ItemPostContainer(
            text: postController.tvPostList[index].title,
            size: size,
            image: postController.tvPostList[index].image,
            func: () {
              Get.to(
                    () => SingleTvScreen(
                  post: postController.tvPostList[index],
                ),
              );
            },
          ),
        )
      );
    } else if (post.title
            .toLowerCase()
            .contains(searchTextEditingController.text) ||
        post.title.toLowerCase().contains(searchTextEditingController.text)) {
      return GestureDetector(
        onTap: () {
          Get.to(SingleTvScreen(
            post: post,
          ));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * .02,
            // vertical: size.height * .005,
          ),
          child: WidgetHelper.ItemPostContainer(
            text: postController.tvPostList[index].title,
            size: size,
            image: postController.tvPostList[index].image,
            func: () {
              Get.to(
                    () => SingleTvScreen(
                  post: postController.tvPostList[index],
                ),
              );
            },
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

// void getPosts() async {
//   this.setState(() {
//     this.isLoading = page == 1;
//   });
//   ApiResult result = await RequestHelper.search(
//     '',
//     'media',
//     'video',
//     this.page,
//     this.mainId,
//   );
//
//   this.setState(() {
//     this
//         .listOfVideos
//         .addAll(MediaModel.listFromJson(jsonDecode(result.data)));
//     this.isLoading = false;
//   });
// }
}
