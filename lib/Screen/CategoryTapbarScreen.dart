import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ehyasalamat/controllers/PostController.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/models/CategoryModel.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ehyasalamat/helpers/AlertHelper.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'SinglePostScreen.dart';

class CategoryTapbarScreen extends StatefulWidget {
  @override
  _CategoryTapbarScreenState createState() => _CategoryTapbarScreenState();
}

class _CategoryTapbarScreenState extends State<CategoryTapbarScreen> {
  PostController postController = Get.find<PostController>();
  CategoryController categoryController = Get.find<CategoryController>();
  bool load = false;
  Size size;
  int _current = 0;
  CarouselController buttonCarouselController = CarouselController();
  List imgList = [
    "assets/images/drravazadeh.png",
    "assets/images/drravazadeh.png",
    "assets/images/drravazadeh.png",
  ];
  bool isLoading = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    postController.getPost();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    postController.getPost();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  int page;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return _buildCategoriesItem();
  }

  _buildCategoriesItem() {
    if (postController.loading.value == false) {
      return LoadingDialog();
    }
    return Obx(
      () => Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
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
        ),
      ),
    );
  }

  _buildMainItem() {
    return Container(
      margin: EdgeInsets.only(top: size.height * .173),
      // height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(150),
          topRight: Radius.circular(150),
        ),
      ),
      child: AnimationLimiter(
        child: Column(
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
              SizedBox(
                height: size.height * .12,
              ),
              _buildItemList(),
              SizedBox(
                height: size.height * .03,
              ),
              _buildNewPostList(),
            ],
          ),
        ),
      ),
    );
  }

  _buildItemList() {
    return Container(
      height: size.height * .16,
      width: size.width,
      // margin: EdgeInsets.symmetric(horizontal: size.width * .05),
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
            itemCount: categoryController.categoriesList.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              CategoriesModel cat = categoryController.categoriesList[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .02,
                  vertical: size.height * .005,
                ),
                child: WidgetHelper.ItemContainer(
                    size: size,
                    icon: "assets/images/crona.png",
                    text: cat.name,
                    gColor1: Colors.red,
                    gColor2: Colors.blue),
              );
            },
          )),
        ],
      ),
    );
  }

  _buildNewPostList() {
    return Container(
      height: size.height * .2,
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: size.width * .02),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "جدیدترین مطالب",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff7366FF), fontSize: 14),
                ),
                Row(
                  children: [
                    AutoSizeText(
                      "مشاهده بلاگ همه مطالب",
                      maxLines: 1,
                      maxFontSize: 22,
                      minFontSize: 10,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff7366FF), fontSize: 12),
                    ),
                    SizedBox(
                      width: size.width * .01,
                    ),
                    Icon(Icons.arrow_forward_ios,
                        size: size.width * .03, color: Colors.black45),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Expanded(
            // child: ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: postController.postList.length,
            //   physics: BouncingScrollPhysics(),
            //   itemExtent: 200,
            //   controller: scroll,
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (BuildContext context, int index) {
            //     Result post = postController.postList[index];
            //     if(!this.load && index == postController.postList.length - 1){
            //       return Center(child: CupertinoActivityIndicator(),);
            //     }
            //     return WidgetHelper.ItemPostContainer(
            //       text: post.title,
            //       size: size,
            //       image: post.image,
            //       func: () {
            //         Navigator.push(
            //           context,
            //           PageTransition(
            //             type: PageTransitionType.fade,
            //             duration: Duration(milliseconds: 500),
            //             curve: Curves.easeInOutCubic,
            //             child: SinglePostScreen(
            //               post: post,
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            // )
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
                    height: size.height * .15,
                    width: size.width * .2,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              scrollDirection: Axis.horizontal,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Result post = postController.postList[index];
                  return WidgetHelper.ItemPostContainer(
                    text: post.title,
                    size: size,
                    image: post.image,
                    func: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOutCubic,
                          child: SinglePostScreen(
                            post: post,
                          ),
                        ),
                      );
                    },
                  );
                },
                itemCount: postController.postList.length,
              ),
            ),
          ),
        ],
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
              items: imgList.map((i) {
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
            count: imgList.length,
            effect: ExpandingDotsEffect(
                activeDotColor: Colors.black54,
                dotWidth: size.width * .016,
                dotHeight: size.height * .008),
          )
        ],
      ),
    );
  }

