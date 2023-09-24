import 'package:pet_pals/domain/models/alarm_model.dart';
import 'package:pet_pals/domain/models/alarm_recurrence_model.dart';
import 'package:pet_pals/domain/models/pet_model.dart';
import 'package:pet_pals/domain/models/user_model.dart';
import 'package:pet_pals/domain/protocols/alarms_repository_protocol.dart';

class AlarmsInMemoryRepository implements AlarmsRepositoryProtocol {
  final List<Alarm> _alarms = [];

  @override
  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
  }

  @override
  void switchAlarmOnOff(String id, bool enabled) {
    Alarm alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.enabled = enabled;
  }

  @override
  Alarm getAlarm(String id) {
    return _alarms.firstWhere((element) => element.id == id);
  }

  @override
  List<Alarm> getAllAlarms(DateTime? dateTime) {
    if (dateTime != null) {
      return _alarms
          .where((element) => element.recurrence.firstAlarmDate == dateTime)
          .toList();
    }
    return _alarms.toList();
  }

  @override
  void removeAlarm(String id) {
    _alarms.removeWhere((element) => element.id == id);
  }

  @override
  void updateAlarm(String id, Alarm alarm) {
    Alarm alarmToUpdate = _alarms.firstWhere((element) => element.id == id);
    alarmToUpdate.name = alarm.name;
    alarmToUpdate.type = alarm.type;
    alarmToUpdate.recurrence = alarm.recurrence;
    alarmToUpdate.time = alarm.time;
    alarmToUpdate.pets = alarm.pets;
    alarmToUpdate.users = alarm.users;
  }

  @override
  void updateRecurrence(String id, AlarmRecurrence recurrence) {
    Alarm alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.recurrence = recurrence;
  }
}
