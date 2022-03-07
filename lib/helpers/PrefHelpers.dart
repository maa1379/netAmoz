import 'Prefs.dart';

class PrefHelpers {
  static Future<void> setToken(String token) async {
    await Prefs.set('token', token);
  }

  static Future<String> getToken() async {
    return await Prefs.get('token');
  }

  static void removeToken() async {
    return await Prefs.clear('token');
  }

  static Future<void> setSearchHistory(String history) async {
    await Prefs.set('history', history);
  }

  static Future<String> getSearchHistory() async {
    return await Prefs.get('history');
  }

  static Future<void> setList(List<String> list) async {
    await Prefs.setList(list, 'list');
  }

  static Future<List<String>> getList() async {
    return await Prefs.getList('list');
  }

  static void removeList() async {
    return await Prefs.clearList('list');
  }
}
