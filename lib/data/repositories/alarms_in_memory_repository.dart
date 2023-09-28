import 'package:flutter/foundation.dart';
import 'package:pet_pals/data/models/alarm_data_model.dart';
import 'package:pet_pals/data/models/alarm_recurrence_data_model.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';
import 'package:pet_pals/domain/protocols/alarms_repository_protocol.dart';

class AlarmsInMemoryRepository implements AlarmsRepositoryProtocol {
  final List<AlarmDataModel> _alarms = [];

  @override
  void addAlarm(
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    String time,
    bool enabled,
    List<String> petIds,
    List<String> tutorIds,
  ) {
    _alarms.add(
      AlarmDataModel(
        UniqueKey().toString(),
        name,
        type.index,
        AlarmRecurrenceDataModel.fromEntity(recurrence),
        time,
        enabled,
        petIds,
        tutorIds,
      ),
    );
  }

  @override
  void switchAlarmOnOff(String id, bool enabled) {
    AlarmDataModel alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.enabled = enabled;
  }

  @override
  Alarm getAlarm(String id) {
    return _alarms.firstWhere((alarm) => alarm.id == id).toEntity();
  }

  @override
  List<Alarm> getAllAlarms(DateTime? dateTime) {
    if (dateTime != null) {
      return _alarms
          .where((alarm) =>
              alarm.recurrence.firstAlarmDate == dateTime.toIso8601String())
          .map((alarmModel) => alarmModel.toEntity())
          .toList();
    }
    return _alarms.map((alarmModel) => alarmModel.toEntity()).toList();
  }

  @override
  void removeAlarm(String id) {
    _alarms.removeWhere((element) => element.id == id);
  }

  @override
  void updateAlarm(
    String id,
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    String time,
    bool enabled,
    List<String> petIds,
    List<String> tutorIds,
  ) {
    AlarmDataModel alarmToUpdate =
        _alarms.firstWhere((element) => element.id == id);
    alarmToUpdate.name = name;
    alarmToUpdate.type = type.index;
    alarmToUpdate.recurrence = AlarmRecurrenceDataModel.fromEntity(recurrence);
    alarmToUpdate.time = time;
    alarmToUpdate.petIds = petIds;
    alarmToUpdate.tutorIds = tutorIds;
  }

  @override
  void updateRecurrence(String id, AlarmRecurrence recurrence) {
    AlarmDataModel alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.recurrence = AlarmRecurrenceDataModel.fromEntity(recurrence);
  }
}
