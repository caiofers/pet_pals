import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';

class PetDataModel {
  String id;
  String name;
  int type;
  int gender;
  String breed;
  String birthdate;
  String imgUrl;
  List<String> tutorIds;
  List<String> alarmIds;

  PetDataModel(
    this.id,
    this.name,
    this.type,
    this.gender,
    this.breed,
    this.birthdate,
    this.imgUrl,
    this.tutorIds,
    this.alarmIds,
  );

  factory PetDataModel.fromJson(dynamic json) {
    var tutorIdsJson = json['tutorIds'] as List;
    List<String> tutorIds = tutorIdsJson
        .map(
          (tutorIdJson) => tutorIdJson.toString(),
        )
        .toList();

    var alarmIdsJson = json['alarmIds'] as List;
    List<String> alarmIds = alarmIdsJson
        .map(
          (alarmIdJson) => alarmIdJson.toString(),
        )
        .toList();
    return PetDataModel(
      json['id'] as String,
      json['name'] as String,
      json['type'] as int,
      json['gender'] as int,
      json['breed'] as String,
      json['birthdate'] as String,
      json['imgUrl'] as String,
      tutorIds,
      alarmIds,
    );
  }

  factory PetDataModel.fromEntity(Pet pet) {
    return PetDataModel(
      pet.id,
      pet.name,
      pet.type.index,
      pet.gender.index,
      pet.breed,
      pet.birthdate.toIso8601String(),
      pet.imageUrl,
      pet.tutorIds,
      pet.alarmIds,
    );
  }

  Pet toEntity() {
    PetType petType = PetType.values.elementAt(type);
    DateTime petBirthdate = DateTime.parse(birthdate);
    PetGender petGender = PetGender.values.elementAt(type);

    return Pet(
      id,
      name,
      petType,
      breed,
      petBirthdate,
      petGender,
      imgUrl,
      tutorIds,
      alarmIds,
    );
  }
}
