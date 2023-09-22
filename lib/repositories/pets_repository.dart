import 'package:flutter/material.dart';
import 'package:pet_pals/models/pet_model.dart';

class PetsRepository extends ChangeNotifier {
  final List<Pet> _pets = [];

  List<Pet> get pets => _pets;

  add(Pet pet) {
    _pets.add(pet);
    notifyListeners();
  }

  remove(int id) {
    _pets.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  update(int id, String name, PetType type, String breed, DateTime birthdate,
      PetGender gender, ImageProvider imageProvider) {
    var pet = _pets.firstWhere((element) => element.id == id);
    pet.name = name;
    pet.type = type;
    pet.breed = breed;
    pet.birthdate = birthdate;
    pet.gender = gender;
    pet.image = imageProvider;
    notifyListeners();
  }
}
