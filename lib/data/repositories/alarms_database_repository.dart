import 'package:flutter/foundation.dart';
import 'package:pet_pals/data/models/alarm_data_model.dart';
import 'package:pet_pals/data/models/alarm_recurrence_data_model.dart';
import 'package:pet_pals/data/services/firebase_database_service.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';
import 'package:pet_pals/domain/protocols/alarms_repository_protocol.dart';

class AlarmsDatabaseRepository implements AlarmsRepositoryProtocol {
  final service = FirebaseDatabaseService();

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
    return await service.setAlarm(
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
  }

  @override
  switchAlarmOnOff(String id, bool enabled) async {
    //TODO
  }

  @override
  Future<Alarm> getAlarm(String id) async {
    return await service.getAlarms([id]).then((value) => value.first.toEntity());
  }

  @override
  Future<List<Alarm>> getAllAlarms(DateTime? dateTime) async {
    //TODO
    return [];
  }

  @override
  removeAlarm(String id) async {
    service.removeAlarm(id);
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
    await service.updateAlarm(
      id,
      AlarmDataModel(
        id,
        name,
        type.index,
        AlarmRecurrenceDataModel.fromEntity(recurrence),
        time,
        enabled,
        petId,
        tutorIds,
      ),
    );
  }

  @override
  updateRecurrence(String id, AlarmRecurrence recurrence) async {
    // TODO AlarmRecurrenceDataModel.fromEntity(recurrence);
  }

  @override
  Future<List<Alarm>> getAlarmsByIds(List<String> alarmIds) async {
    return await service.getAlarms(alarmIds).then((value) => value.map((e) => e.toEntity()).toList());
  }
}
