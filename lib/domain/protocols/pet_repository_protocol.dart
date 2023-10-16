import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';

abstract interface class PetRepositoryProtocol {
  Future<String> add(
    String name,
    PetType type,
    String breed,
    DateTime birthdate,
    PetGender gender,
    String? imageUrl,
    List<PetTutor> tutors,
    List<String> alarmIds,
  );

  Future<void> update(
    String id,
    String name,
    PetType type,
    String breed,
    DateTime birthdate,
    PetGender gender,
    String? imageUrl,
    List<PetTutor> tutors,
    List<String> alarmIds,
  );

  Future<String?> uploadImage(String imagePath);

  Future<void> remove(String id);

  Future<List<Pet>> getPets(List<String> petIds);

  // Future<void> addTutorToPet(String petId, String tutorId);

  // Future<void> removeTutorFromPet(String petId, String tutorId);

  Future<void> addAlarmToPet(String petId, String alarmId);

  Future<void> removeAlarmFromPet(String petId, String alarmId);

  Future<List<String>> getAlarmIdsFromPet(String petId);
}
