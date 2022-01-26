import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:simple_tags/simple_tags.dart';

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
            height: size.height * .25,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.post.title),
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
            padding: EdgeInsets.symmetric(horizontal: size.width * .03,vertical: size.height *.01),
            height: size.height * .1,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Html(data: widget.post.shortDescription)
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .06),
            child: Html(data: widget.post.category)
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
