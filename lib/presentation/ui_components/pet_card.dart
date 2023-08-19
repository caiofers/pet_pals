import 'package:flutter/material.dart';
import 'package:pet_pals/models/pet.dart';
import 'package:pet_pals/presentation/screens/pet_info_screen.dart';

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
                      )));
        },
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  child: Image.network(
                    "https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_16x9.jpg?w=1200",
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
                              children: [Text("Cadela, Fêmea")],
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
                            Text("Idade: ${pet.age} meses"),
                            Text("Raça: Não definida"),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print("More options pet");
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 180),
              padding: const EdgeInsets.only(left: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.amber,
                    child: const Icon(Icons.pets)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
