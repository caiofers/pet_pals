import 'package:flutter/material.dart';
import 'package:pet_pals/data/repositories/pets_repository.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/models/pet_model.dart';
import 'package:pet_pals/domain/protocols/pet_repository_protocol.dart';

class PetsBloc extends ChangeNotifier {
  PetRepositoryProtocol repository = PetsInMemoryRepository();

  add(Pet pet) {
    repository.add(pet);
    notifyListeners();
  }

  remove(String id) {
    repository.remove(id);
    notifyListeners();
  }

  update(String id, String name, PetType type, String breed, DateTime birthdate,
      PetGender gender, ImageProvider imageProvider) {
    repository.update(id, name, type, breed, birthdate, gender, imageProvider);
    notifyListeners();
  }

  List<Pet> getAllPets() {
    return repository.getAllPet().toList();
  }
}
