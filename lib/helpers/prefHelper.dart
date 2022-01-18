import 'Prefs.dart';

class PrefHelper {
  static Future<void> setVisitorId(data) async {
    await Prefs.set('visitorId', data);
  }

  static void setVisitorIdBackup(data) async {
    await Prefs.set('visitorIdBackup', data);
  }

  static Future<String> getVisitorIdBackup() async {
    return await Prefs.get('visitorIdBackup');
  }

  static Future<String> getVisitorId() async {
    return await Prefs.get('visitorId');
  }

  static void setMobile(data) async {
    await Prefs.set('mobile', data);
  }

  static Future<String> getMobile() async {
    return await Prefs.get('mobile');
  }

  static void setFingerPrint(String string) async {
    await Prefs.set('fingerprint', string);
  }

  static Future<String> getFingerPrint() async {
    return await Prefs.get(
      'fingerprint',
    );
  }
}
