import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/models/CategoryModel.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ehyasalamat/helpers/AlertHelper.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'SinglePostScreen.dart';

class CategoryTapbarScreen extends StatefulWidget {
  @override
  _CategoryTapbarScreenState createState() => _CategoryTapbarScreenState();
}

class _CategoryTapbarScreenState extends State<CategoryTapbarScreen> {
  Size size;
  List<PostModel> listOfPosts = [];
  List<PostModel> listOfPostsCat1 = [];
  List<PostModel> listOfPostsCat2 = [];
  List<PostModel> listOfPostsCat3 = [];
  List<CategoryModel> listOfCategory = [];
  int _current = 0;
  CarouselController buttonCarouselController = CarouselController();
  List imgList = [
    "assets/images/drravazadeh.png",
    "assets/images/drravazadeh.png",
    "assets/images/drravazadeh.png",
  ];
  bool isLoading = false;

  void getLastPosts() async {
    this.setState(() {
      this.isLoading = true;
    });
    ApiResult result = await RequestHelper.lastPosts();

    if (result.isDone) {
      this.listOfPosts = PostModel.listFromJson(jsonDecode(result.data));
      getCategories();
    }
  }

  void getPostCat1() async {
    this.setState(() {
      this.isLoading = true;
    });
    ApiResult result = await RequestHelper.postsCat(id: 85, page: 1);

    if (result.isDone) {
      this.listOfPostsCat1 = PostModel.listFromJson(jsonDecode(result.data));
      getPostCat2();
    }
  }

  void getPostCat2() async {
    this.setState(() {
      this.isLoading = true;
    });
    ApiResult result = await RequestHelper.postsCat(id: 81, page: 1);

    if (result.isDone) {
      this.listOfPostsCat2 = PostModel.listFromJson(jsonDecode(result.data));
      getPostCat3();
    }
  }


  void getPostCat3() async {
    this.setState(() {
      this.isLoading = true;
    });
    ApiResult result = await RequestHelper.postsCat(id: 71, page: 1);

    if (result.isDone) {
      this.listOfPostsCat3 = PostModel.listFromJson(jsonDecode(result.data));
      setState(() {
        isLoading = false;
      });
    }
  }

  void getCategories() async {
    this.setState(() {
      this.isLoading = true;
    });
    ApiResult result = await RequestHelper.categoryList();

    if (result.isDone) {
      this.listOfCategory = CategoryModel.listFromJson(jsonDecode(result.data));
      getPostCat1();
    }
  }

  @override
  void initState() {
    getLastPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return _buildCategoriesItem();
  }

  _buildCategoriesItem() {
    if (this.isLoading) {
      return LoadingDialog();
    }
    return Container(
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
        ));
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
              _buildCat1(),
              _buildCat2(),
              _buildCat3(),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  "بخش های ویژه",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff7366FF), fontSize: 14),
                ),
                // GestureDetector(
                //   onTap: () {
                //     _buildAllCategoriesGridList();
                //   },
                //   child: Row(
                //     children: [
                //       AutoSizeText(
                //         "مشاهده همه بخش ها",
                //         maxLines: 1,
                //         maxFontSize: 22,
                //         minFontSize: 10,
                //         textAlign: TextAlign.center,
                //         style:
                //             TextStyle(color: Color(0xff7366FF), fontSize: 12),
                //       ),
                //       SizedBox(
                //         width: size.width * .01,
                //       ),
                //       Icon(Icons.arrow_forward_ios,
                //           size: size.width * .03, color: Colors.black45),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: listOfCategory.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              CategoryModel cat = listOfCategory[index];
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
              child: ListView.builder(
            itemCount: listOfPosts.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              PostModel post = listOfPosts[index];
              return WidgetHelper.ItemPostContainer(
                text: post.title.rendered,
                size: size,
                image: post.thumbnail,
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
          )),
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

  _buildCat1() {
    return Container(
      height: size.height * .2,
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: size.width * .02),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  "آش ها",
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
            itemCount: listOfPostsCat1.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              PostModel post = listOfPostsCat1[index];
              return WidgetHelper.ItemPostContainer(
                text: post.title.rendered,
                size: size,
                image: post.thumbnail,
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
          )),
        ],
      ),
    );
  }

  _buildCat2() {
    return Container(
      height: size.height * .2,
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: size.width * .02),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  "آشپزخانه",
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
                itemCount: listOfPostsCat2.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  PostModel post = listOfPostsCat2[index];
                  return WidgetHelper.ItemPostContainer(
                    text: post.title.rendered,
                    size: size,
                    image: post.thumbnail,
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
              )),
        ],
      ),
    );
  }

  _buildCat3() {
    return Container(
      height: size.height * .2,
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: size.width * .02),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  "اخبار",
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
                itemCount: listOfPostsCat3.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  PostModel post = listOfPostsCat3[index];
                  return WidgetHelper.ItemPostContainer(
                    text: post.title.rendered,
                    size: size,
                    image: post.thumbnail,
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
              )),
        ],
      ),
    );
  }

// _buildAllCategoriesGridList({CategoryModel cat}) {
//   return showMaterialModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     isDismissible: true,
//     enableDrag: false,
//     context: context,
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.only(bottom: size.height * .2),
//         child: Container(
//           height: size.height * .6,
//           width: size.width,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           margin: EdgeInsets.symmetric(horizontal: size.width * .05),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(size.width * .03),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Icon(
//                             Icons.close,
//                             size: size.width * .1,
//                             color: Color(0xff7366FF),
//                           )),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(size.width * .03),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: Row(
//                         children: [
//                           AutoSizeText(
//                             "همه دسته بندی ها",
//                             maxLines: 1,
//                             maxFontSize: 22,
//                             minFontSize: 10,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Color(0xff7366FF), fontSize: 16),
//                           ),
//                           SizedBox(
//                             width: size.width * .02,
//                           ),
//                           Image.asset(
//                             "assets/images/copy.png",
//                             width: size.width * .1,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: size.width * .02),
//                   child: GridView.builder(
//                     itemCount: 20,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 5.0,
//                       mainAxisSpacing: 5.0,
//                       childAspectRatio: 1,
//                     ),
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: size.width * .005,
//                             vertical: size.height * .005),
//                         child: WidgetHelper.ItemContainer(
//                             size: size,
//                             icon: "assets/images/crona.png",
//                             text: "بخش کرونا",
//                             gColor1: Colors.red,
//                             gColor2: Colors.blue),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: size.height * .05,
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

}
