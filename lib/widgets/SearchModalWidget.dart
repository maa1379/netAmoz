import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/Screen/SinglePostScreen.dart';
import 'package:ehyasalamat/Screen/SingleRadioScreen.dart';
import 'package:ehyasalamat/Screen/SingleTvScreen.dart';
import 'package:ehyasalamat/helpers/AlertHelper.dart';
import 'package:ehyasalamat/helpers/ImageHelpers.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/helpers/prefHelper.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/MediaModel.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SearchModalWidget extends StatefulWidget {
  @override
  _SearchModalWidgetState createState() => _SearchModalWidgetState();
}

class _SearchModalWidgetState extends State<SearchModalWidget> {
  Size size;
  bool isDeleted = false;
  bool hasSearched = false;
  bool isLoading = false;
  int postsPage = 1;
  int videosPage = 1;
  int audiosPage = 1;
  List<PostModel> listOfPosts = [];
  List<MediaModel> listOfVideos = [];
  List<MediaModel> listOfAudio = [];

  ScrollController postsController = ScrollController();
  ScrollController videosController = ScrollController();
  ScrollController audiosController = ScrollController();
  String query = "";

  void search(String query) async {
    this.setState(() {
      this.query = query;
      this.isLoading = true;
    });

    ApiResult result =
        await RequestHelper.search(query, 'posts', '', postsPage);

    if (result.isDone) {
      this.listOfPosts = PostModel.listFromJson(jsonDecode(result.data));
    }
    result = await RequestHelper.search(query, 'media', 'video', videosPage);

    if (result.isDone) {
      this.listOfVideos = MediaModel.listFromJson(jsonDecode(result.data));
    }
    result = await RequestHelper.search(query, 'media', 'audio', audiosPage);
    this.setState(() {
      this.hasSearched = true;
      this.isLoading = false;
    });
    if (result.isDone) {
      this.listOfAudio = MediaModel.listFromJson(jsonDecode(result.data));
    }
    this.setListeners();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController searchTextEditingController = TextEditingController();

  void setListeners() async {
    this.postsController.addListener(() async {
      if (this.postsController.hasClients &&
          this.postsController.offset >=
              this.postsController.position.maxScrollExtent) {
        this.setState(() {
          this.isLoading = true;
          postsPage++;
        });
        ApiResult result =
            await RequestHelper.search(query, 'posts', '', postsPage);

        if (result.isDone) {
          this
              .listOfPosts
              .addAll(PostModel.listFromJson(jsonDecode(result.data)));
        }
        this.setState(() {
          this.isLoading = false;
          Future.delayed(Duration(milliseconds: 100), () {
            this.postsController.animateTo(
                  this.postsController.position.maxScrollExtent - 10,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
          });
        });
      }
    });
    this.videosController.addListener(() async {
      if (this.videosController.hasClients &&
          this.videosController.offset >=
              this.videosController.position.maxScrollExtent) {
        this.setState(() {
          this.isLoading = true;
          videosPage++;
        });
        ApiResult result =
            await RequestHelper.search(query, 'media', 'video', videosPage);

        if (result.isDone) {
          this
              .listOfVideos
              .addAll(MediaModel.listFromJson(jsonDecode(result.data)));
        }
        this.setState(() {
          this.isLoading = false;
          Future.delayed(Duration(milliseconds: 100), () {
            this.videosController.animateTo(
                  this.videosController.position.maxScrollExtent - 10,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
          });
        });
      }
    });
    this.audiosController.addListener(() async {
      if (this.audiosController.hasClients &&
          this.audiosController.offset >=
              this.audiosController.position.maxScrollExtent) {
        this.setState(() {
          this.isLoading = true;
          audiosPage++;
        });
        ApiResult result =
            await RequestHelper.search(query, 'media', 'audio', audiosPage);

        if (result.isDone) {
          this
              .listOfAudio
              .addAll(MediaModel.listFromJson(jsonDecode(result.data)));
        }
        this.setState(() {
          this.isLoading = false;
          Future.delayed(Duration(milliseconds: 100), () {
            this.audiosController.animateTo(
                  this.audiosController.position.maxScrollExtent - 10,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: size.height * .87,
        width: size.width,
        child: _buildAllCategoriesGridList(),
      ),
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
          if (!this.hasSearched) this.noSearchWidget(),
          if (this.hasSearched) this.searchResult(),
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
                  "راه درمان اگزما",
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
        onChange: (String str) async {
          this.search(str);
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
          if (!this.isLoading) ...[
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
                  itemCount: 10,
                  itemBuilder: itemBuilder,
                ),
              ),
          ],
          if (this.isLoading) ...[
            Expanded(
              child: LoadingDialog(),
            ),
          ]
        ],
      ),
    );
  }

  Widget searchResult() {
    if (this.isLoading) {
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
                        controller: this.postsController,
                        itemBuilder: (BuildContext context, int index) =>
                            this.buildPost(
                          this.listOfPosts[index],
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: this.listOfPosts.length,
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
                        controller: this.videosController,
                        itemBuilder: (BuildContext context, int index) =>
                            this.buildMedia(
                          this.listOfVideos[index],
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: this.listOfVideos.length,
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
                        controller: this.audiosController,
                        itemBuilder: (BuildContext context, int index) =>
                            this.buildMedia(
                          this.listOfAudio[index],
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: this.listOfAudio.length,
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

  Widget buildPost(PostModel post) {
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
  }

  Widget buildMedia(MediaModel post) {
    return WidgetHelper.ItemPostContainer(
      text: post.title.rendered,
      size: size,
      image: post.mimeType.startsWith('video')
          ? "assets/images/thumbnail.png"
          : "assets/images/audio-thumbnail.png",
      func: () {
        if (post.mimeType.startsWith('video')) {
          Get.to(SingleTvScreen(
            post: post,
          ));
        } else if (post.mimeType.startsWith('audio')) {
          Get.to(SingleRadioScreen(
            post: post,
          ));
        }
      },
    );
  }
}
