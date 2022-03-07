import 'package:auto_size_text/auto_size_text.dart';
import 'package:chewie/chewie.dart';
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
import 'package:video_player/video_player.dart';

class SingleTvScreen extends StatefulWidget {
  final Result post;
  const SingleTvScreen({
    Key key,
    this.post,
  }) : super(key: key);
  @override
  _SingleTvScreenState createState() => _SingleTvScreenState();
}

class _SingleTvScreenState extends State<SingleTvScreen> {
  Size size;


  String title;

  CommentController commentController = Get.put(CommentController());





  ChewieController _chewieController;
  VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();

    if (widget.post?.id == null) {
      print("cm null");
    } else {
      commentController.GetSinglePost(postID: widget.post?.id?.toString());
    }

    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(widget.post.linkTv) ,
      aspectRatio: 15 / 8,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: true,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    videoPlayerController.dispose();
    _chewieController.dispose();
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
        tagTextMaxlines: 1,
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
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),

          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: _buildIcon(),
          // ),
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
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                commentController.likePost(post_id: widget.post?.id?.toString());
              },
              child: Image.asset(
                "assets/images/Union 2.png",
                width: size.width * .06,
                color:
                commentController.isLike.isTrue ? Colors.red : Colors.black,
              ),
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
                Share.share(
                    widget.post.title + "\n" + widget.post.shortDescription + "\n" + widget.post.shareLink);
              },
              child: Icon(
                Icons.share_outlined,
                size: size.width * .065,
              ),
            ),
          ],
        );
      }),
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
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: AutoSizeText(
                widget.post.title,
                maxLines: 2,
                maxFontSize: 22,
                minFontSize: 10,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * .025),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .03, vertical: size.height * .01),
            height: size.height * .1,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text(widget.post.shortDescription,overflow: TextOverflow.ellipsis)),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: Html(data: widget.post.shortDescription)),
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
                              this.commentController.isReply.value = false;
                              Get.close(1);
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
                      style: TextStyle(
                        color: Color(
                          0xff7366FF,
                        ),
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Get.width * .03),
                      child: Icon(
                        Icons.comment_outlined,
                        color: Color(0xff7366FF),
                        size: Get.width * .1,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildCommentList(
                      this.commentController.commentList.value,
                    ),
                  ),
                ),
                (commentController.isReply.value == false)
                    ? Container()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        commentController.textController.clear();
                        ;
                        commentController.isReply.value = false;
                      },
                      icon: Icon(Icons.clear),
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
                      height: Get.height * .05,
                      width: Get.width * .7,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      child: AutoSizeText(
                        commentController.replyComment is Comment
                            ? commentController.replyComment.text
                            : '',
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
                onTap: () async {
                  EasyLoading.show(
                    dismissOnTap: true,
                    indicator: CircularProgressIndicator(),
                  );
                  commentController.isReply.value = false;
                  await commentController.CreateComment();
                  commentController.commentList.clear();
                  await commentController.GetSinglePost(
                    postID: commentController.singlePost.id.toString(),
                  );
                  this.commentController.textController.clear();
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

  _buildCommentList(List<Comment> list) {
    return Column(
      children: list
          .map(
            (e) => this.buildComment(e, list),
      )
          .toList(),
    );
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        Comment comment = list[index];
        return this.buildComment(comment, list);
      },
    );
  }

  Widget buildComment(Comment comment, List<Comment> list) {
    return Column(
      children: [
        AnimationConfiguration.staggeredList(
          position: list.indexOf(comment),
          duration: Duration(milliseconds: 100),
          child: FadeInAnimation(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              height: Get.height / 10,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      commentController.isReply.value = false;

                      commentController.replyComment = comment;
                      this.setState(() {});
                      this.commentController.refresh();
                      commentController.isReply.value = true;
                    },
                    child: Container(
                      child: Icon(
                        Icons.replay,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  if (comment.children.length > 0) ...[
                    SizedBox(
                      width: 8.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        comment.showComments.value =
                        !comment.showComments.value;
                      },
                      child: Container(
                        child: Icon(
                          Icons.comment_outlined,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Get.width * .02),
                        child: AutoSizeText(
                          comment.text,
                          maxLines: null,
                          maxFontSize: 24,
                          minFontSize: 6,
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3.0,
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
              () => AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            duration: Duration(milliseconds: 100),
            child: comment.showComments.isTrue
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: this._buildCommentList(comment.children),
            )
                : Material(
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }


}
