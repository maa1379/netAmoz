import 'package:auto_size_text/auto_size_text.dart';
import 'package:ehyasalamat/controllers/PostController.dart';
import 'package:ehyasalamat/helpers/ColorHelpers.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'SinglePostScreen.dart';

class AllPostScreen extends StatelessWidget {
  AllPostController allPostController = Get.put(AllPostController());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    allPostController.getPost();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    allPostController.page + 1;
    allPostController.getPost();
    // if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Obx(() {
          if (!allPostController.loading.value) {
            return LoadingDialog();
          }
          return Column(
            children: [
              SizedBox(
                height: Get.height * .05,
              ),
              _buildTopNavar(),
              _buildAllPostList(),
              SizedBox(
                height: Get.height * .05,
              ),
            ],
          );
        }),
      ),
    );
  }

  _buildTopNavar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
          height: Get.height * .05,
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(Get.context).pop();
                },
                child: Container(
                  height: Get.height * .04,
                  width: Get.width * .25,
                  decoration: BoxDecoration(
                      color: ColorsHelper.SplashColors,
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
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: Get.width * .05,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAllPostList() {
    return Expanded(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("بکشید");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("درحال دریافت");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("درحال دریافت");
            } else {
              body = Text("اطللاعاتی دریافت نشد");
            }
            return Container(
              alignment: Alignment.center,
              height: Get.height * .15,
              width: Get.width * .2,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        scrollDirection: Axis.vertical,
        onLoading: _onLoading,
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            Result post = allPostController.postList[index];
            return WidgetHelper.ItemPostContainer(
              text: post.title,
              size: Get.size,
              image: post.image,
              func: () {
                Get.to(() => SinglePostScreen(post: allPostController.postList[index],));
              },
            );
          },
          itemCount: allPostController.postList.length,
        ),
      ),
    );
  }
}
