import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:ehyasalamat/Screen/LoginScreen.dart';
import 'package:ehyasalamat/helpers/ColorHelpers.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  LiquidController liquidController ;
  bool revers = false;
  Size size;
  int _selectedIndex = 0;
  List page = [
    Image.asset("assets/images/iPhone 12 Pro Max – 1.png",fit: BoxFit.cover,),
    Image.asset("assets/images/iPhone 12 Pro Max – 2.png",fit: BoxFit.cover,),
    Image.asset("assets/images/iPhone 12 Pro Max – 3.png",fit: BoxFit.cover,),
    Image.asset("assets/images/iPhone 12 Pro Max – 4.png",fit: BoxFit.cover,),
    Image.asset("assets/images/iPhone 12 Pro Max – 5.png",fit: BoxFit.cover,),
  ];


  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  PageController pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                child: LiquidSwipe.builder(
                  liquidController: liquidController,
                  initialPage: _selectedIndex,
                  onPageChangeCallback: (page){
                    if(page == 5){
                      setState(() {
                        revers = true;
                      });
                    }
                    setState(() {
                      _selectedIndex = page;
                    });
                  },
                 disableUserGesture: revers,
                  itemCount: page.length,
                  itemBuilder: (BuildContext context , int index){
                    return Container(
                      height: size.height,
                      width: size.width,
                      child: page[index],
                    );
                  },

                ),
              ),
              _buildIndicator(),
              (_selectedIndex != 4)? _buildSkipButton():Container(),
              (_selectedIndex == 4)? _buildNextButton():Container(),
            ],
          ),
        ),
      ),
    );
  }

  _buildIndicator(){
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * .06),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedSmoothIndicator(
          activeIndex: _selectedIndex,
          onDotClicked: (value) {
            setState(() {
              _selectedIndex = value;
            });
            liquidController.jumpToPage(page: _selectedIndex);
          },
          count: page.length,
          effect: ExpandingDotsEffect(
            activeDotColor: Colors.white,
            dotColor: Colors.white30,
              dotWidth: size.width * .016, dotHeight: size.height * .008),
        ),
      ),
    );
  }

  _buildSkipButton(){
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * .055 , left: size.width * .08),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                child: LoginScreen(),
              ),
            );
          },
          child: AutoSizeText(
            "رد کردن",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }


  _buildNextButton(){
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.topToBottom,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            child: LoginScreen(),
          ),
        );
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.only(bottom: size.height * .04),
          height: size.height * .05,
          width: size.width * .25,
          decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50) , bottomLeft: Radius.circular(50))
          ),
          child: Center(
            child: AutoSizeText(
              "ورود",
              maxLines: 1,
              maxFontSize: 22,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff7366FF), fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }


  // Stack(
  // children: [
  // Container(
  // height: size.height,
  // width: size.width,
  // child: PageView(
  // controller: pageViewController,
  // onPageChanged: (page) {
  // setState(() {
  // _selectedIndex = page;
  // });
  // },
  // children: [
  // Image.asset("assets/images/iPhone 12 Pro Max – 1.png",fit: BoxFit.cover,),
  // Expanded(
  // child: Stack(
  // children: [
  // Image.asset("assets/images/iPhone 12 Pro Max – 2.png",fit: BoxFit.cover,),
  // Center(child: Lottie.asset("assets/anim/question.json" , width: size.width * .6))
  // ],
  // ),
  // ),
  // Image.asset("assets/images/iPhone 12 Pro Max – 3.png",fit: BoxFit.cover,),
  // Image.asset("assets/images/iPhone 12 Pro Max – 4.png",fit: BoxFit.cover,),
  // Image.asset("assets/images/iPhone 12 Pro Max – 5.png",fit: BoxFit.cover,),
  // ],
  // ),
  // ),
  // _buildIndicator(),
  // ],
  // ),
}
