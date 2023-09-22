import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_pals/models/pet_model.dart';
import 'package:pet_pals/repositories/pets_repository.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key, required this.pet});

  final Pet? pet;

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  Pet? pet;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petBirthdateController = TextEditingController();
  DateTime petBirthdate = DateTime.now();
  PetType petType = PetType.dog;
  PetGender petGender = PetGender.male;
  File? image;

  DateFormat dateFormat =
      DateFormat(DateFormat.YEAR_MONTH_DAY, Platform.localeName);
  @override
  void initState() {
    super.initState();
    pet = widget.pet;
    if (pet != null) {
      petNameController.text = pet!.name;
      petBirthdateController.text = dateFormat.format(pet!.birthdate);
      petBirthdate = pet!.birthdate;
      petType = pet!.type;
      petGender = pet!.gender;
    }
  }

  @override
  void dispose() {
    petNameController.dispose();
    petBirthdateController.dispose();
    super.dispose();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on Exception catch (e) {
      // TODO: Adicionar erro para avisar que falhou ao escolher imagem.
      print("Failed to pickimage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final topSpacing =
        MediaQuery.of(context).padding.top + AppBar().preferredSize.height;
    final petsProvider = Provider.of<PetsRepository>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
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
              margin: EdgeInsets.only(top: topSpacing),
              height: 200,
              width: double.infinity,
              child: image == null
                  ? Image.asset(
                      "lib/assets/images/dog.png",
                      color: Colors.amber,
                    )
                  : Image.file(
                      image!,
                      fit: BoxFit.cover,
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
                      controller: petNameController,
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
                      value: petType,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Select type of pet",
                        labelText: "Pet type",
                      ),
                      items: PetType.values.map((PetType value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          petType = value;
                        }
                      },
                      validator: (value) {
                        if (value?.name.isEmpty ?? true) {
                          return "Please, select the type of animal";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: petBirthdateController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Enter with pet birthdate",
                        labelText: "Pet birthdate",
                      ),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? birthdate = await showDatePicker(
                          context: context,
                          initialDate: petBirthdateController.text.isEmpty
                              ? DateTime.now()
                              : petBirthdate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (birthdate != null) {
                          petBirthdate = birthdate;
                          petBirthdateController.text =
                              dateFormat.format(birthdate);
                        }
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please, enter with the birthdate";
                        }

                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      value: petGender,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Select pet's gender",
                        labelText: "Pet gender",
                      ),
                      items: PetGender.values.map((PetGender value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          petGender = value;
                        }
                      },
                      validator: (value) {
                        if (value?.name.isEmpty ?? true) {
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
                    TextButton(
                      child: Text("Selecionar imagem do pet"),
                      onPressed: () {
                        pickImage();
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (pet == null) {
                                petsProvider.add(Pet(
                                    petNameController.text,
                                    petType,
                                    "Vira lata",
                                    petBirthdate,
                                    petGender,
                                    image != null
                                        ? FileImage(image!) as ImageProvider
                                        : AssetImage(
                                            "lib/assets/images/dog.png")));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Olá")));
                              } else {
                                petsProvider.update(
                                    pet!.id,
                                    petNameController.text,
                                    petType,
                                    "Vira lata",
                                    petBirthdate,
                                    petGender,
                                    image != null
                                        ? FileImage(image!) as ImageProvider
                                        : AssetImage(
                                            "lib/assets/images/dog.png"));
                              }
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
