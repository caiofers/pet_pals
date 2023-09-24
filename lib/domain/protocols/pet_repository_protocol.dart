import 'package:flutter/material.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/models/pet_model.dart';

abstract interface class PetRepositoryProtocol {
  void add(Pet pet);
  void update(String id, String name, PetType type, String breed,
      DateTime birthdate, PetGender gender, ImageProvider imageProvider);
  void remove(String id);
  List<Pet> getAllPet();
}
