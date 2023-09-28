import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';

abstract interface class PetRepositoryProtocol {
  Future<void> add(
    String name,
    PetType type,
    String breed,
    DateTime birthdate,
    PetGender gender,
    String imagePath,
    List<String> tutorIds,
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
    List<String> tutorIds,
    List<String> alarmIds,
  );
  void remove(String id);
  Future<List<Pet>> getAllPet();
}
