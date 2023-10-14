import 'package:flutter/material.dart';
import 'package:pet_pals/data/repositories/alarms_in_memory_repository.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/protocols/alarms_repository_protocol.dart';

class AlarmsBloc extends ChangeNotifier {
  AlarmsRepositoryProtocol repository = AlarmsInMemoryRepository();

  add(
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    TimeOfDay time,
    bool enabled,
    List<Pet> pets,
    List<PetTutor> tutors,
  ) {
    List<String> petIds = pets.map((pet) => pet.id).toList();
    List<String> tutorIds = tutors.map((tutor) => tutor.id).toList();

    repository.addAlarm(
      name,
      type,
      recurrence,
      time.toString(),
      enabled,
      petIds,
      tutorIds,
    );
    notifyListeners();
  }

  remove(String id) {
    repository.removeAlarm(id);
    notifyListeners();
  }

  update(
    String id,
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    TimeOfDay time,
    bool enabled,
    List<Pet> pets,
    List<PetTutor> tutors,
  ) {
    List<String> petIds = pets.map((pet) => pet.id).toList();
    List<String> tutorIds = tutors.map((tutor) => tutor.id).toList();

    repository.updateAlarm(
      id,
      name,
      type,
      recurrence,
      time.toString(),
      enabled,
      petIds,
      tutorIds,
    );
    notifyListeners();
  }

  switchAlarmOnOff(String id, bool enabled) {
    repository.switchAlarmOnOff(id, enabled);
    notifyListeners();
  }

  updateRecurrence(String id, AlarmRecurrence recurrence) {
    repository.updateRecurrence(id, recurrence);
    notifyListeners();
  }

  List<Alarm> getAllAlarms() {
    return repository.getAllAlarms(null);
  }
}
