import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'Prefs.dart';

class PrefHelpers {

  static Future<void> setToken(String token) async {
    await Prefs.set('token', token);
  }

  static Future<String> getToken() async {
    return await Prefs.get('token');
  }

  static void removeToken()async{
    return await Prefs.clear('token');
  }

  static Future<void> setSearchHistory(String history) async {
    await Prefs.set('history', history);
  }

  static Future<String> getSearchHistory() async {
    return await Prefs.get('history');
  }


// static Future<bool> logOut() async {
  //   await Prefs.set('mobile', null);
  //   await Prefs.set('transmissionId', null);
  //   await Prefs.set('transmission', null);
  //   await Prefs.set('mainData', null);
  //   await Prefs.set('income', null);
  //   return await Prefs.set('token', null);
  // }


  // static Future<List<TransmissionModel>> getTransmission() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var s =  prefs.getString('transmission');
  //   List<TransmissionModel> l = jsonDecode(s);
  //   // for(var i in jsonDecode(s))
  //   // {
  //   //   l.add(TransmissionModel.fromJson(i));
  //   // }
  //   return l;
  // }

}
