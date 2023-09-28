import 'package:flutter/material.dart';
import 'package:pet_pals/data/repositories/pets_in_memory_repository.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/protocols/pet_repository_protocol.dart';

class PetsBloc extends ChangeNotifier {
  PetRepositoryProtocol repository = PetsInMemoryRepository();

  add(
    String name,
    PetType type,
    String breed,
    DateTime birthdate,
    PetGender gender,
    String imagePath,
    List<String> tutorIds,
    List<String> alarmIds,
  ) {
    repository.add(
      name,
      type,
      breed,
      birthdate,
      gender,
      imagePath,
      tutorIds,
      alarmIds,
    );
    notifyListeners();
  }

  remove(String id) {
    repository.remove(id);
    notifyListeners();
  }

  update(
    String id,
    String name,
    PetType type,
    String breed,
    DateTime birthdate,
    PetGender gender,
    String imagePath,
    List<String> tutorIds,
    List<String> alarmIds,
  ) {
    repository.update(
      id,
      name,
      type,
      breed,
      birthdate,
      gender,
      imagePath,
      tutorIds,
      alarmIds,
    );
    notifyListeners();
  }

  List<Pet> getAllPets() {
    return repository.getAllPet().toList();
  }
}
