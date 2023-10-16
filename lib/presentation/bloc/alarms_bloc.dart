import 'package:flutter/material.dart';
import 'package:pet_pals/data/repositories/alarms_database_repository.dart';
import 'package:pet_pals/data/repositories/pets_database_repository.dart';
import 'package:pet_pals/data/repositories/tutors_database_repository.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/protocols/alarms_repository_protocol.dart';
import 'package:pet_pals/domain/protocols/pet_repository_protocol.dart';
import 'package:pet_pals/domain/protocols/tutor_repository_protocol.dart';

class AlarmsBloc extends ChangeNotifier {
  AlarmsRepositoryProtocol alarmRepository = AlarmsDatabaseRepository();
  PetRepositoryProtocol petRepository = PetsDataBaseRepository();
  TutorRepositoryProtocol tutorRepository = TutorsDataBaseRepository();

  add(
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    TimeOfDay time,
    bool enabled,
    String petId,
    List<String> tutorIds,
  ) async {
    String alarmId = await alarmRepository.addAlarm(
      name,
      type,
      recurrence,
      time.toString(),
      enabled,
      petId,
      tutorIds,
    );

    await petRepository.addAlarmToPet(petId, alarmId);
    for (String tutorId in tutorIds) {
      await tutorRepository.addAlarmToTutor(tutorId, alarmId);
    }
    notifyListeners();
  }

  remove(String id) async {
    await alarmRepository.removeAlarm(id);
    // await petRepository.removeAlarmFromPet(petId, alarmId);
    // for(String tutorId in tutorIds) {
    //   await tutorRepository.removeAlarmFromTutor(tutorId, alarmId);
    // }
    notifyListeners();
  }

  update(
    String id,
    String name,
    AlarmType type,
    AlarmRecurrence recurrence,
    TimeOfDay time,
    bool enabled,
    String petId,
    List<String> tutorIds,
  ) {
    alarmRepository.updateAlarm(
      id,
      name,
      type,
      recurrence,
      time.toString(),
      enabled,
      petId,
      tutorIds,
    );
    notifyListeners();
  }

  switchAlarmOnOff(String id, bool enabled) {
    alarmRepository.switchAlarmOnOff(id, enabled);
    notifyListeners();
  }

  updateRecurrence(String id, AlarmRecurrence recurrence) {
    alarmRepository.updateRecurrence(id, recurrence);
    notifyListeners();
  }

  Future<List<Alarm>> getTodayUserAlarms(String userId) async {
    return await alarmRepository.getAllAlarms(DateTime.now());
  }

  Future<List<Alarm>> getAllUserAlarms(String userId) async {
    return await alarmRepository.getAllAlarms(null);
  }

  Future<List<Alarm>> getPetAlarms(Pet pet) async {
    return await alarmRepository.getAlarmsByIds(pet.alarmIds);
  }
}
