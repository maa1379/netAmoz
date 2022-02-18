import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/controllers/TreasureController.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TreasureSingleScreen extends StatefulWidget {
  @override
  _TreasureSingleScreenState createState() => _TreasureSingleScreenState();
}

class _TreasureSingleScreenState extends State<TreasureSingleScreen> {
  Size size;
  DetailTreasureController ticketController =
      Get.put(DetailTreasureController());
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage("assets/images/chatback.png"),
              fit: BoxFit.cover,
            )),
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * .05, right: size.width * .05),
                    child: WidgetHelper.PopNavigator(
                        size: size, context: context, text: "مشاوره"),
                  ),
                ),
              ),
              itemBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBuilder() {
    if(ticketController.loading.value == false){
      return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * .35),
            child: LoadingDialog(),
          ));
    }
    return Expanded(
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05, vertical: size.height * .02),
                decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ]),
                margin: EdgeInsets.only(
                    left: size.width * .3,
                    right: size.width * .05,
                    bottom: size.height * .02),
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  minHeight: size.height * .06,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      ticketController.TicketList.topic,
                      maxLines: null,
                      maxFontSize: 28,
                      minFontSize: 10,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.check,
                          size: size.width * .035,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05, vertical: size.height * .02),
                decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ]),
                margin: EdgeInsets.only(
                    left: size.width * .3,
                    right: size.width * .05,
                    bottom: size.height * .02),
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  minHeight: size.height * .06,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      ticketController.TicketList.link,
                      maxLines: null,
                      maxFontSize: 28,
                      minFontSize: 10,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.check,
                          size: size.width * .035,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05, vertical: size.height * .02),
                decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ]),
                margin: EdgeInsets.only(
                    left: size.width * .3,
                    right: size.width * .05,
                    bottom: size.height * .02),
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  minHeight: size.height * .06,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network("http://87.107.172.122" +
                        ticketController.TicketList.file),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.check,
                          size: size.width * .035,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05, vertical: size.height * .02),
                decoration: BoxDecoration(
                    color: Colors.lightBlue.shade200,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ]),
                margin: EdgeInsets.only(
                    left: size.width * .05,
                    right: size.width * .3,
                    bottom: size.height * .02),
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  minHeight: size.height * .06,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      ticketController.TicketList.answer,
                      maxLines: null,
                      maxFontSize: 28,
                      minFontSize: 10,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.check,
                          size: size.width * .035,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
