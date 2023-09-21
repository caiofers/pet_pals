import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet_pals/models/pet.dart';
import 'package:pet_pals/models/user.dart';

enum AlarmType { food, cleaning, water, walk, play, other }

enum RecurrenceType { never, daily, weekly, monthly, annualy }

enum RecurrenceEnds { doNotEnd, atDate, afterNumberOfOccurences }

class AlarmRecurrence {
  int period = 1;
  RecurrenceType recurrenceType = RecurrenceType.never;
  RecurrenceEnds recurrenceEnds = RecurrenceEnds.doNotEnd;

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
  bool sameDayEachMonth = true; //on specific date
  bool everyWeekDayOfMonth = false; //on third sunday of month

  updateRecurrenceType(RecurrenceType recurrenceType) {
    this.recurrenceType = recurrenceType;
    switch (recurrenceType) {
      case RecurrenceType.never:
        period = 1;
        recurrenceEnds = RecurrenceEnds.doNotEnd;
        break;
      case RecurrenceType.daily:
        break;
      case RecurrenceType.weekly:
        break;
      case RecurrenceType.monthly:
        var dayOfMonth = firstAlarmDate.day;
        var weekday = firstAlarmDate.weekday;

        var week = 0;
        while (dayOfMonth > 0) {
          dayOfMonth = dayOfMonth - 7;
          week++;
        }

        var weekStr = "";
        switch (week) {
          case 1:
            weekStr = "1st";
            break;
          case 2:
            weekStr = "2nd";
            break;
          case 3:
            weekStr = "3rd";
            break;
          case 4:
            weekStr = "4th";
            break;
          case 5:
            weekStr = "5th";
            break;
          default:
            break;
        }

        var weekdayStr = "";
        switch (weekday) {
          case 1:
            weekdayStr = "Monday";
            break;
          case 2:
            weekdayStr = "Tuesday";
            break;
          case 3:
            weekdayStr = "Wednesday";
            break;
          case 4:
            weekdayStr = "Thursday";
            break;
          case 5:
            weekdayStr = "Friday";
            break;
          case 6:
            weekdayStr = "Saturday";
            break;
          case 7:
            weekdayStr = "Sunday";
            break;
          default:
            break;
        }

        print("on the ${weekStr} ${weekdayStr} of month");

        break;
      case RecurrenceType.annualy:
        break;
    }
  }
}

class Alarm {
  late int id;
  String name;
  AlarmType type;
  AlarmRecurrence recurrence = AlarmRecurrence();
  TimeOfDay time = TimeOfDay.now();
  bool enabled = true;

  List<User> users;
  List<Pet> pets;

  Alarm(
      this.name, this.type, this.recurrence, this.time, this.users, this.pets) {
    id = Random().nextInt(10);
  }
}
