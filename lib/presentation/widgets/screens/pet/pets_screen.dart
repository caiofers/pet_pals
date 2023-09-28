import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/presentation/widgets/screens/pet/add_pet_screen.dart';
import 'package:pet_pals/presentation/widgets/components/pet_card.dart';
import 'package:pet_pals/presentation/bloc/pets_bloc.dart';
import 'package:provider/provider.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  @override
  Widget build(BuildContext context) {
    final petsBloc = Provider.of<PetsBloc>(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const double buttonHeight = 50;

    List<Pet> pets = [];

    getAllPetsList() {
      petsBloc.getAllPets().then((value) {
        setState(() {
          pets = value;
        });
      });
    }

    return Scaffold(
      body: FutureBuilder(
          future: petsBloc.getAllPets(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Text("Loading");
              default:
                if (snapshot.hasError)
                  return Text("Erro");
                else
                  return ListOfPets(
                      context: context,
                      snapshot: snapshot,
                      buttonHeight: buttonHeight,
                      bottomPadding: bottomPadding);
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
  });

  final BuildContext context;
  final AsyncSnapshot<List<Pet>> snapshot;
  final double buttonHeight;
  final double bottomPadding;

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
                    (snapshot.data?.isNotEmpty ?? false)
                        ? "Seus pets:"
                        : "User, você ainda não tem pets cadastrado.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              for (var pet in snapshot.data!) PetCard(pet: pet),
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
                          builder: (BuildContext context) => AddPetScreen(
                                pet: null,
                              )));
                },
                child: const Text("Add pet"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
