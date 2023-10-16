import 'package:flutter/material.dart';
import 'package:pet_pals/data/models/alarm_recurrence_data_model.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';

class AlarmDataModel {
  String id;
  String name;
  int type;
  AlarmRecurrenceDataModel recurrence;
  String time;
  bool enabled;
  String petId;
  List<String> tutorIds;

  AlarmDataModel(
    this.id,
    this.name,
    this.type,
    this.recurrence,
    this.time,
    this.enabled,
    this.petId,
    this.tutorIds,
  );

  factory AlarmDataModel.fromJson(dynamic json) {
    var tutorIdsJson = json['tutorIds'] as List?;
    List<String> tutorIds = tutorIdsJson
            ?.map(
              (tutorIdJson) => tutorIdJson.toString(),
            )
            .toList() ??
        [];
    return AlarmDataModel(
      json['id'] as String,
      json['name'] as String,
      json['type'] as int,
      AlarmRecurrenceDataModel.fromJson(json['recurrence']),
      json['time'] as String,
      json['enabled'] as bool,
      json['petId'] as String,
      tutorIds,
    );
  }

  factory AlarmDataModel.fromEntity(Alarm alarm) {
    return AlarmDataModel(
      alarm.id,
      alarm.name,
      alarm.type.index,
      AlarmRecurrenceDataModel.fromEntity(alarm.recurrence),
      alarm.time.toString(), //TODO: Check if this is what I want
      alarm.enabled,
      alarm.petId,
      alarm.tutorIds,
    );
  }

  Alarm toEntity() {
    AlarmType alarmType = AlarmType.values.elementAt(type);

    TimeOfDay tempTimeOfDay = TimeOfDay.now(); //TODO Convert time to TimeOfDay

    return Alarm(
      id,
      name,
      alarmType,
      recurrence.toEntity(),
      tempTimeOfDay,
      tutorIds,
      petId,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'recurrence': recurrence.toJson(),
      'time': time,
      'enabled': enabled,
      'petId': petId,
      'tutorIds': tutorIds,
    };
  }
}
