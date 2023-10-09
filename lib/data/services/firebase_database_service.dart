import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_pals/data/models/pet_data_model.dart';

class FirebaseDatabaseService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> setPet(PetDataModel pet) async {
    try {
      await database.ref().child("pets").push().set(pet.toJson());
    } catch (err) {
      print(err);
    }
  }

  Future<void> updatePet(String id, PetDataModel pet) async {
    try {
      await database
          .ref()
          .child("pets")
          .child(id)
          .update(pet.toJson() as Map<String, Object?>);
    } catch (err) {
      print(err);
    }
  }

  Future<void> removePet(String id) async {
    try {
      await database.ref().child("pets").child(id).remove();
    } catch (err) {
      print(err);
    }
  }

  Future<String> uploadImage(String imagePath) async {
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
      //rethrow;
      print(err);
      return err.toString();
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

  Future<List<PetDataModel>> getPets() async {
    final event = await database.ref().once(DatabaseEventType.value);
    var value = event.snapshot.value as Map?;
    if (value != null) {
      var pets = value["pets"] as Map;
      return pets.values
          .map((pet) => PetDataModel.fromJson(pet))
          .toList(); //TODO: save KEY as ID of pet
    } else {
      return [];
    }
  }
}
