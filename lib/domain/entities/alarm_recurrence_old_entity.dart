import 'package:pet_pals/domain/enums/alarm_recurrence_ends_enum.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_type_enum.dart';

class AlarmRecurrence {
  AlarmRecurrenceType recurrenceType = AlarmRecurrenceType.never;
  AlarmRecurrenceEnds recurrenceEnds = AlarmRecurrenceEnds.doNotEnd;

  int maxOccurrences = 1;
  //When weekly recurrence
  Map<String, bool> daysOfWeekSelection = {
    "sunday": false,
    "monday": false,
    "tuesday": false,
    "wednesday": false,
    "thursday": false,
    "friday": false,
    "saturday": false,
  };

  //when monthy recurrence;
  DateTime firstAlarmDate = DateTime.now();
  DateTime currentAlarmDate =
      DateTime.now(); //improve later to get the next 5-10 alarms
  bool sameDayEachMonth = true; //on specific date
  bool everyWeekDayOfMonth = false; //on third sunday of month

  updateRecurrenceType(AlarmRecurrenceType recurrenceType) {
    this.recurrenceType = recurrenceType;
    switch (recurrenceType) {
      case AlarmRecurrenceType.never:
        maxOccurrences = 1;
        recurrenceEnds = AlarmRecurrenceEnds.doNotEnd;
        break;
      case AlarmRecurrenceType.daily:
        break;
      case AlarmRecurrenceType.weekly:
        break;
      case AlarmRecurrenceType.monthly:
        // var dayOfMonth = firstAlarmDate.day;
        // var weekday = firstAlarmDate.weekday;

        // var week = 0;
        // while (dayOfMonth > 0) {
        //   dayOfMonth = dayOfMonth - 7;
        //   week++;
        // }

        // var weekStr = "";
        // switch (week) {
        //   case 1:
        //     weekStr = "1st";
        //     break;
        //   case 2:
        //     weekStr = "2nd";
        //     break;
        //   case 3:
        //     weekStr = "3rd";
        //     break;
        //   case 4:
        //     weekStr = "4th";
        //     break;
        //   case 5:
        //     weekStr = "5th";
        //     break;
        //   default:
        //     break;
        // }

        // var weekdayStr = "";
        // switch (weekday) {
        //   case 1:
        //     weekdayStr = "Monday";
        //     break;
        //   case 2:
        //     weekdayStr = "Tuesday";
        //     break;
        //   case 3:
        //     weekdayStr = "Wednesday";
        //     break;
        //   case 4:
        //     weekdayStr = "Thursday";
        //     break;
        //   case 5:
        //     weekdayStr = "Friday";
        //     break;
        //   case 6:
        //     weekdayStr = "Saturday";
        //     break;
        //   case 7:
        //     weekdayStr = "Sunday";
        //     break;
        //   default:
        //     break;
        // }

        // print("on the ${weekStr} ${weekdayStr} of month");

        break;
      case AlarmRecurrenceType.annualy:
        break;
    }
  }
}
