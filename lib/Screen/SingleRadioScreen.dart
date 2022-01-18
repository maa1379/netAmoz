import 'package:auto_size_text/auto_size_text.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/MediaModel.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:simple_tags/simple_tags.dart';
import 'package:video_player/video_player.dart';

class SingleRadioScreen extends StatefulWidget {
  final MediaModel post;

  const SingleRadioScreen({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  _SingleRadioScreenState createState() => _SingleRadioScreenState();
}

class _SingleRadioScreenState extends State<SingleRadioScreen> {
  Size size;
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieAudioController _chewieAudioController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieAudioController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(widget.post.sourceUrl);
    _videoPlayerController2 =
        VideoPlayerController.network(widget.post.sourceUrl);
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      autoInitialize: true,
    );
    setState(() {});
  }

  String title;
  final List<String> content = [
    'دکتر روازاده',
    'جوابیه',
    'سازمان نظام پزشکی',
    'طب اسلامی ایرانی',
    'سازمان نظام پزشکی',
    'جوابیه',
    'سازمان نظام پزشکی',
    'طب اسلامی ایرانی',
  ];

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
        content: content,
        tagTextMaxlines: 1,
        wrapSpacing: 6,
        wrapRunSpacing: 6,
        tagContainerPadding: EdgeInsets.all(6),
        tagTextStyle: TextStyle(color: Colors.black87, fontSize: 10),
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
            height: size.height * .2,
            width: size.width,
            margin: EdgeInsets.only(top: size.height * .05 , left: size.width * .05 , right: size.width * .05),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Center(
                  child: _chewieAudioController != null &&
                          _chewieAudioController
                              .videoPlayerController.value.isInitialized
                      ? ChewieAudio(
                          controller: _chewieAudioController,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Loading'),
                          ],
                        ),
                ),
              ],
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
          Image.asset(
            "assets/images/Group 128.png",
            width: size.width * .06,
          ),
          Icon(
            Icons.share_outlined,
            size: size.width * .065,
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
              widget.post.title.rendered,
              maxLines: 2,
              maxFontSize: 22,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
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
}
