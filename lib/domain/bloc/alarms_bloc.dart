import 'package:flutter/material.dart';
import 'package:pet_pals/data/repositories/alarms_repository.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';
import 'package:pet_pals/domain/models/alarm_model.dart';
import 'package:pet_pals/domain/models/alarm_recurrence_model.dart';
import 'package:pet_pals/domain/models/pet_model.dart';
import 'package:pet_pals/domain/models/user_model.dart';
import 'package:pet_pals/domain/protocols/alarms_repository_protocol.dart';

class AlarmsBloc extends ChangeNotifier {
  AlarmsRepositoryProtocol repository = AlarmsInMemoryRepository();

  add(Alarm alarm) {
    repository.addAlarm(alarm);
    notifyListeners();
  }

  remove(String id) {
    repository.removeAlarm(id);
    notifyListeners();
  }

  update(
    String id,
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    TimeOfDay time,
    List<Pet> pets,
    List<User> users,
  ) {
    Alarm alarm = Alarm(name, type, recurrence, time, users, pets);
    repository.updateAlarm(id, alarm);
    notifyListeners();
  }

  switchAlarmOnOff(String id, bool enabled) {
    repository.switchAlarmOnOff(id, enabled);
    notifyListeners();
  }

  updateRecurrence(String id, AlarmRecurrence recurrence) {
    repository.updateRecurrence(id, recurrence);
    notifyListeners();
  }

  List<Alarm> getAllAlarms() {
    return repository.getAllAlarms(null);
  }
}
