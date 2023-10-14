import 'package:pet_pals/data/models/pet_tutor_data_model.dart';
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
  String? imgUrl;
  List<PetTutorDataModel> tutors;
  List<String> alarmIds;

  PetDataModel(
    this.id,
    this.name,
    this.type,
    this.gender,
    this.breed,
    this.birthdate,
    this.imgUrl,
    this.tutors,
    this.alarmIds,
  );

  factory PetDataModel.fromJson(dynamic json) {
    var tutorsJson = json['tutors'] as List?;
    List<PetTutorDataModel> tutors = tutorsJson
            ?.map(
              (tutorJson) => PetTutorDataModel.fromJson(tutorJson),
            )
            .toList() ??
        [];

    var alarmIdsJson = json['alarmIds'] as List?;
    List<String> alarmIds = alarmIdsJson
            ?.map(
              (alarmIdJson) => alarmIdJson.toString(),
            )
            .toList() ??
        [];
    return PetDataModel(
      json['id'] as String,
      json['name'] as String,
      json['type'] as int,
      json['gender'] as int,
      json['breed'] as String,
      json['birthdate'] as String,
      json['imgUrl'] as String,
      tutors,
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
      pet.tutors.map((tutor) => PetTutorDataModel.fromEntity(tutor)).toList(),
      pet.alarmIds,
    );
  }

  Pet toEntity() {
    PetType petType = PetType.values.elementAt(type);
    DateTime petBirthdate = DateTime.parse(birthdate);
    PetGender petGender = PetGender.values.elementAt(gender);

    return Pet(
      id,
      name,
      petType,
      breed,
      petBirthdate,
      petGender,
      imgUrl,
      tutors.map((tutor) => tutor.toEntity()).toList(),
      alarmIds,
    );
  }

  Map<String, Object?> toJson() {
    List tutorsJson = tutors.map((e) => e.toJson()).toList();
    return {
      'id': id,
      'name': name,
      'type': type,
      'gender': gender,
      'breed': breed,
      'birthdate': birthdate,
      'imgUrl': imgUrl,
      'tutors': tutorsJson,
      'alarmIds': alarmIds
    };
  }

  Map<String, Object?> toJson2() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'gender': gender,
      'breed': breed,
      'birthdate': birthdate,
      'imgUrl': imgUrl,
      //'tutors': tutors.map((e) => e.toJson() as Map<String, Object?>).toList(),
      'alarmIds': alarmIds
    };
  }
}
