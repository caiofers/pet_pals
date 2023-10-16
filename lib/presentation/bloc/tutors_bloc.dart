import 'package:flutter/material.dart';
import 'package:pet_pals/data/repositories/tutors_database_repository.dart';
import 'package:pet_pals/domain/protocols/tutor_repository_protocol.dart';

class TutorsBloc extends ChangeNotifier {
  TutorRepositoryProtocol repository = TutorsDataBaseRepository();

  add(
    String id,
    String name,
    String avatarUrl,
  ) async {
    await repository.add(id, name, avatarUrl);
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

  addAlarmToTutor(String tutorId, String alarmId) async {
    await repository.addAlarmToTutor(tutorId, alarmId);
    notifyListeners();
  }

  removeAlarmFromTutor(String tutorId, String alarmId) async {
    await repository.removeAlarmFromTutor(tutorId, alarmId);
    notifyListeners();
  }

  Future<List<String>> getTutorPetIds(String tutorId) async {
    return await repository.getPetIdsFromTutor(tutorId);
  }
}
