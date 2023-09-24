import 'package:flutter/material.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';
import 'package:pet_pals/domain/models/alarm_recurrence_model.dart';
import 'package:pet_pals/domain/models/pet_model.dart';
import 'package:pet_pals/domain/models/user_model.dart';

class Alarm {
  late String id;
  String name;
  AlarmType type;
  AlarmRecurrence recurrence = AlarmRecurrence();
  TimeOfDay time = TimeOfDay.now();
  bool enabled = true;

  List<User> users;
  List<Pet> pets;

  Alarm(
      this.name, this.type, this.recurrence, this.time, this.users, this.pets) {
    id = UniqueKey().toString();
  }
}
