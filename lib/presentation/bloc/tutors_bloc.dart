import 'package:flutter/material.dart';
import 'package:pet_pals/data/repositories/pets_database_repository.dart';
import 'package:pet_pals/data/repositories/tutors_database_repository.dart';
import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/protocols/pet_repository_protocol.dart';
import 'package:pet_pals/domain/protocols/tutor_repository_protocol.dart';

class TutorsBloc extends ChangeNotifier {
  TutorRepositoryProtocol repository = TutorsDataBaseRepository();

  add(
    String id,
    String name,
    String avatarUrl,
    List<String> petIds,
  ) async {
    await repository.add(id, name, avatarUrl, petIds);
    notifyListeners();
  }

  addPetToTutor(String tutorId, String petId) async {
    await repository.addPetToTutor(tutorId, petId);
    notifyListeners();
  }

  removePetFromTutor(String tutorId, String petId) async {
    await repository.removePetFromTutor(tutorId, petId);
    notifyListeners();
  }

  Future<List<String>> getTutorPetIds(String tutorId) async {
    return await repository.getTutorPetIds(tutorId);
  }
}
