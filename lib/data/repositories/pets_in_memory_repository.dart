import 'package:flutter/foundation.dart';
import 'package:pet_pals/data/models/pet_data_model.dart';
import 'package:pet_pals/data/models/pet_tutor_data_model.dart';
import 'package:pet_pals/data/services/firebase_database_service.dart';
import 'package:pet_pals/data/services/pets_mock_service.dart';
import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/protocols/pet_repository_protocol.dart';

class PetsInMemoryRepository implements PetRepositoryProtocol {
  final service = PetsMockService();
  final serviceFirebase = FirebaseDatabaseService();
  late List<PetDataModel> _pets = [];

  PetsInMemoryRepository() {
    //_pets = service.getPets();
  }

  @override
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
    String? url = await serviceFirebase.uploadImage(imagePath);
    PetDataModel pet = PetDataModel(
      UniqueKey().toString(),
      name,
      type.index,
      gender.index,
      breed,
      birthdate.toIso8601String(),
      url,
      tutors.map((tutor) => PetTutorDataModel.fromEntity(tutor)).toList(),
      alarmIds,
    );
    _pets.add(pet);
    return await serviceFirebase.setPet(pet);
  }

  @override
  remove(String id) {
    _pets.removeWhere((element) => element.id == id);
  }

  @override
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
    var pet = _pets.firstWhere((element) => element.id == id);
    pet.name = name;
    pet.type = type.index;
    pet.breed = breed;
    pet.birthdate = birthdate.toIso8601String();
    pet.gender = gender.index;
    pet.imgUrl = imagePath;
  }

  @override
  Future<List<Pet>> getPets(List<String> petIds) async {
    return await serviceFirebase
        .getPets(petIds)
        .then((value) => value.map((e) => e.toEntity()).toList());
    //return _pets.map((pet) => pet.toEntity()).toList();
  }
}
