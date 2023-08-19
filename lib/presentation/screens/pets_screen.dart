import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_pals/models/pet.dart';
import 'package:pet_pals/presentation/ui_components/pet_card.dart';
import 'package:pet_pals/repositories/pets_repository.dart';
import 'package:provider/provider.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final petsProvider = Provider.of<PetsRepository>(context);
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
                      !petsProvider.pets.isEmpty
                          ? "Seus pets:"
                          : "User, você ainda não tem pets cadastrado.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                for (var pet in petsProvider.pets) PetCard(pet: pet),
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
                    petsProvider.add(Pet(
                        "Cacau",
                        PetType.dog,
                        "Vira lata",
                        3,
                        PetGender.female,
                        "https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_16x9.jpg?w=1200"));
                  },
                  child: const Text("Add pet"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
