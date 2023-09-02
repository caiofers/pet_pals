import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocalizationsManager {
  static AppLocalizations? appLocalizations;

  AppLocalizationsManager(BuildContext context) {
    AppLocalizationsManager.appLocalizations = AppLocalizations.of(context);
  }
}
