import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/presentation/widgets/components/alarm_card.dart';
import 'package:pet_pals/presentation/bloc/alarms_bloc.dart';
import 'package:provider/provider.dart';

class AlarmListScreen extends StatelessWidget {
  const AlarmListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alarmBloc = Provider.of<AlarmsBloc>(context);
    final FirebaseAuthService authService = Provider.of<FirebaseAuthService>(context);
    const double buttonHeight = 50;

    Future<List<Alarm>> getAlarms() async {
      return await alarmBloc.getAllUserAlarms(authService.firebaseUser?.uid ?? "");
    }

    return Scaffold(
      body: FutureBuilder(
        future: getAlarms(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          AppLocalizationsBloc.appLocalizations
                              .alarmScreenTitle(authService.firebaseUser?.displayName ?? "-", snapshot.data!.length),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for (var alarm in snapshot.data!)
                        AlarmCard(
                          alarm: alarm,
                          onCardTap: () {},
                        ),
                      const SizedBox(
                        height: buttonHeight + 16,
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
