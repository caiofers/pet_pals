import 'package:flutter/material.dart';
import 'package:pet_pals/models/alarm.dart';
import 'package:pet_pals/models/pet.dart';
import 'package:pet_pals/models/user.dart';

class AlarmsRepository extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  List<Alarm> get alarms => _alarms;

  add(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  remove(int id) {
    _alarms.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  update(int id, String name, AlarmType type, AlarmRecurrence recurrence,
      TimeOfDay time, List<Pet> pets, List<User> users) {
    var alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.name = name;
    alarm.type = type;
    alarm.recurrence = recurrence;
    alarm.time = time;
    alarm.pets = pets;
    alarm.users = users;
    notifyListeners();
  }

  updateEnable(int id, bool enabled) {
    var alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.enabled = enabled;
    notifyListeners();
  }

  updateRecurrence(int id, AlarmRecurrence recurrence) {
    var alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.recurrence = recurrence;
    notifyListeners();
  }
}
