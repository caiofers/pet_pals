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
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    // TODO: Get height dinamically
    final double titleHeight = 16;
    final double buttonHeight = 50;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: titleHeight + 16, bottom: buttonHeight + 16),
            child: ListView(
              children: [for (var pet in petsProvider.pets) PetCard(pet: pet)],
            ),
          ),
          if (petsProvider.pets.isEmpty) ...[
            Container(
                height: titleHeight,
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.95),
                margin: EdgeInsets.only(top: topPadding),
                child: Text("User, você ainda não tem pets cadastrado.")),
          ] else ...[
            Container(
                width: double.infinity,
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.95),
                margin: EdgeInsets.only(top: topPadding),
                child: Text("User, você ainda não tem pets cadastrado.")),
          ],
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
                  petsProvider.add(Pet("Cacau", PetType.dog, "Vira lata", 3,
                      PetGender.female, ""));
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
