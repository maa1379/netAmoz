import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/controllers/SupportController.dart';
import 'package:ehyasalamat/models/GetSupportTicketList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/GetDetailTicketModel.dart';

class SupportChatScreen extends StatefulWidget {
  @override
  _SupportChatScreenState createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  Size size;
  SupportTicketDetailController ticketController = Get.put(SupportTicketDetailController());
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
              _buildChatBody(),
              _buildTextField(),
            ],
          ),
        ),
      ),
    );
  }

  _buildChatBody() {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          itemCount: ticketController.TicketList.length,
          itemBuilder: itemBuilder),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = ticketController.TicketList[index];
    return (item.user == "کاربر")
        ? Column(
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
                item.text,
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
                  AutoSizeText(
                    item.createdAt,
                    maxLines: null,
                    maxFontSize: 18,
                    minFontSize: 10,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black38, fontSize: 10),
                  ),
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
        : Column(
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
                item.text,
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
                  AutoSizeText(
                    item.createdAt,
                    maxLines: null,
                    maxFontSize: 18,
                    minFontSize: 10,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black38, fontSize: 10),
                  ),
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
    );
  }

  _buildTextField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .02),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size.height * .2,
            maxWidth: size.width,
          ),
          child: TextField(
            controller: ticketController.textController,
            minLines: 1,
            maxLines: null,
            textInputAction: TextInputAction.send,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              prefixIcon: GestureDetector(
                onTap: () {
                  if (ticketController.textController.isBlank ||
                      ticketController.textController.text == "") {
                    Container();
                  } else {
                    ticketController.createAnswer(ticketController.textController.text);
                    ticketController.TicketList.add(AnswerListSupport(
                        text: ticketController.textController.text,
                        createdAt: DateTime.now().toString(),
                        user: "کاربر"));
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 375),
                      curve: Curves.linear,
                    );
                    FocusScope.of(context).unfocus();
                    ticketController.textController.clear();
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(size.width * .01),
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
}
