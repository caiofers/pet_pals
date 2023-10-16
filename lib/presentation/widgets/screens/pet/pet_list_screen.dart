import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/presentation/bloc/tutors_bloc.dart';
import 'package:pet_pals/presentation/widgets/screens/alarm/pet_alarms_manager_screen.dart';
import 'package:pet_pals/presentation/widgets/screens/pet/add_pet_screen.dart';
import 'package:pet_pals/presentation/widgets/components/pet_card.dart';
import 'package:pet_pals/presentation/bloc/pets_bloc.dart';
import 'package:pet_pals/presentation/widgets/screens/pet/pet_info_screen.dart';
import 'package:provider/provider.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  @override
  Widget build(BuildContext context) {
    final PetsBloc petsBloc = Provider.of<PetsBloc>(context);
    final TutorsBloc tutorsBloc = Provider.of<TutorsBloc>(context);
    final FirebaseAuthService authService = Provider.of<FirebaseAuthService>(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const double buttonHeight = 50;

    Future<List<Pet>> getPets() async {
      String tutorId = authService.firebaseUser?.uid ?? "";
      List<String> petIds = await tutorsBloc.getTutorPetIds(tutorId);
      return petsBloc.getPets(petIds);
    }

    return Scaffold(
      body: FutureBuilder(
          future: getPets(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  //TODO Error InfoView
                  return Center(child: Text("Erro"));
                else
                  return ListOfPets(
                    context: context,
                    snapshot: snapshot,
                    buttonHeight: buttonHeight,
                    bottomPadding: bottomPadding,
                    petsBloc: petsBloc,
                    tutorsBloc: tutorsBloc,
                    authService: authService,
                  );
            }
          }),
    );
  }
}

class ListOfPets extends StatelessWidget {
  const ListOfPets({
    super.key,
    required this.context,
    required this.snapshot,
    required this.buttonHeight,
    required this.bottomPadding,
    required this.petsBloc,
    required this.tutorsBloc,
    required this.authService,
  });

  final BuildContext context;
  final AsyncSnapshot<List<Pet>> snapshot;
  final double buttonHeight;
  final double bottomPadding;
  final PetsBloc petsBloc;
  final TutorsBloc tutorsBloc;
  final FirebaseAuthService authService;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          ListView(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Text(
                  AppLocalizationsBloc.appLocalizations
                      .petScreenTitle(authService.firebaseUser?.displayName ?? "-", snapshot.data?.length ?? 0),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (var pet in snapshot.data!)
                PetCard(
                  pet: pet,
                  onCardTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => PetInfoScreen(
                          pet: pet,
                        ),
                      ),
                    );
                  },
                  onMoreOptionsPressed: () {
                    showModalBottomSheet(
                      context: context,
                      barrierColor: Colors.black38,
                      builder: (context) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                                    leading: Icon(Icons.edit),
                                    title: Text(AppLocalizationsBloc.appLocalizations.editPetText),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => AddPetScreen(
                                            pet: pet,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.people),
                                    title: Text(AppLocalizationsBloc.appLocalizations.managePetTutorsText),
                                    onTap: () {
                                      Navigator.pop(context);
                                      //TODO open tutors manager
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            AppLocalizationsBloc.appLocalizations.unavailableFeat,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.alarm),
                                    title: Text(AppLocalizationsBloc.appLocalizations.managePetAlarmsText),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => Scaffold(
                                            body: PetAlarmsManagerScreen(
                                              pet: pet,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text(AppLocalizationsBloc.appLocalizations.deletePetText),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLocalizationsBloc.appLocalizations.deletePetDialogTitle,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocalizationsBloc
                                                          .appLocalizations.deletePetDialogTitleSubtitle,
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
                                                  child: Text(AppLocalizationsBloc
                                                      .appLocalizations.deletePetDialogCancelButtonText),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () async {
                                                    for (var tutor in pet.tutors) {
                                                      await tutorsBloc.removePetFromTutor(
                                                        tutor.id,
                                                        pet.id,
                                                      );
                                                    }

                                                    petsBloc.remove(pet.id);

                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.delete),
                                                  label: Text(AppLocalizationsBloc
                                                      .appLocalizations.deletePetDialogConfirmButtonText),
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
              margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: bottomPadding),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddPetScreen(
                                pet: null,
                              )));
                },
                child: Text(AppLocalizationsBloc.appLocalizations.addNewPetText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
