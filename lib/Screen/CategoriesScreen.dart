import 'package:ehyasalamat/Screen/SinglePostScreen.dart';
import 'package:ehyasalamat/controllers/CategoriesController.dart';
import 'package:ehyasalamat/helpers/loading.dart';
import 'package:ehyasalamat/helpers/widgetHelper.dart';
import 'package:ehyasalamat/models/CategoryModel.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoriesController controller = Get.put(
    CategoriesController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: WidgetHelper.drawerWidget(
          size: Size(
            Get.width,
            Get.height,
          ),
          context: Get.context,
          itemList: controller.DrawerList,
        ),
        body: Container(
          height: Get.height,
          child: Column(
            children: [
              WidgetHelper.appBar(
                size: Size(
                  Get.width,
                  Get.height,
                ),
                innerPage: true,
                title: controller.category.name,
                context: Get.context,
              ),
              this.buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      height: Get.height - (Get.height * .08 + Get.height * .05),
      child: Column(
        children: [
          SizedBox(
            height: 24.0,
          ),
          GetBuilder(
            init: this.controller,
            builder: (_) => Container(
              height: Get.height / 18,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                itemBuilder: buildLastCat,
                scrollDirection: Axis.horizontal,
                itemCount: controller.lastCategories.length,
              ),
            ),
          ),
          GetBuilder(
            init: this.controller,
            builder: (_) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: controller.lastCategories.last.children.length > 0
                    ? buildChildrenList()
                    : buildPostsList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChildrenList() {
    return ListView.separated(
      separatorBuilder: this.separatorBuilder,
      itemBuilder: this.buildCategory,
      itemCount: controller.lastCategories.last.children.length,
    );
  }

  Widget buildPostsList() {
    return Obx(
      () => this.controller.isPostsLoaded.isTrue
          ? SmartRefresher(
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
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              scrollDirection: Axis.vertical,
              onLoading: controller.onLoading,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Result post = controller.posts[index];
                  return WidgetHelper.ItemPostContainer(
                    text: post.title,
                    size: Get.size,
                    image: post.image,
                    func: () {
                      Get.to(
                        () => SinglePostScreen(
                          post: post,
                        ),
                      );
                    },
                  );
                },
                itemCount: controller.posts.length,
              ),
            )
          : LoadingDialog(),
    );
    ;
  }

  Widget buildCategory(BuildContext context, int index) {
    CategoriesModel category = controller.lastCategories.last.children[index];
    return Material(
      elevation: 8.0,
      shadowColor: Colors.grey.withOpacity(0.3),
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () {
          this.controller.categoryOnTap(category);
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 8.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Text(
                category.name,
                style: TextStyle(
                  color: Colors.grey.shade900,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return Divider();
  }

  Widget buildLastCat(BuildContext context, int index) {
    CategoriesModel category = controller.lastCategories[index];
    return GestureDetector(
      onTap: () {
        if (controller.lastCategories.length == 1) {
          Get.back();
          return;
        }
        controller.lastCategories.removeRange(
            controller.lastCategories.indexOf(category),
            controller.lastCategories.length);
        this.controller.postModel = null;
        this.controller.posts = [];
        this.controller.currentPostPage = 1;
        if (controller.lastCategories.length == 0) {
          Get.back();
          return;
        }
        controller.update();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              spreadRadius: 3.0,
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8.0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Icon(
              Icons.close,
              color: Colors.red.shade900,
              size: 18.0,
            ),
            SizedBox(
              width: 4.0,
            ),
            Text(
              category.name,
            ),
          ],
        ),
      ),
    );
  }
}
