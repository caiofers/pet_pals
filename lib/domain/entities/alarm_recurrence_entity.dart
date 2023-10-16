import 'package:pet_pals/domain/enums/alarm_recurrence_ends_enum.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_monthly_repetition_enum.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_type_enum.dart';

class AlarmRecurrence {
  AlarmRecurrenceType recurrenceType;
  AlarmRecurrenceEnds recurrenceEnds;
  int maxOccurrences;
  int everyAmountOfTime;

  //When weekly recurrence
  Map<String, bool> daysOfWeekSelection;

  //when monthy recurrence;
  AlarmRecurrenceMonthlyRepetition monthlyRepetition;

  DateTime firstAlarmDate;
  List<DateTime> nextAlarmsDate;

  AlarmRecurrence(
    this.recurrenceType,
    this.everyAmountOfTime,
    this.recurrenceEnds,
    this.maxOccurrences,
    this.daysOfWeekSelection,
    this.monthlyRepetition,
    this.firstAlarmDate,
    this.nextAlarmsDate,
  );
}
