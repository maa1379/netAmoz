import 'dart:developer';

import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:ehyasalamat/models/CategoryModel.dart';
import 'package:ehyasalamat/models/PostModel.dart';
import 'package:ehyasalamat/models/SinglePostModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxList<Result> allPostList = <Result>[].obs;
  RxList<Result> postList = <Result>[].obs;
  RxList<Result> rPostList = <Result>[].obs;
  RxList<Result> tvPostList = <Result>[].obs;
  RxList<Result> tvSpecialPostList = <Result>[].obs;
  RxList<Result> rSpecialPostList = <Result>[].obs;
  RxList<Result> specialPostList = <Result>[].obs;
  RxList<String> listOfHistory = <String>[].obs;
  RxBool loading = false.obs;
  RxBool loadingSearch = false.obs;
  RxBool hasSearch = false.obs;
  RxInt tvPage = 1.obs;
  RxInt radioPage = 1.obs;

  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  getNot() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String token = await messaging.getToken();
      log(token ?? '');
    } catch (e) {}
    log('firebase start');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      getPost();
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        getPost();
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                onlyAlertOnce: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   RemoteNotification notification = message.notification;
    //   log('new message');
    //   print(message.notification.title);
    //   print(message.notification.body);
    //   if (message is RemoteMessage) {
    //     Get.snackbar(
    //       message.notification?.title ?? '',
    //       message.notification?.body ?? '',
    //       backgroundColor: Colors.white.withOpacity(0.9),
    //     );
    //   }
    // });
  }

  ScrollController postController = ScrollController();

  getPost() async {
    RequestHelper.posts(
            id: "all", token: await PrefHelpers.getToken(), page: 1.obs)
        .then((value) {
      if (value.isDone) {
        allPostList.clear();
        postList.clear();
        rPostList.clear();
        tvPostList.clear();
        tvSpecialPostList.clear();
        rSpecialPostList.clear();
        specialPostList.clear();
        for (var i in value.data['results']) {
          allPostList.add(Result.fromJson(i));
        }

        allPostList.map((element) {
          if (!element.ehyaTv &&
              !element.radioEhya &&
              element.published &&
              !element.specialPost) {
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
        }).toList();

        allPostList.map((element) {
          if (element.ehyaTv &&
              !element.radioEhya &&
              element.published &&
              element.specialPost) {
            tvSpecialPostList.add(element);
          } else if (!element.ehyaTv &&
              element.radioEhya &&
              element.published &&
              element.specialPost) {
            rSpecialPostList.add(element);
          } else if (element.ehyaTv &&
              element.radioEhya &&
              element.published &&
              element.specialPost) {
            rSpecialPostList.add(element);
            tvSpecialPostList.add(element);
          } else if (!element.ehyaTv &&
              !element.radioEhya &&
              element.published &&
              element.specialPost) {
            specialPostList.add(element);
          }
        }).toList();

        print("****************************");
        print(rSpecialPostList.length);
        print(tvSpecialPostList.length);
        print(specialPostList.length);
        print("****************************");

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

  get() async {
    print("**************");
    print(await PrefHelpers.getList());
    print("**************");
  }

  getTVPost() async {
    RequestHelper.posts(
            id: "all", page: tvPage, token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone) {
        for (var i in value.data['results']) {
          allPostList.add(Result.fromJson(i));
        }

        allPostList.forEach((element) {
          if (!element.radioEhya && element.ehyaTv && element.published ||
              element.radioEhya && element.ehyaTv && element.published) {
            tvPostList.add(element);
          }
        });
      }
    });
  }

  getRadioPost() async {
    RequestHelper.posts(
            id: "all", page: radioPage, token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone) {
        for (var i in value.data['results']) {
          allPostList.add(Result.fromJson(i));
        }

        allPostList.forEach((element) {
          if (element.radioEhya && !element.ehyaTv && element.published ||
              element.radioEhya && element.ehyaTv && element.published) {
            rPostList.add(element);
          }
        });
      }
    });
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
    getNot();
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

class CommentController extends GetxController {
  RxBool isSend = false.obs;
  RxBool isReply = false.obs;
  RxList<Comment> commentList = <Comment>[].obs;
  TextEditingController textController = TextEditingController();

  Comment replyComment;

  CreateComment() async {
    RequestHelper.createComment(
      token: await PrefHelpers.getToken(),
      text: this.textController.text,
      parent:
          this.replyComment is Comment ? this.replyComment.id.toString() : "",
      postId: singlePost.id.toString(),
    ).then(
      (value) {
        if (value.isDone) {
          EasyLoading.dismiss();

          this.isSend.value = true;
        } else {
          this.isSend.value = false;
        }
      },
    );
  }

  SinglePostModel singlePost;

  GetSinglePost({String postID}) async {
    RequestHelper.GetSinglePost(token: await PrefHelpers.getToken(), id: postID)
        .then((value) {
      if (value.isDone) {
        singlePost = SinglePostModel.fromJson(value.data);

        commentList.addAll(singlePost.comments);
      } else {
        print("no");
      }
    });
  }
}

class AllPostController extends GetxController {
  RxList<Result> allPostList = <Result>[].obs;
  RxList<Result> postList = <Result>[].obs;
  RxBool loading = false.obs;
  RxInt page = 1.obs;

  getPost() async {
    RequestHelper.posts(
            id: "all", page: page, token: await PrefHelpers.getToken())
        .then((value) {
      if (value.isDone && value.statusCode != 404) {
        for (var i in value.data['results']) {
          allPostList.add(Result.fromJson(i));
        }

        allPostList.forEach((element) {
          if (!element.ehyaTv && !element.radioEhya && element.published) {
            postList.add(element);
          }
        });
        loading.value = true;
      } else if (value.statusCode == 404) {
        page.value = 1;
        ViewHelper.showErrorDialog(Get.context, "پستی یافت نشد");
        // loading.value = false;
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
