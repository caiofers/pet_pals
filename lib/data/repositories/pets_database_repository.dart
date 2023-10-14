import 'package:flutter/foundation.dart';
import 'package:pet_pals/data/models/pet_data_model.dart';
import 'package:pet_pals/data/models/pet_tutor_data_model.dart';
import 'package:pet_pals/data/services/firebase_database_service.dart';
import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/protocols/pet_repository_protocol.dart';

class PetsDataBaseRepository implements PetRepositoryProtocol {
  final service = FirebaseDatabaseService();

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
    String? url = await service.uploadImage(imagePath);
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
    return service.setPet(pet);
  }

  @override
  remove(String id) {
    service.removePet(id);
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
  ) async {
    String? url = await service.uploadImage(imagePath);
    service.updatePet(
      id,
      PetDataModel(
        id,
        name,
        type.index,
        gender.index,
        breed,
        birthdate.toIso8601String(),
        url,
        tutors.map((tutor) => PetTutorDataModel.fromEntity(tutor)).toList(),
        alarmIds,
      ),
    );
  }

  @override
  Future<List<Pet>> getPets(List<String> petIds) async {
    return await service
        .getPets(petIds)
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}
