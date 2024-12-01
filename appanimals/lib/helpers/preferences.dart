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
  //guarda al favorito
  // static Future<void> setFavorite(String id, bool value) async {
  //   await _prefs.setBool(id.toString(), value);
  // }

  // // Obtiene el favorito
  // static bool getFavorite(String id) {
  //   return _prefs.getBool(id.toString()) ?? false;
  // }

  // // Guarda calificación
  // static Future<void> setRating(String id, double value) async {
  //   await _prefs.setDouble(id.toString(), value);
  // }

  // // Obtiene calificación 
  // static double getRating(String id) {
  //   return _prefs.getDouble(id.toString()) ?? 0.0;
  // }
}