import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/enums/tutor_permissions_enum.dart';

class PetTutorDataModel {
  String id;
  String name;
  String? avatarUrl;
  int permission;

  PetTutorDataModel(this.id, this.name, this.avatarUrl, this.permission);

  factory PetTutorDataModel.fromJson(dynamic json) {
    return PetTutorDataModel(
      json['id'] as String,
      json['name'] as String,
      json['avatarUrl'] as String?,
      json['permission'] as int,
    );
  }

  factory PetTutorDataModel.fromEntity(PetTutor tutor) {
    return PetTutorDataModel(
      tutor.id,
      tutor.name,
      tutor.avatarUrl,
      tutor.permissions.index,
    );
  }

  PetTutor toEntity() {
    TutorPermissions tutorPermission =
        TutorPermissions.values.elementAt(permission);

    return PetTutor(id, name, avatarUrl, tutorPermission);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'permission': permission,
    };
  }
}
