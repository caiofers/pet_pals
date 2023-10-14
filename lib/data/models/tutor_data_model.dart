import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/entities/tutor_entity.dart';
import 'package:pet_pals/domain/enums/tutor_permissions_enum.dart';

class TutorDataModel {
  String id;
  String name;
  String? avatarUrl;
  List<String> petIds;

  TutorDataModel(this.id, this.name, this.avatarUrl, this.petIds);

  factory TutorDataModel.fromJson(dynamic json) {
    List<String> petIds = (json['petIds'] as List?)
            ?.map(
              (e) => e as String,
            )
            .toList() ??
        [];
    return TutorDataModel(
      json['id'] as String,
      json['name'] as String,
      json['avatarUrl'] as String?,
      petIds,
    );
  }

  factory TutorDataModel.fromEntity(Tutor tutor) {
    return TutorDataModel(
      tutor.id,
      tutor.name,
      tutor.avatarUrl,
      tutor.petIds,
    );
  }

  Tutor toEntity() {
    return Tutor(id, name, avatarUrl, petIds);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'petIds': petIds,
    };
  }
}
