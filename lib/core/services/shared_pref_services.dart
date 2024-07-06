import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPreferencesService] is a class that is used to save the token in the shared preferences.
/// It is used to save the token in the shared preferences when the user logs in.
// it has a method called [saveToken] that takes a token as a parameter and saves it in the shared preferences.
// it has a method called [setString] that takes a key and value as parameters and saves it in the shared preferences.
class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();
  late SharedPreferences prefs;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    await setString('token', token);
  }

  String get token => prefs.getString('token') ?? '';

  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }
}
