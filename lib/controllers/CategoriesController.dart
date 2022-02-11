import 'package:ehyasalamat/Screen/AboutUsScreen.dart';
import 'package:ehyasalamat/Screen/ContactUsScreen.dart';
import 'package:ehyasalamat/Screen/EditProfileScreen.dart';
import 'package:ehyasalamat/Screen/IncreasePointsScreen.dart';
import 'package:ehyasalamat/Screen/InviteFriendScreen.dart';
import 'package:ehyasalamat/Screen/SupportScreen.dart';
import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/models/CategoryModel.dart';
import 'package:ehyasalamat/models/DrawerModel.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoriesController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<CategoriesModel> lastCategories = [];
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  void onRefresh() async {
    await this.getPosts();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    if (this.postModel.next != null) {
      this.currentPostPage += 1;
      await this.getPosts();
      // if (mounted) setState(() {});
    }
    refreshController.loadComplete();
  }

  final List<DrawerModel> DrawerList = [
    DrawerModel(
      id: 1,
      title: "پروفایل من",
      icon: "assets/images/1.png",
      func: EditProfileScreen(),
    ),
    DrawerModel(
      id: 2,
      title: "افزایش امتیاز",
      icon: "assets/images/2.png",
      func: IncreasePointsScreen(),
    ),
    DrawerModel(
      id: 3,
      title: "پشتیبانی",
      icon: "assets/images/3.png",
      func: SupportScreen(),
    ),
    DrawerModel(
      id: 4,
      title: "آموزش کار با اپلیکیشن",
      icon: "assets/images/4.png",
    ),
    DrawerModel(
      id: 5,
      title: "بیوگرافی حکیم دکتر روازاده",
      icon: "assets/images/5.png",
    ),
    DrawerModel(
      id: 6,
      title: "دعوت از دوستان",
      icon: "assets/images/6.png",
      func: InviteFriendScreen(),
    ),
    DrawerModel(
      id: 7,
      title: "درباره ما",
      icon: "assets/images/7.png",
      func: AboutUsScreen(),
    ),
    DrawerModel(
      id: 8,
      title: "تماس با ما",
      icon: "assets/images/8.png",
      func: ContactUsScreen(),
    ),
  ];

  RxBool isPostsLoaded = false.obs;

  CategoriesModel category;

  RxInt currentPostPage = 1.obs;

  List<Result> posts = [];
  List<Result> post = [];
  PostModel postModel;

  @override
  void onInit() {
    this.isPostsLoaded.value = false;
    category = Get.arguments[0];
    this.lastCategories.add(category);
    if (category.children.length == 0) {
      this.getPosts();
    }
    super.onInit();
  }

  void getPosts() async {
    this.isPostsLoaded.value = false;

    ApiResult result = await RequestHelper.posts(
      id: lastCategories.last.id.toString(),
      token: await PrefHelpers.getToken(),
      page: this.currentPostPage,
    );
    if (result.isDone) {
      this.postModel = PostModel.fromJson(result.data);
      this.post.addAll(
            this.postModel.results,
          );
      post.forEach((element) {
        if (!element.ehyaTv && !element.radioEhya && element.published) {
          posts.add(element);
        }
      });

      this.isPostsLoaded.value = true;
    }
  }

  void categoryOnTap(CategoriesModel category) async {
    lastCategories.add(category);
    if (category.children.length == 0) {
      this.getPosts();
    }
    update();
  }
}
