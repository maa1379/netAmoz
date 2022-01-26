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
  RxList<String> listOfHistory = <String>[].obs;
  RxBool loading = false.obs;
  RxBool loadingSearch = false.obs;
  RxBool hasSearch = false.obs;

  ScrollController postController = ScrollController();

  getPost() async {
    RequestHelper.posts(id: "all", token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone){
        allPostList.clear();
        postList.clear();
        rPostList.clear();
        tvPostList.clear();
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

  RxList<Result> allPostListS = <Result>[].obs;
  RxList<Result> postListS = <Result>[].obs;
  RxList<Result> rPostListS = <Result>[].obs;
  RxList<Result> tvPostListS = <Result>[].obs;

  Search({String q}) async {
    RequestHelper.search(token: await PrefHelpers.getToken(), q: q)
        .then((value) {
      if (value.isDone) {
        allPostListS.clear();
        postListS.clear();
        rPostListS.clear();
        tvPostListS.clear();
        for (var i in value.data) {
          allPostListS.add(Result.fromJson(i));
        }

        allPostListS.forEach((element) {
          if (!element.ehyaTv && !element.radioEhya && element.published) {
            postListS.add(element);
          } else if (element.radioEhya &&
              !element.ehyaTv &&
              element.published) {
            rPostListS.add(element);
          } else if (!element.radioEhya &&
              element.ehyaTv &&
              element.published) {
            tvPostListS.add(element);
          } else if (element.ehyaTv && element.radioEhya && element.published) {
            tvPostListS.add(element);
            rPostListS.add(element);
          }
        });
        hasSearch.value = true;
        loadingSearch.value = true;
        get();
      } else {
        loadingSearch.value = false;
      }
    });
  }


  get()async{
    print("**************");
    print(await PrefHelpers.getList());
    print("**************");
  }

  //
  // @override
  // void dispose() {
  //   allPostListS.clear();
  //   postListS.clear();
  //   tvPostListS.clear();
  //   rPostListS.clear();
  //   loadingSearch.value = false;
  //   super.dispose();
  // }

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