// _buildCat1() {
//   return Container(
//     height: size.height * .2,
//     width: size.width,
//     margin: EdgeInsets.symmetric(vertical: size.width * .02),
//     child: Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.width * .05),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               AutoSizeText(
//                 "آش ها",
//                 maxLines: 1,
//                 maxFontSize: 22,
//                 minFontSize: 10,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Color(0xff7366FF), fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: size.height * .02,
//         ),
//         Expanded(
//             child: ListView.builder(
//           itemCount: listOfPostsCat1.length,
//           physics: BouncingScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (BuildContext context, int index) {
//             PostModel post = listOfPostsCat1[index];
//             return WidgetHelper.ItemPostContainer(
//               text: post.title.rendered,
//               size: size,
//               image: post.thumbnail,
//               func: () {
//                 Navigator.push(
//                   context,
//                   PageTransition(
//                     type: PageTransitionType.fade,
//                     duration: Duration(milliseconds: 500),
//                     curve: Curves.easeInOutCubic,
//                     child: SinglePostScreen(
//                       post: post,
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         )),
//       ],
//     ),
//   );
// }
//
// _buildCat2() {
//   return Container(
//     height: size.height * .2,
//     width: size.width,
//     margin: EdgeInsets.symmetric(vertical: size.width * .02),
//     child: Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.width * .05),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               AutoSizeText(
//                 "آشپزخانه",
//                 maxLines: 1,
//                 maxFontSize: 22,
//                 minFontSize: 10,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Color(0xff7366FF), fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: size.height * .02,
//         ),
//         Expanded(
//             child: ListView.builder(
//               itemCount: listOfPostsCat2.length,
//               physics: BouncingScrollPhysics(),
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (BuildContext context, int index) {
//                 PostModel post = listOfPostsCat2[index];
//                 return WidgetHelper.ItemPostContainer(
//                   text: post.title.rendered,
//                   size: size,
//                   image: post.thumbnail,
//                   func: () {
//                     Navigator.push(
//                       context,
//                       PageTransition(
//                         type: PageTransitionType.fade,
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.easeInOutCubic,
//                         child: SinglePostScreen(
//                           post: post,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             )),
//       ],
//     ),
//   );
// }
//
// _buildCat3() {
//   return Container(
//     height: size.height * .2,
//     width: size.width,
//     margin: EdgeInsets.symmetric(vertical: size.width * .02),
//     child: Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.width * .05),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               AutoSizeText(
//                 "اخبار",
//                 maxLines: 1,
//                 maxFontSize: 22,
//                 minFontSize: 10,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Color(0xff7366FF), fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: size.height * .02,
//         ),
//         Expanded(
//             child: ListView.builder(
//               itemCount: listOfPostsCat3.length,
//               physics: BouncingScrollPhysics(),
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (BuildContext context, int index) {
//                 PostModel post = listOfPostsCat3[index];
//                 return WidgetHelper.ItemPostContainer(
//                   text: post.title.rendered,
//                   size: size,
//                   image: post.thumbnail,
//                   func: () {
//                     Navigator.push(
//                       context,
//                       PageTransition(
//                         type: PageTransitionType.fade,
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.easeInOutCubic,
//                         child: SinglePostScreen(
//                           post: post,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             )),
//       ],
//     ),
//   );
// }

  _buildAllCategoriesGridList() {
    return showCupertinoModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (context) {
        return Container(
          height: size.height * .8,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.symmetric(
              horizontal: size.width * .05, vertical: size.height * .02),
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
                    itemCount: categoryController.categoriesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 1,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      CategoriesModel cat =
                          categoryController.categoriesList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .005,
                            vertical: size.height * .005),
                        child: WidgetHelper.ItemContainer(
                            size: size,
                            icon: "assets/images/crona.png",
                            text: cat.name,
                            gColor1: Colors.red,
                            gColor2: Colors.blue),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
            ],
          ),
        );
      },
    );
  }
}
