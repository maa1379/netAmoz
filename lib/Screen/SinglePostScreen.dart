import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/controllers/PostController.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:ehyasalamat/models/SinglePostModel.dart';
import 'package:ehyasalamat/plugins/lib/simple_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share/share.dart';

class SinglePostScreen extends StatefulWidget {
  final Result post;

  const SinglePostScreen({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  _SinglePostScreenState createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  Size size;
  String title;

  CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    commentController.GetSinglePost(postID: widget.post.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/images/Home-AllCategories – SingleArticle – 1.png"),
            ),
          ),
          child: SingleChildScrollView(
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  delay: Duration(milliseconds: 150),
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 100.0,
                    child: FadeInAnimation(
                      curve: Curves.easeInOutCubic,
                      child: widget,
                    ),
                  ),
                  children: [
                    WidgetHelper.appBar(size: size),
                    _buildTopNavar(),
                    _buildMainItem(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTagList() {
    return Expanded(
      child: SimpleTags(
        content: widget.post.tags,
        tagTextMaxlines: 2,
        wrapSpacing: 6,
        wrapRunSpacing: 6,
        tagContainerPadding: EdgeInsets.all(6),
        tagTextStyle: TextStyle(color: Colors.black87, fontSize: 14),
        // tagIcon: Icon(Icons.clear, size: 12),
        tagContainerDecoration: BoxDecoration(
          color: Color(0xffEFEFEF),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
              // offset: Offset(1.75, 3.5), // c
            )
          ],
        ),
      ),
    );
  }

  _buildTopBanner() {
    return Container(
      height: size.height * .265,
      width: size.width,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: size.height * .25,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.post.image),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(200),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _buildIcon(),
          ),
        ],
      ),
    );
  }

  _buildTapContainer() {
    return Container(
      height: size.height * .15,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: size.width * .05),
            height: size.height * .05,
            width: size.width * .3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/tag.png",
                  width: size.width * .08,
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                AutoSizeText(
                  "برچسب ها:",
                  maxLines: 2,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildTagList(),
        ],
      ),
    );
  }

  _buildIcon() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * .03),
      margin: EdgeInsets.only(right: size.width * .05),
      height: size.height * .05,
      width: size.width * .3,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3)),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/Union 2.png",
            width: size.width * .06,
          ),
          GestureDetector(
            onTap: () {
              buildCommentListModal();
            },
            child: Image.asset(
              "assets/images/Group 128.png",
              width: size.width * .06,
            ),
          ),
          GestureDetector(
            onTap: () {
              Share.share("پست ها");
            },
            child: Icon(
              Icons.share_outlined,
              size: size.width * .065,
            ),
          ),
        ],
      ),
    );
  }

  _buildMainItem() {
    return Container(
      margin: EdgeInsets.only(top: size.height * .05),
      // height: double.maxFinite,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(200),
          bottomRight: Radius.circular(200),
        ),
      ),
      child: Column(
        children: [
          _buildTopBanner(),
          SizedBox(
            height: size.height * .03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .1),
            child: AutoSizeText(
              widget.post.title,
              maxLines: 2,
              maxFontSize: 22,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * .05),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .03, vertical: size.height * .01),
            height: size.height * .1,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Html(data: widget.post.shortDescription)),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .06),
              child: Html(data: widget.post.category)),
          SizedBox(
            height: size.height * .1,
          ),
          _buildTapContainer(),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * .05, bottom: size.height * .02),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: _buildIcon(),
            ),
          ),
        ],
      ),
    );
  }

  _buildTopNavar() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        height: size.height * .05,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: size.height * .04,
                width: size.width * .25,
                decoration: BoxDecoration(
                    color: Colors.white,
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
          ],
        ),
      ),
    );
  }

  buildCommentListModal() {
    return showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: false,
      context: Get.context,
      builder: (context) {
        return Obx(() {
          return Container(
            height: Get.height * .9,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Get.width * .03),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              size: Get.width * .1,
                              color: Color(0xff7366FF),
                            )),
                      ),
                    ),
                    AutoSizeText(
                      "نظرات",
                      maxLines: 1,
                      maxFontSize: 24,
                      minFontSize: 6,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff7366FF), fontSize: 18),
                    ),
                    Padding(
                        padding: EdgeInsets.all(Get.width * .03),
                        child: Icon(
                          Icons.comment_outlined,
                          color: Color(0xff7366FF),
                          size: Get.width * .1,
                        )),
                  ],
                ),
                _buildCommentList(),
                (commentController.isReply.value == false)
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                commentController.isReply.value = false;
                              },
                              icon: Icon(Icons.clear)),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
                            height: Get.height * .05,
                            width: Get.width * .7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black, width: 0.5)),
                            child: AutoSizeText(
                              commentController.cmReply.value,
                              maxLines: 1,
                              maxFontSize: 24,
                              minFontSize: 16,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.lightBlueAccent, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                _buildTextField()
              ],
            ),
          );
        });
      },
    );
  }

  _buildTextField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * .02, vertical: Get.height * .015),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height * .2,
            maxWidth: Get.width,
          ),
          child: TextField(
            controller: commentController.textController,
            minLines: 1,
            maxLines: null,
            textInputAction: TextInputAction.send,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              prefixIcon: GestureDetector(
                onTap: () {
                  EasyLoading.show(
                      dismissOnTap: false,
                      indicator: CircularProgressIndicator());
                  commentController.isReply.value = false;
                  commentController.postId =
                      RxString(commentController.postId.value.toString());
                  commentController.CreateComment(
                      text: commentController.textController.text,
                      parent: (commentController.cmReplyId.value == 0)
                          ? ""
                          : commentController.cmReplyId.value.toString(),
                      postId: commentController.postId.value.toString());
                },
                child: Container(
                  margin: EdgeInsets.all(Get.width * .01),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100, shape: BoxShape.circle),
                  child: Icon(Icons.send),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.lightBlue.withOpacity(.40)),
                // borderRadius: BorderRadius.circular(30),
              ),
              labelText: "",
              hintText: "متن پیام",
              // contentPadding: EdgeInsets.all(size.width * .03),
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(.40),
              ),
              counter: Offstage(),
              // errorText: errorText,
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.lightBlue.withOpacity(.40)),
                // borderRadius: const BorderRadius.all(
                //   const Radius.circular(30.0),
                // ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue.withOpacity(.40),
                ),
                // borderRadius: BorderRadius.all(
                //   Radius.circular(30),
                // ),
              ),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.lightBlue.withOpacity(.40)),
                // borderRadius: BorderRadius.all(
                //   Radius.circular(30),
                // ),
              ),
              hintStyle: TextStyle(
                  fontSize: 12, color: Colors.lightBlue.withOpacity(.20)),
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildCommentList() {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: commentController.commentList.length,
        itemBuilder: (BuildContext context, int index) {
          Comment comments = commentController.commentList[index];
          return Row(
            children: [
              IconButton(
                  onPressed: () {
                    commentController.cmReply = RxString(comments.text);
                    commentController.cmReplyId = RxInt(comments.id);
                    commentController.isReply.value = true;
                  },
                  icon: Icon(Icons.replay)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05, vertical: Get.height * .015),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: Get.height * .5,
                    minHeight: Get.height * .05,
                    maxWidth: Get.width * .65,
                    minWidth: Get.width * .65,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(Get.width * .02),
                      child: AutoSizeText(
                        comments.text,
                        maxLines: null,
                        maxFontSize: 24,
                        minFontSize: 6,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
