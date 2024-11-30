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

  //shared preferences de peces
  // static String _nombre = '';
  // static String _especie = '';
  // static String _color = '';

  // static set nombre(String value) {
  //   _nombre = value;
  //   _prefs.setString('nombre', value);
  // }

  // static String get nombre {
  //   return _prefs.getString('nombre') ?? _nombre;
  // }

  // static set especie(String value) {
  //   _especie = value;
  //   _prefs.setString('especie', value);
  // }

  // static String get especie {
  //   return _prefs.getString('especie') ?? _especie;
  // }

  // static set color(String value) {
  //   _color = value;
  //   _prefs.setString('color', value);
  // }

  // static String get color {
  //   return _prefs.getString('color') ?? _color;
  // }
}