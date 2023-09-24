import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocalizationsBloc {
  static AppLocalizations? appLocalizations;

  AppLocalizationsBloc(BuildContext context) {
    AppLocalizationsBloc.appLocalizations = AppLocalizations.of(context);
  }
}
