import 'package:BMI/blocs/blocs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  SharedPreferences prefs;
  Future<SharedPreferences> initiate() async {
    // Obtain shared preferences.
    prefs = await SharedPreferences.getInstance();
  }

  Future<themetype> getThemeType() async {
    await initiate();
    bool isLight = true;

    // Try reading data from the 'repeat' key. If it doesn't exist, returns null.
    try {
      if (prefs.containsKey("islight")) isLight = prefs.getBool('islight');
    } catch (e) {}

    if (isLight) {
      return themetype.light;
    } else {
      return themetype.dark;
    }
  }

  setThemeType(bool isLight) async {
    await initiate();

    try {
      // Save an boolean value to 'islight' key.
      await prefs.setBool('islight', isLight);
    } catch (e) {}
  }
}
