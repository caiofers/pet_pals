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
  Future<String> addAlarm(
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    String time,
    bool enabled,
    String petId,
    List<String> tutorIds,
  ) async {
    _alarms.add(
      AlarmDataModel(
        UniqueKey().toString(),
        name,
        type.index,
        AlarmRecurrenceDataModel.fromEntity(recurrence),
        time,
        enabled,
        petId,
        tutorIds,
      ),
    );

    return "";
  }

  @override
  switchAlarmOnOff(String id, bool enabled) async {
    AlarmDataModel alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.enabled = enabled;
  }

  @override
  Future<Alarm> getAlarm(String id) async {
    return _alarms.firstWhere((alarm) => alarm.id == id).toEntity();
  }

  @override
  Future<List<Alarm>> getAllAlarms(DateTime? dateTime) async {
    if (dateTime != null) {
      return await _alarms
          .where((alarm) => alarm.recurrence.firstAlarmDate == dateTime.toIso8601String())
          .map((alarmModel) => alarmModel.toEntity())
          .toList();
    }
    return await _alarms.map((alarmModel) => alarmModel.toEntity()).toList();
  }

  @override
  removeAlarm(String id) async {
    _alarms.removeWhere((element) => element.id == id);
  }

  @override
  updateAlarm(
    String id,
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    String time,
    bool enabled,
    String petId,
    List<String> tutorIds,
  ) async {
    AlarmDataModel alarmToUpdate = _alarms.firstWhere((element) => element.id == id);
    alarmToUpdate.name = name;
    alarmToUpdate.type = type.index;
    alarmToUpdate.recurrence = AlarmRecurrenceDataModel.fromEntity(recurrence);
    alarmToUpdate.time = time;
    alarmToUpdate.tutorIds = tutorIds;
  }

  @override
  updateRecurrence(String id, AlarmRecurrence recurrence) async {
    AlarmDataModel alarm = _alarms.firstWhere((element) => element.id == id);
    alarm.recurrence = AlarmRecurrenceDataModel.fromEntity(recurrence);
  }

  @override
  Future<List<Alarm>> getAlarmsByIds(List<String> alarmIds) async {
    return await _alarms.where((element) => alarmIds.contains(element.id)).map((e) => e.toEntity()).toList();
  }
}
