import 'package:flutter/material.dart';
import 'package:pet_pals/data/repositories/pets_database_repository.dart';
import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/protocols/pet_repository_protocol.dart';

class PetsBloc extends ChangeNotifier {
  PetRepositoryProtocol repository = PetsDataBaseRepository();

  Future<String> add(
    String name,
    PetType type,
    String breed,
    DateTime birthdate,
    PetGender gender,
    String imagePath,
    List<PetTutor> tutors,
    List<String> alarmIds,
  ) async {
    String petId = await repository.add(
      name,
      type,
      breed,
      birthdate,
      gender,
      imagePath,
      tutors,
      alarmIds,
    );

    notifyListeners();
    return petId;
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
    List<PetTutor> tutors,
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
      tutors,
      alarmIds,
    );
    notifyListeners();
  }

  Future<List<Pet>> getPets(List<String> petIds) async {
    return await repository.getPets(petIds);
  }
}
