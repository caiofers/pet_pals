import 'package:flutter/material.dart';
import 'package:pet_pals/models/pet.dart';

class PetCard extends StatelessWidget {
  const PetCard({super.key, required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.pets_rounded),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pet.name),
                Row(
                  children: [Text(pet.type.name), Text(pet.gender.name)],
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Idade: ${pet.age}"),
                Text("Raça: ${pet.kind}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
