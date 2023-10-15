import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/presentation/widgets/screens/alarm/add_pet_alarm_screen.dart';
import 'package:pet_pals/presentation/widgets/components/alarm_card.dart';
import 'package:pet_pals/presentation/bloc/alarms_bloc.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alarmBloc = Provider.of<AlarmsBloc>(context);
    final FirebaseAuthService authService =
        Provider.of<FirebaseAuthService>(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const double buttonHeight = 50;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    AppLocalizationsBloc.appLocalizations.alarmScreenTitle(
                        authService.firebaseUser?.displayName ?? "-",
                        alarmBloc.getAllAlarms().length),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                for (var alarm in alarmBloc.getAllAlarms())
                  AlarmCard(alarm: alarm),
                SizedBox(
                  height: buttonHeight + 16,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: buttonHeight,
                color: Colors.transparent,
                margin: EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: bottomPadding),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AddPetAlarmScreen(
                          alarm: null,
                        ),
                      ),
                    );
                  },
                  child: Text(
                      AppLocalizationsBloc.appLocalizations.addNewAlarmText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
