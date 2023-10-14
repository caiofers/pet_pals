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
    String imagePath,
    List<PetTutor> tutors,
    List<String> alarmIds,
  );
  void update(
    String id,
    String name,
    PetType type,
    String breed,
    DateTime birthdate,
    PetGender gender,
    String imagePath,
    List<PetTutor> tutors,
    List<String> alarmIds,
  );
  void remove(String id);
  Future<List<Pet>> getPets(List<String> petIds);
}
