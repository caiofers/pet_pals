import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';

abstract interface class AlarmsRepositoryProtocol {
  void addAlarm(
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    String time,
    bool enabled,
    List<String> petIds,
    List<String> tutorIds,
  );
  void updateAlarm(
    String id,
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    String time,
    bool enabled,
    List<String> petIds,
    List<String> tutorIds,
  );
  void removeAlarm(String id);
  void updateRecurrence(String id, AlarmRecurrence recurrence);
  void switchAlarmOnOff(String id, bool enabled);
  Alarm getAlarm(String id);
  List<Alarm> getAllAlarms(DateTime? date);
}
