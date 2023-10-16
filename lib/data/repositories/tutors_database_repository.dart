import 'package:pet_pals/data/models/tutor_data_model.dart';
import 'package:pet_pals/data/services/firebase_database_service.dart';
import 'package:pet_pals/domain/protocols/tutor_repository_protocol.dart';

class TutorsDataBaseRepository implements TutorRepositoryProtocol {
  final service = FirebaseDatabaseService();

  @override
  Future<void> add(String id, String name, String? avatarUrl) async {
    await service.setTutor(TutorDataModel(id, name, avatarUrl, [], []));
  }

  @override
  Future<void> addPetToTutor(String tutorId, String petId) async {
    await service.addPetToTutor(tutorId, petId);
  }

  @override
  Future<void> removePetFromTutor(String tutorId, String petId) async {
    await service.removePetFromTutor(tutorId, petId);
  }

  @override
  Future<List<String>> getPetIdsFromTutor(String tutorId) async {
    return await service.getPetIdsFromTutor(tutorId);
  }

  @override
  Future<void> addAlarmToTutor(String tutorId, String alarmId) async {
    await service.addAlarmToTutor(tutorId, alarmId);
  }

  @override
  Future<void> removeAlarmFromTutor(String tutorId, String alarmId) async {
    await service.removeAlarmFromTutor(tutorId, alarmId);
  }

  @override
  Future<List<String>> getAlarmIdsFromTutor(String tutorId) async {
    return await service.getAlarmIdsFromTutor(tutorId);
  }
}
