import 'package:pet_pals/domain/entities/tutor_entity.dart';

class TutorDataModel {
  String id;
  String name;
  String? avatarUrl;
  List<String> petIds;
  List<String> alarmIds;

  TutorDataModel(this.id, this.name, this.avatarUrl, this.petIds, this.alarmIds);

  factory TutorDataModel.fromJson(dynamic json) {
    List<String> petIds = (json['petIds'] as List?)
            ?.map(
              (e) => e as String,
            )
            .toList() ??
        [];

    List<String> alarmIds = (json['petIds'] as List?)
            ?.map(
              (e) => e as String,
            )
            .toList() ??
        [];

    return TutorDataModel(json['id'] as String, json['name'] as String, json['avatarUrl'] as String?, petIds, alarmIds);
  }

  factory TutorDataModel.fromEntity(Tutor tutor) {
    return TutorDataModel(
      tutor.id,
      tutor.name,
      tutor.avatarUrl,
      tutor.petIds,
      tutor.alarmsIds,
    );
  }

  Tutor toEntity() {
    return Tutor(id, name, avatarUrl, petIds, alarmIds);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'petIds': petIds,
      'alarmIds': alarmIds,
    };
  }
}
