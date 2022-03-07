import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/Screen/SinglePostScreen.dart';
import 'package:ehyasalamat/Screen/SingleRadioScreen.dart';
import 'package:ehyasalamat/Screen/SingleTvScreen.dart';
import 'package:ehyasalamat/controllers/PostController.dart';
import 'package:ehyasalamat/helpers/AlertHelper.dart';
import 'package:ehyasalamat/helpers/ImageHelpers.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SearchModalWidget extends StatefulWidget {
  @override
  _SearchModalWidgetState createState() => _SearchModalWidgetState();
}

class _SearchModalWidgetState extends State<SearchModalWidget> {
  PostController postController = Get.find<PostController>();

  Size size;
  bool isDeleted = false;
  bool hasSearch = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void dispose() {
    postController.allPostListS.clear();
    postController.postListS.clear();
    postController.tvPostListS.clear();
    postController.rPostListS.clear();
    postController.loadingSearch.value = false;
    postController.hasSearch.value = false;
    hasSearch = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() {
        return Container(
          height: size.height * .87,
          width: size.width,
          child: _buildAllCategoriesGridList(),
        );
      }),
    );
  }

  _buildAllCategoriesGridList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: size.width * .02),
      child: Column(
        children: [
          SizedBox(
            height: size.height * .02,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: size.height * .06,
                  child: _searchTextField(),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              GestureDetector(
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
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "بازگشت",
                        maxLines: 1,
                        maxFontSize: 22,
                        minFontSize: 6,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87, fontSize: 12),
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
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
          SizedBox(
            height: size.height * .02,
          ),
          if (!postController.hasSearch.value) this.noSearchWidget(),
          if (postController.hasSearch.value) this.searchResult(),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Container(
      height: size.height * .05,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * .02,
                ),
                Icon(
                  Icons.access_time_outlined,
                  color: Colors.black54,
                  size: size.width * .07,
                ),
                SizedBox(
                  width: size.width * .03,
                ),
                AutoSizeText(
                  postController.listOfHistory[index],
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
          Divider(
            height: size.width * .02,
          ),
        ],
      ),
    );
  }

  Widget _searchTextField() {
    return Align(
      alignment: Alignment.center,
      child: WidgetHelper.textField(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * .015),
          child: Image.asset(
            "assets/images/search.png",
            color: Colors.black45,
          ),
        ),
        text: "دنبال چی میگردی؟",
        hintText: "جستجو ...",
        width: size.width,
        height: size.height * .08,
        color: Color(0xfff8ffff),
        size: size,
        submit: (str) {
          if (str.isNotEmpty) {
            postController.Search(q: str);
            postController.hasSearch.value = true;
            postController.listOfHistory.add(str);
          }
          if (str.isEmpty) {
            postController.hasSearch.value = false;
            postController.loadingSearch.value = false;
          }
          postController.allPostListS.clear();
          postController.postListS.clear();
          postController.tvPostListS.clear();
          postController.rPostListS.clear();
        },
        onChange: (String str) async {
          if (str.isNotEmpty) {
            postController.Search(q: str);
            postController.hasSearch.value = true;
          }
          if (str.isEmpty) {
            postController.hasSearch.value = false;
            postController.loadingSearch.value = false;
          }
          postController.allPostListS.clear();
          postController.postListS.clear();
          postController.tvPostListS.clear();
          postController.rPostListS.clear();
        },
        fontSize: 16,
        controller: searchTextEditingController,
        maxLine: 1,
        keyBoardType: TextInputType.text,
        obscureText: false,
        maxLength: 11,
        formKey: _formKey,
      ),
    );
  }

  Widget noSearchWidget() {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: size.height * .06,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "جستجو های اخیر",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                (this.isDeleted)
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          AlertHelpers.ClearDialog(
                            size: size,
                            context: context,
                            func: () {
                              setState(
                                () {
                                  this.isDeleted = true;
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.black54,
                              size: size.width * .07,
                            ),
                            AutoSizeText(
                              "حذف تاریخچه",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          if (this.isDeleted)
            Expanded(
              child: Center(
                child: Text(
                  "تاریخچه ای یافت نشد.",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: postController.listOfHistory.length,
                itemBuilder: itemBuilder,
              ),
            ),
        ],
      ),
    );
  }

  Widget searchResult() {
    if (!postController.loadingSearch.value) {
      return Expanded(
        child: LoadingDialog(),
      );
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height / 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image.asset(
                            ImageHelpers.posts,
                          ),
                          width: Get.width / 14,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "مطالب",
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            this.buildPost(
                          this.postController.postListS[index],
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: this.postController.postListS.length,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                height: Get.height / 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image.asset(
                            ImageHelpers.videos,
                          ),
                          width: Get.width / 14,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "فیلم ها",
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            this.buildMedia(
                          this.postController.tvPostListS[index],
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: postController.tvPostListS.length,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                height: Get.height / 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image.asset(
                            ImageHelpers.voices,
                          ),
                          width: Get.width / 14,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "صوت ها",
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            this.buildMedia(
                          this.postController.rPostListS[index],
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: postController.rPostListS.length,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPost(Result post) {
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
  }

  Widget buildMedia(Result post) {
    return WidgetHelper.ItemPostContainer(
      text: post.title,
      size: size,
      image: post.image,
      func: () {
        if (post.ehyaTv && !post.radioEhya) {
          Get.to(SingleTvScreen(
            post: post,
          ));
        } else if (post.radioEhya && !post.ehyaTv) {
          Get.to(SingleRadioScreen(
            post: post,
          ));
        }
      },
    );
  }
}
