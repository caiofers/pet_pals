import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';

abstract interface class AlarmsRepositoryProtocol {
  Future<String> addAlarm(
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    String time,
    bool enabled,
    String petId,
    List<String> tutorIds,
  );
  Future<void> updateAlarm(
    String id,
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    String time,
    bool enabled,
    String petId,
    List<String> tutorIds,
  );
  Future<void> removeAlarm(String id);
  Future<void> updateRecurrence(String id, AlarmRecurrence recurrence);
  Future<void> switchAlarmOnOff(String id, bool enabled);
  Future<Alarm> getAlarm(String id);
  Future<List<Alarm>> getAllAlarms(DateTime? date);
  Future<List<Alarm>> getAlarmsByIds(List<String> alarmIds);
}
