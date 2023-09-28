import 'package:flutter/material.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';
import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';

class Alarm {
  String id;
  String name;
  AlarmType type;
  AlarmRecurrence recurrence;
  TimeOfDay time = TimeOfDay.now();
  bool enabled = true;

  List<String> tutorIds = [];
  List<String> petIds = [];

  Alarm(
    this.id,
    this.name,
    this.type,
    this.recurrence,
    this.time,
    this.tutorIds,
    this.petIds,
  );
}
