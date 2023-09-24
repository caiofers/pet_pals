import 'package:flutter/material.dart';
import 'package:pet_pals/domain/global_path.dart';
import 'package:pet_pals/domain/models/pet_model.dart';
import 'package:pet_pals/presentation/screens/pet/add_pet_screen.dart';
import 'package:pet_pals/presentation/screens/pet/pet_info_screen.dart';

class PetCard extends StatelessWidget {
  const PetCard({super.key, required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => PetInfoScreen(
                pet: pet,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  child: Image(
                    image: pet.image,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Row(
                              children: [
                                Text("${pet.type.name}, ${pet.gender.name}")
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Idade: ${pet.age}"),
                            Text("Raça: ${pet.breed}"),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print("More options pet");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddPetScreen(
                                        pet: pet,
                                      )));
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 180, left: 16),
              height: 48,
              width: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.amber,
                  //child: const Icon(Icons.pets),
                  child: Image.asset(pet.type.iconAssetName),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
