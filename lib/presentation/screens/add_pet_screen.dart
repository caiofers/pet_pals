import 'package:flutter/material.dart';
import 'package:pet_pals/models/pet.dart';
import 'package:pet_pals/repositories/pets_repository.dart';
import 'package:provider/provider.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final petsProvider = Provider.of<PetsRepository>(context);
    const List<String> listPetType = <String>['Dog', 'Cat', 'Bird', 'Fish'];
    const List<String> listPetGender = <String>['Male', 'Female', "Don't know"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text("Adicionar pet"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Image.asset(
                "lib/assets/images/dog.png",
                color: Colors.amber,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 16,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Enter with pet name",
                        labelText: "Pet name",
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please, enter with a name";
                        }

                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Select type of pet",
                        labelText: "Pet type",
                      ),
                      items: listPetType.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please, select the type of animal";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Enter with pet age in months",
                        labelText: "Pet age (months)",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please, enter with a age";
                        }

                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Select pet's gender",
                        labelText: "Pet gender",
                      ),
                      items: listPetGender.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please, select the pet's gender";
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 60,
                      child: Text(
                          "Fazer uma página para selecionar raça (Buscar de uma API e mostrar nome com foto)"),
                    ),
                    SizedBox(
                      height: 60,
                      child: Text(
                          "Fazer um image picker aqui para selecionar foto"),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              petsProvider.add(Pet(
                                  "Cacau",
                                  PetType.dog,
                                  "Vira lata",
                                  3,
                                  PetGender.female,
                                  "https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_16x9.jpg?w=1200"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("Olá")));
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Save")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
