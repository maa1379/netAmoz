import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/models/CategoryModel.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxList<Result> allPostList = <Result>[].obs;
  RxList<Result> postList = <Result>[].obs;
  RxList<Result> rPostList = <Result>[].obs;
  RxList<Result> tvPostList = <Result>[].obs;
  RxBool loading = false.obs;

  ScrollController postController = ScrollController();

  getPost() async {
    RequestHelper.posts(id: "all", token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone) {
        for (var i in value.data['results']) {
          allPostList.add(Result.fromJson(i));
        }

        allPostList.forEach((element) {
          if (!element.ehyaTv && !element.radioEhya && element.published) {
            postList.add(element);
          } else if (element.radioEhya &&
              !element.ehyaTv &&
              element.published) {
            rPostList.add(element);
          } else if (!element.radioEhya &&
              element.ehyaTv &&
              element.published) {
            tvPostList.add(element);
          } else if (element.ehyaTv && element.radioEhya && element.published) {
            tvPostList.add(element);
            rPostList.add(element);
          }
        });


        loading.value = true;
      } else {
        loading.value = false;
      }
    });
  }

  @override
  void onInit() {
    getPost();
    super.onInit();
  }
}

class CategoryController extends GetxController {
  RxList<CategoriesModel> categoriesList = <CategoriesModel>[].obs;
  RxBool loading = false.obs;

  getAllCategories() async {
    RequestHelper.getAllCategories(token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone) {
        for (var i in value.data) {
          categoriesList.add(CategoriesModel.fromJson(i));
        }
        loading.value = true;
      } else {
        loading.value = false;
      }
    });
  }

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }
}
