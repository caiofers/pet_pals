import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_pals/presentation/themes/theme_options.dart';

class ThemePreferences {
  static const themeKey = "theme_key";

  setTheme(ThemeOptions themeOptions) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(themeKey, themeOptions.key);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return ThemeOptions.byKey(sharedPreferences.getString(themeKey) ?? "");
  }
}
