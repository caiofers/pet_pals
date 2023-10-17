import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/presentation/bloc/pets_bloc.dart';
import 'package:pet_pals/presentation/widgets/screens/alarm/add_pet_alarm_screen.dart';
import 'package:pet_pals/presentation/widgets/components/alarm_card.dart';
import 'package:pet_pals/presentation/bloc/alarms_bloc.dart';
import 'package:provider/provider.dart';

class PetAlarmsManagerScreen extends StatefulWidget {
  const PetAlarmsManagerScreen({super.key, required this.pet});

  final Pet pet;

  @override
  State<PetAlarmsManagerScreen> createState() => _PetAlarmsManagerScreenState();
}

class _PetAlarmsManagerScreenState extends State<PetAlarmsManagerScreen> {
  Pet? pet;

  @override
  void initState() {
    super.initState();
    pet = widget.pet;
  }

  @override
  Widget build(BuildContext context) {
    final alarmBloc = Provider.of<AlarmsBloc>(context);
    final petBloc = Provider.of<PetsBloc>(context);
    final FirebaseAuthService authService = Provider.of<FirebaseAuthService>(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const double buttonHeight = 50;

    Future<List<Alarm>> getAlarms() async {
      pet = await petBloc.getPets([widget.pet.id].toList()).then((value) => value.first);
      return await alarmBloc.getPetAlarms(pet!);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text("Gerenciar alarmes"),
      ),
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
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              AppLocalizationsBloc.appLocalizations.alarmScreenTitle(
                                  authService.firebaseUser?.displayName ?? "-", snapshot.data!.length),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          for (var alarm in snapshot.data!)
                            AlarmCard(
                              alarm: alarm,
                              onCardTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  barrierColor: Colors.black38,
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 16.0),
                                          child: SizedBox(
                                            height: 8,
                                            width: 80,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            children: [
                                              ListTile(
                                                leading: const Icon(Icons.edit),
                                                title: const Text("Editar alarme"),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => AddPetAlarmScreen(
                                                        alarm: alarm,
                                                        pet: widget.pet,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons.delete),
                                                title: const Text("Excluir alarme"),
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "Deseja excluir o alarme?",
                                                                textAlign: TextAlign.center,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "Essa ação não poderá ser desfeita.",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(fontSize: 14),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: const Text("Cancelar"),
                                                            ),
                                                            ElevatedButton.icon(
                                                              onPressed: () async {
                                                                alarmBloc.remove(alarm.id);

                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                              },
                                                              icon: const Icon(Icons.delete),
                                                              label: const Text("Excluir"),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          const SizedBox(
                            height: buttonHeight + 16,
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: buttonHeight,
                          color: Colors.transparent,
                          margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: bottomPadding),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AddPetAlarmScreen(
                                    pet: widget.pet,
                                    alarm: null,
                                  ),
                                ),
                              );
                            },
                            child: Text(AppLocalizationsBloc.appLocalizations.addNewAlarmText),
                          ),
                        ),
                      ),
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
