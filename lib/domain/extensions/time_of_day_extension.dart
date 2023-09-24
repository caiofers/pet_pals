import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  String toStringByLocale() {
    DateFormat timeFormat =
        DateFormat(DateFormat.HOUR_MINUTE, Platform.localeName);
    DateTime alarmDateTime = DateTime(1, 1, 1, hour, minute);
    return timeFormat.format(alarmDateTime);
  }
}
