import 'package:pet_pals/domain/models/alarm_model.dart';
import 'package:pet_pals/domain/models/alarm_recurrence_model.dart';

abstract interface class AlarmsRepositoryProtocol {
  void addAlarm(Alarm alarm);
  void removeAlarm(String id);
  void updateAlarm(String id, Alarm alarm);
  void updateRecurrence(String id, AlarmRecurrence recurrence);
  void switchAlarmOnOff(String id, bool enabled);
  Alarm getAlarm(String id);
  List<Alarm> getAllAlarms(DateTime? date);
}
