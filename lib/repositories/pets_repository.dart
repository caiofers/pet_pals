import 'package:flutter/material.dart';
import 'package:pet_pals/models/pet.dart';

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
}
