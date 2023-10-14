import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocalizationsBloc extends ChangeNotifier {
  static AppLocalizations? appLocalizations;

  static init(BuildContext context) {
    AppLocalizationsBloc.appLocalizations = AppLocalizations.of(context);
  }
}
