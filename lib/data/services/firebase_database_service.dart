import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_pals/data/models/alarm_data_model.dart';
import 'package:pet_pals/data/models/pet_data_model.dart';
import 'package:pet_pals/data/models/tutor_data_model.dart';

class FirebaseDatabaseService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  //MARK: Pets
  Future<String> setPet(PetDataModel pet) async {
    try {
      DatabaseReference reference = database.ref().child("pets").push();
      pet.id = reference.key ?? pet.id;
      Map petJson = pet.toJson();

      await reference.set(petJson);
      return reference.key!;
    } catch (err) {
      //TODO
      rethrow;
    }
  }

  Future<void> updatePet(String id, PetDataModel pet) async {
    try {
      await database.ref().child("pets").child(id).update(pet.toJson());
    } catch (err) {
      //TODO
      rethrow;
    }
  }

  Future<void> removePet(String id) async {
    try {
      await database.ref().child("pets").child(id).remove();
    } catch (err) {
      //TODO
      rethrow;
    }
  }

  // Future<List<PetDataModel>> getPets() async {
  //   final ref = FirebaseDatabase.instance.ref();
  //   final snapshot = await ref.child('pets/').get();
  //   if (snapshot.exists) {
  //     print(snapshot.value);
  //   } else {
  //     print('No data available.');
  //   }
  // }

  Future<List<PetDataModel>> getPets(List<String> petIds) async {
    final databaseRef = database.ref().child('pets');
    List<Query> petQueries = petIds.map((id) => databaseRef.orderByKey().equalTo(id)).toList();
    try {
      var futurePetEntries = petQueries.map((query) async {
        return query.once(DatabaseEventType.value).then((event) => event.snapshot.value as Map?).then((value) {
          if (value?.entries != null) {
            return value?.entries.first;
          }
        });
      }).toList();

      var petEntries = await Future.wait(futurePetEntries);

      return petEntries.map((pet) {
        return PetDataModel.fromJson(pet?.value);
      }).toList();
    } catch (e) {
      //TODO
      rethrow;
    }
  }

  Future<String?> uploadImage(String imagePath) async {
    try {
      File file = File(imagePath);
      Reference reference = storage.ref().child("images/${file.uri.pathSegments.last}");
      await reference.putFile(file);
      return await reference.getDownloadURL();
    } catch (err) {
      return null;
    }
  }

  Future<void> addAlarmToPet(String petId, String alarmId) async {
    try {
      final event = await database.ref('pets').orderByKey().equalTo(petId).once(DatabaseEventType.value);
      final petDataSnapshot = event.snapshot.children.first;
      Map pet = petDataSnapshot.value as Map;
      String petKey = petDataSnapshot.key as String;
      final petDataModel = PetDataModel.fromJson(pet);
      petDataModel.alarmIds.add(alarmId);
      await database.ref().child("pets").child(petKey).update(petDataModel.toJson().cast<String, Object?>());
    } catch (err) {
      //TODO
      print(err);
      rethrow;
    }
  }

  Future<void> removeAlarmFromPet(String petId, String alarmId) async {
    try {
      final event = await database.ref('pets').orderByKey().equalTo(petId).once(DatabaseEventType.value);
      final petDataSnapshot = event.snapshot.children.first;
      Map pet = petDataSnapshot.value as Map;
      String petKey = petDataSnapshot.key as String;
      final petDataModel = PetDataModel.fromJson(pet);
      petDataModel.alarmIds.remove(alarmId);
      await database.ref().child("pets").child(petKey).update(petDataModel.toJson().cast<String, Object?>());
    } catch (err) {
      //TODO
      print(err);
      rethrow;
    }
  }

  Future<List<String>> getAlarmIdsFromPet(String petId) async {
    try {
      final event = await database.ref('pets').orderByKey().equalTo(petId).once(DatabaseEventType.value);
      List pets = event.snapshot.value as List;
      Map pet = pets.first;
      List? alarmIds = pet['alarmIds'] as List?;

      if (alarmIds != null) {
        return alarmIds.map((alarmId) => alarmId as String).toList();
      }
      return [];
    } catch (e) {
      //TODO
      rethrow;
    }
  }

  //MARK: Tutors

  Future<void> setTutor(TutorDataModel tutor) async {
    try {
      Map tutorJson = tutor.toJson();
      await database.ref().child("tutors").push().set(tutorJson);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateTutor(String id, TutorDataModel tutor) async {
    try {
      await database.ref().child("tutors").child(id).update(tutor.toJson());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> removeTutor(String id) async {
    try {
      await database.ref().child("tutors").child(id).remove();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> addPetToTutor(String tutorId, String petId) async {
    try {
      final event = await database.ref('tutors').orderByChild('id').equalTo(tutorId).once(DatabaseEventType.value);
      final tutorDataSnapshot = event.snapshot.children.first;
      Map tutor = tutorDataSnapshot.value as Map;
      String tutorKey = tutorDataSnapshot.key as String;
      final tutorDataModel = TutorDataModel.fromJson(tutor);
      tutorDataModel.petIds.add(petId);
      await database.ref().child("tutors").child(tutorKey).update(tutorDataModel.toJson().cast<String, Object?>());
    } catch (err) {
      //TODO
      print(err);
      rethrow;
    }
  }

  Future<void> removePetFromTutor(String tutorId, String petId) async {
    try {
      final event = await database.ref('tutors').orderByChild('id').equalTo(tutorId).once(DatabaseEventType.value);
      final tutorDataSnapshot = event.snapshot.children.first;
      Map tutor = tutorDataSnapshot.value as Map;
      String tutorKey = tutorDataSnapshot.key as String;
      final tutorDataModel = TutorDataModel.fromJson(tutor);
      tutorDataModel.petIds.remove(petId);
      await database.ref().child("tutors").child(tutorKey).update(tutorDataModel.toJson().cast<String, Object?>());
    } catch (err) {
      //TODO
      print(err);
      rethrow;
    }
  }

  Future<List<TutorDataModel>> getTutors(List<String> tutorIds) async {
    final databaseRef = database.ref().child('tutors');
    List<Query> tutorQueries = tutorIds.map((id) => databaseRef.orderByChild('id').equalTo(id)).toList();
    try {
      var futureTutorEntries = tutorQueries.map((query) async {
        return query.once(DatabaseEventType.value).then((event) => event.snapshot.value as Map?).then((value) {
          if (value?.entries != null) {
            return value?.entries.first;
          }
        });
      }).toList();

      var tutorEntries = await Future.wait(futureTutorEntries);

      return tutorEntries.map((tutor) {
        return TutorDataModel.fromJson(tutor?.value);
      }).toList();
    } catch (e) {
      //TODO
      rethrow;
    }
  }

  Future<List<String>> getPetIdsFromTutor(String tutorId) async {
    try {
      final event = await database.ref('tutors').orderByChild('id').equalTo(tutorId).once(DatabaseEventType.value);
      List tutors = event.snapshot.value as List;
      Map tutor = tutors.first;
      List? petIds = tutor['petIds'] as List?;

      if (petIds != null) {
        return petIds.map((petId) => petId as String).toList();
      }
      return [];
    } catch (e) {
      //TODO
      rethrow;
    }
  }

  Future<void> addAlarmToTutor(String tutorId, String alarmId) async {
    try {
      final event = await database.ref('tutors').orderByChild('id').equalTo(tutorId).once(DatabaseEventType.value);
      final tutorDataSnapshot = event.snapshot.children.first;
      Map tutor = tutorDataSnapshot.value as Map;
      String tutorKey = tutorDataSnapshot.key as String;
      final tutorDataModel = TutorDataModel.fromJson(tutor);
      tutorDataModel.alarmIds.add(alarmId);
      await database.ref().child("tutors").child(tutorKey).update(tutorDataModel.toJson().cast<String, Object?>());
    } catch (err) {
      //TODO
      print(err);
      rethrow;
    }
  }

  Future<void> removeAlarmFromTutor(String tutorId, String alarmId) async {
    try {
      final event = await database.ref('tutors').orderByChild('id').equalTo(tutorId).once(DatabaseEventType.value);
      final tutorDataSnapshot = event.snapshot.children.first;
      Map tutor = tutorDataSnapshot.value as Map;
      String tutorKey = tutorDataSnapshot.key as String;
      final tutorDataModel = TutorDataModel.fromJson(tutor);
      tutorDataModel.alarmIds.remove(alarmId);
      await database.ref().child("tutors").child(tutorKey).update(tutorDataModel.toJson().cast<String, Object?>());
    } catch (err) {
      //TODO
      print(err);
      rethrow;
    }
  }

  Future<List<String>> getAlarmIdsFromTutor(String tutorId) async {
    try {
      final event = await database.ref('tutors').orderByChild('id').equalTo(tutorId).once(DatabaseEventType.value);
      List tutors = event.snapshot.value as List;
      Map tutor = tutors.first;
      List? alarmIds = tutor['alarmIds'] as List?;

      if (alarmIds != null) {
        return alarmIds.map((alarmId) => alarmId as String).toList();
      }
      return [];
    } catch (e) {
      //TODO
      rethrow;
    }
  }

  //MARK: Alarms
  Future<String> setAlarm(AlarmDataModel alarm) async {
    try {
      DatabaseReference reference = database.ref().child("alarms").push();
      alarm.id = reference.key ?? alarm.id;
      Map alarmJson = alarm.toJson();

      await reference.set(alarmJson);
      return reference.key!;
    } catch (err) {
      //TODO
      rethrow;
    }
  }

  Future<void> updateAlarm(String id, AlarmDataModel alarm) async {
    try {
      await database.ref().child("alarms").child(id).update(alarm.toJson());
    } catch (err) {
      //TODO
      rethrow;
    }
  }

  Future<void> removeAlarm(String id) async {
    try {
      await database.ref().child("alarms").child(id).remove();
    } catch (err) {
      //TODO
      rethrow;
    }
  }

  Future<List<AlarmDataModel>> getAlarms(List<String> alarmIds) async {
    final databaseRef = database.ref().child('alarms');
    List<Query> petQueries = alarmIds.map((id) => databaseRef.orderByKey().equalTo(id)).toList();
    try {
      var futureAlarmEntries = petQueries.map((query) async {
        return query.once(DatabaseEventType.value).then((event) => event.snapshot.value as Map?).then((value) {
          if (value?.entries != null) {
            return value?.entries.first;
          }
        });
      }).toList();

      var alarmEntries = await Future.wait(futureAlarmEntries);

      return alarmEntries.map((alarm) {
        return AlarmDataModel.fromJson(alarm?.value);
      }).toList();
    } catch (e) {
      //TODO
      rethrow;
    }
  }
}
