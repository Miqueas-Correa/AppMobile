import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //static bool _darkmode = false;
  static String _especie = '';
  static String _nombre = '';
  static String _color = '';
  static late SharedPreferences _prefs;

  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // static bool get darkmode {
  //   return _prefs.getBool('darkmode') ?? _darkmode;
  // }

  // static set darkmode(bool value) {
  //   _darkmode = value;
  //   _prefs.setBool('darkmode', value);
  // }

  static set especie(String value) {
    _especie = value;
    _prefs.setString('especie', value);
  }

  static set nombre(String value) {
    _nombre = value;
    _prefs.setString('nombre', value);
  }

  static set color(String value) {
    _color = value;
    _prefs.setString('color', value);
  }


  static String get especie {
    return _prefs.getString('especie') ?? _especie;
  }

  static String get nombre {
    return _prefs.getString('nombre') ?? _nombre;
  }

  static String get  color {
    return _prefs.getString('color') ?? _color;
  }

}