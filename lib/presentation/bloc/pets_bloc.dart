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
    String? imageUrl,
    List<PetTutor> tutors,
    List<String> alarmIds,
  ) async {
    String petId = await repository.add(
      name,
      type,
      breed,
      birthdate,
      gender,
      imageUrl,
      tutors,
      alarmIds,
    );

    notifyListeners();
    return petId;
  }

  Future<String?> uploadImage(String imagePath) async {
    return await repository.uploadImage(imagePath);
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
    String? imageUrl,
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
      imageUrl,
      tutors,
      alarmIds,
    );
    notifyListeners();
  }

  // addTutorToPet(String petId, String tutorId) async {
  //   await repository.addTutorToPet(petId, tutorId);
  //   notifyListeners();
  // }

  // removeTutorFromPet(String petId, String tutorId) async {
  //   await repository.removeTutorFromPet(petId, tutorId);
  //   notifyListeners();
  // }

  // addAlarmToPet(String petId, String alarmId) async {
  //   await repository.addAlarmToPet(petId, alarmId);
  //   notifyListeners();
  // }

  // removeAlarmFromPet(String petId, String alarmId) async {
  //   await repository.removeAlarmFromPet(petId, alarmId);
  //   notifyListeners();
  // }

  Future<List<Pet>> getPets(List<String> petIds) async {
    return await repository.getPets(petIds);
  }
}
