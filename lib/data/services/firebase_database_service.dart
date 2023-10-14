import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_pals/data/models/pet_data_model.dart';

class FirebaseDatabaseService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> setPet(PetDataModel pet) async {
    try {
      Map petJson = pet.toJson();
      await database.ref().child("pets").push().set(petJson);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updatePet(String id, PetDataModel pet) async {
    try {
      await database.ref().child("pets").child(id).update(pet.toJson());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> removePet(String id) async {
    try {
      await database.ref().child("pets").child(id).remove();
    } catch (err) {
      rethrow;
    }
  }

  Future<String?> uploadImage(String imagePath) async {
    try {
      File file = File(imagePath);
      await storage
          .ref()
          .child("images/${file.uri.pathSegments.last}")
          .putFile(file);
      return await storage
          .ref()
          .child("images/${file.uri.pathSegments.last}")
          .getDownloadURL();
    } catch (err) {
      print(err);
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
    List<Query> petQueries =
        petIds.map((id) => databaseRef.orderByKey().equalTo(id)).toList();
    try {
      var futurePetsEntries = petQueries.map((query) async {
        return query
            .once(DatabaseEventType.value)
            .then((event) => event.snapshot.value as Map?)
            .then((value) {
          if (value?.entries != null) {
            return value?.entries.first;
          }
        });
      }).toList();

      var petsEntries = await Future.wait(futurePetsEntries);

      return petsEntries.map((pet) {
        pet?.value['id'] = pet.key;
        return PetDataModel.fromJson(pet?.value);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
