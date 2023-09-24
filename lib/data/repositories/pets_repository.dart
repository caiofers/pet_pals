import 'package:flutter/material.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/models/pet_model.dart';
import 'package:pet_pals/domain/protocols/pet_repository_protocol.dart';

class PetsInMemoryRepository implements PetRepositoryProtocol {
  final List<Pet> _pets = [];

  @override
  add(Pet pet) {
    _pets.add(pet);
  }

  @override
  remove(String id) {
    _pets.removeWhere((element) => element.id == id);
  }

  @override
  update(String id, String name, PetType type, String breed, DateTime birthdate,
      PetGender gender, ImageProvider imageProvider) {
    var pet = _pets.firstWhere((element) => element.id == id);
    pet.name = name;
    pet.type = type;
    pet.breed = breed;
    pet.birthdate = birthdate;
    pet.gender = gender;
    pet.image = imageProvider;
  }

  @override
  List<Pet> getAllPet() {
    return _pets.toList();
  }
}
