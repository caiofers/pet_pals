import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pet_pals/models/alarm_recurrence_model.dart';
import 'package:pet_pals/models/pet_model.dart';
import 'package:pet_pals/models/user_model.dart';

enum AlarmType { food, cleaning, water, walk, play, other }

class Alarm {
  late int id;
  String name;
  AlarmType type;
  AlarmRecurrenceModel recurrence = AlarmRecurrenceModel();
  TimeOfDay time = TimeOfDay.now();
  bool enabled = true;

  List<User> users;
  List<Pet> pets;

  Alarm(
      this.name, this.type, this.recurrence, this.time, this.users, this.pets) {
    id = Random().nextInt(10);
  }
}
