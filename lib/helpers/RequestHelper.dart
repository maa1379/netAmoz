import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum WebControllers {
  Customers,
  auth,
  ticket,
  support,
  home,
  fcm,
}
enum WebMethods {
  init,
  register_login,
  verify_code,
  user_profile,
  create_ticket,
  sections,
  get_tickets,
  get_ticket,
  create_answer,
  create_support_ticket,
  support_section,
  get_support_tickets,
  retreive_support_ticket,
  create_support_answer,
  referral,
  category_list,
  create_comment,
  devices,
}

class RequestHelper {
  static const String BaseUrl = 'http://87.107.172.122/api';
  static const String ImageUrl = 'http://87.107.172.122/api';

  static String imgUrl([String path = 'ProductGroups']) =>
      'https://new.negamarket.ir/admin/src/images/$path/';
  static const String ImageUrlForProducts =
      'https://new.negamarket.ir/admin/src/images/Products/';

  // static const String token = "";

  static Future<ApiResult> _makeRequestGet({
    WebControllers webController,
    WebMethods webMethod,
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath(webController, webMethod);
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response = await http.get(Uri.parse(url), headers: header);
    ApiResult apiResult = new ApiResult();
    apiResult.statusCode = response.statusCode;
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        Map data2 = jsonDecode(response.body);
        apiResult.data2 = data2;
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> _makeRequestPost({
    WebControllers webController,
    WebMethods webMethod,
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath(webController, webMethod);
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response =
        await http.post(Uri.parse(url), headers: header, body: body);
    ApiResult apiResult = new ApiResult();
    apiResult.statusCode = response.statusCode;
    print(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 201) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> _makeRequestPatch({
    WebControllers webController,
    WebMethods webMethod,
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath(webController, webMethod);
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response =
        await http.patch(Uri.parse(url), headers: header, body: body);
    ApiResult apiResult = new ApiResult();
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static String _makePath(WebControllers webController, WebMethods webMethod) {
    return "${RequestHelper.BaseUrl}/${webController.toString().split('.').last}/${'${webMethod.toString().split('.').last}'}";
  }

  static Future<ApiResult> LoginRegister({String mobile}) async {
    return await RequestHelper._makeRequestPost(
      webController: WebControllers.auth,
      webMethod: WebMethods.register_login,
      body: {'phone_number': mobile},
    ).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> LoginOtp({String mobile, String code}) async {
    return await RequestHelper._makeRequestPost(
      webController: WebControllers.auth,
      webMethod: WebMethods.verify_code,
      body: {'phone_number': mobile, 'code': code},
    ).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getDetailTicket({String id, String token}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.ticket,
        webMethod: WebMethods.get_ticket,
        header: {
          'ticket': id,
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getAllCategories({String token}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.home,
        webMethod: WebMethods.category_list,
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getSection() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.ticket,
      webMethod: WebMethods.sections,
    ).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getTickets({String token, String filter}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.ticket,
        webMethod: WebMethods.get_tickets,
        header: {
          "filter": filter,
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getProfile({String token}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.auth,
        webMethod: WebMethods.user_profile,
        body: {},
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> sendTicket(
      {String topic,
      String section,
      String request_text,
      var file,
      String section_id,
      String token}) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.ticket,
        webMethod: WebMethods.create_ticket,
        body: {
          "topic": topic,
          "section": section,
          "section_id": section_id,
          "request_text": request_text,
          "base_64_file": file,
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> sendAnswer(
      {String ticket_id, String text, String token}) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.ticket,
        webMethod: WebMethods.create_answer,
        body: {
          "ticket": ticket_id,
          "text": text,
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> sendSupportAnswer(
      {String ticket_id, String text, String token}) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.support,
        webMethod: WebMethods.create_support_answer,
        body: {
          "ticket": ticket_id,
          "text": text,
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> sendSupportTicket(
      {String topic, String text, String section_id, String token}) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.support,
        webMethod: WebMethods.create_support_ticket,
        body: {
          "topic": topic,
          "request_text": text,
          "section": section_id,
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getSupportSection() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.support,
      webMethod: WebMethods.support_section,
    ).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> referral({String token, String phoneNumber}) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.auth,
        webMethod: WebMethods.referral,
        body: {
          "phone_number": phoneNumber
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> registrationId({String token, String registration_id}) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.fcm,
        webMethod: WebMethods.devices,
        body: {
          "registration_id": registration_id,
          "type": "android",
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> createComment({
    String token,
    String postId,
    String text,
    String parent,
  }) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.home,
        webMethod: WebMethods.create_comment,
        body: {
          "related_post": postId,
          "text": text,
          "parent": parent,
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getSupportTicketList({String token}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.support,
        webMethod: WebMethods.get_support_tickets,
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getSupportTicketChat(
      {String token, String ticket_id}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.support,
        webMethod: WebMethods.retreive_support_ticket,
        header: {
          "id": ticket_id,
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

  static Future<ApiResult> updateProfile({
    String first_name,
    String last_name,
    String province,
    String city,
    String birthday,
    String gender,
    String degree,
    String field_of_study,
    String job,
    String token,
  }) async {
    return await RequestHelper._makeRequestPatch(
        webController: WebControllers.auth,
        webMethod: WebMethods.user_profile,
        body: {
          "first_name": first_name,
          "last_name": last_name,
          "province": province,
          "city": city,
          "birthday": birthday,
          "gender": gender,
          "degree": degree,
          "field_of_study": field_of_study,
          "job": job,
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token}"
        }).timeout(
      Duration(seconds: 50),
    );
  }

//  **************************************************************************
//  **************************************************************************
//  **************************************************************************

  static Future<ApiResult> posts({
    String id = "",
    String token,
    RxInt page,
  }) async {
    String url = "http://87.107.172.122/api/home/posts_list/$id?page=${page.value.toString() == null ?1:page.value.toString() }";
    print(url);
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    });
    ApiResult apiResult = new ApiResult();
    apiResult.statusCode = response.statusCode;
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = 'search';
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = true;
    }
    print("\nRequest url: $url\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> GetSinglePost({
    String id = "",
    String token,
  }) async {
    String url = "http://87.107.172.122/api/home/single_post/$id";
    print(url);
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    });
    ApiResult apiResult = new ApiResult();
    apiResult.statusCode = response.statusCode;
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = 'search';
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = true;
    }
    print("\nRequest url: $url\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> search({
    String token,
    String q,
  }) async {
    String url = "http://87.107.172.122/api/home/posts_search?q=$q";
    print(url);
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    });
    ApiResult apiResult = new ApiResult();
    apiResult.statusCode = response.statusCode;
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = 'search';
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = true;
    }
    print("\nRequest url: $url\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> informs({String role, String token}) async {
    String url = "http://87.107.172.122/api/informs/informs/$role";
    print(url);
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    });
    ApiResult apiResult = new ApiResult();
    apiResult.statusCode = response.statusCode;
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
    }
    print("\nRequest url: $url\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }
}

class ApiResult {
  bool isDone;
  String requestedMethod;
  dynamic data;
  dynamic data2;
  var statusCode;

  ApiResult({
    this.isDone,
    this.requestedMethod,
    this.data,
    this.data2,
    this.statusCode,
  });
}
