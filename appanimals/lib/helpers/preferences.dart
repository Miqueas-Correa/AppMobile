import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static bool _lightmode = false;
  //agrega otras preferences
  static late SharedPreferences _prefs;

  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get lightmode {
    return _prefs.getBool('lightmode') ?? _lightmode;
  }

  static set lightmode(bool value) {
    _lightmode = value;
    _prefs.setBool('lightmode', value);
  }

}