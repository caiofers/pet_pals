import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Container(
          color: Theme.of(context).colorScheme.background.withOpacity(0.95),
          margin: EdgeInsets.only(top: topPadding),
          child: Text("Notificações")),
    );
  }
}
