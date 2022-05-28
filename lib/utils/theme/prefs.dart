import 'package:BMI/blocs/blocs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  SharedPreferences prefs;
  Future<SharedPreferences> initiate() async {
    // Obtain shared preferences.
    prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  Future<Themetype> getThemeType() async {
    await initiate();
    bool isLight = true;

    // Try reading data from the 'repeat' key. If it doesn't exist, returns null.
    try {
      if (prefs.containsKey("islight")) isLight = prefs.getBool('islight');
    } catch (e) {}

    if (isLight) {
      return Themetype.light;
    } else {
      return Themetype.dark;
    }
  }

  setThemeType(bool isLight) async {
    await initiate();

    try {
      // Save an boolean value to 'islight' key.
      await prefs.setBool('islight', isLight);
    } catch (e) {}
  }

  //language pref
  Future<String> getLanguageCode() async {
    await initiate();
    String langCode = 'en';

    try {
      if (prefs.containsKey("langcode")) langCode = prefs.getString('langcode');
    } catch (e) {}

    return langCode;
  }

  setLanguageCode(String langCode) async {
    await initiate();
    try {
      // Save language code ("en" or "fa")
      await prefs.setString('langcode', langCode);
    } catch (e) {}
  }
}
