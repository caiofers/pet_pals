enum ThemeOptions {
  defaultTheme,
  greenTheme;

  String get key {
    switch (this) {
      case defaultTheme:
        return "default_theme";
      case greenTheme:
        return "green_theme";
    }
  }

  static ThemeOptions byKey(String key) {
    switch (key) {
      case "default_theme":
        return ThemeOptions.defaultTheme;
      case "green_theme":
        return ThemeOptions.greenTheme;
      default:
        return ThemeOptions.defaultTheme;
    }
  }
}
