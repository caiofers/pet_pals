import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_ends_enum.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_monthly_repetition_enum.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_type_enum.dart';

class AlarmRecurrenceDataModel {
  int type;
  int endsWhen;
  int maxOccurrences;
  int everyAmountofTime;
  String firstAlarmDate;
  List<String> nextAlarmsDate;
  List<String> daysOfWeekEnabled;
  int monthlyRepetition;

  AlarmRecurrenceDataModel(
    this.type,
    this.everyAmountofTime,
    this.endsWhen,
    this.maxOccurrences,
    this.firstAlarmDate,
    this.nextAlarmsDate,
    this.daysOfWeekEnabled,
    this.monthlyRepetition,
  );

  factory AlarmRecurrenceDataModel.fromJson(dynamic json) {
    var nextAlarmsDateJson = json['nextAlarmsDate'];
    var daysOfWeekEnabledJson = json['daysOfWeekEnabled'];

    List<String> nextAlarmsDate = nextAlarmsDateJson != null ? List.from(nextAlarmsDateJson) : [];
    List<String> daysOfWeekEnabled = daysOfWeekEnabledJson != null ? List.from(daysOfWeekEnabledJson) : [];

    return AlarmRecurrenceDataModel(
      json['type'] as int,
      json['everyAmountOfTime'] as int,
      json['endsWhen'] as int,
      json['maxOccurences'] as int,
      json['firstAlarmDate'] as String,
      nextAlarmsDate,
      daysOfWeekEnabled,
      json['monthlyRepetition'] as int,
    );
  }

  factory AlarmRecurrenceDataModel.fromEntity(AlarmRecurrence recurrence) {
    return AlarmRecurrenceDataModel(
      recurrence.recurrenceType.index,
      recurrence.everyAmountOfTime,
      recurrence.recurrenceEnds.index,
      recurrence.maxOccurrences,
      recurrence.firstAlarmDate.toIso8601String(),
      [], //TODO: Next alarms date
      [], //TODO: Days selected
      recurrence.monthlyRepetition.index,
    );
  }

  AlarmRecurrence toEntity() {
    AlarmRecurrenceType alarmRecurrenceType = AlarmRecurrenceType.values.elementAt(type);
    AlarmRecurrenceEnds alarmRecurrenceEnds = AlarmRecurrenceEnds.values.elementAt(endsWhen);

    AlarmRecurrenceMonthlyRepetition alarmRecurrenceMonthlyRepetition =
        AlarmRecurrenceMonthlyRepetition.values.elementAt(monthlyRepetition);

    Map<String, bool> daysOfWeekSelection = {
      "sunday": false,
      "monday": false,
      "tuesday": false,
      "wednesday": false,
      "thursday": false,
      "friday": false,
      "saturday": false,
    };

    daysOfWeekSelection.updateAll(
      (key, value) {
        if (daysOfWeekEnabled.contains(key)) {
          return true;
        }
        return false;
      },
    );

    return AlarmRecurrence(
      alarmRecurrenceType,
      everyAmountofTime,
      alarmRecurrenceEnds,
      maxOccurrences,
      daysOfWeekSelection,
      alarmRecurrenceMonthlyRepetition,
      DateTime.parse(firstAlarmDate),
      nextAlarmsDate.map((nextAlarmsAsString) => DateTime.parse(nextAlarmsAsString)).toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'type': type,
      'everyAmountOfTime': everyAmountofTime,
      'endsWhen': endsWhen,
      'maxOccurences': maxOccurrences,
      'firstAlarmDate': firstAlarmDate,
      'nextAlarmsDate': nextAlarmsDate,
      'daysOfWeekEnabled': daysOfWeekEnabled,
      'monthlyRepetition': monthlyRepetition
    };
  }
}
