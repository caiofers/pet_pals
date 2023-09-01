import 'dart:math';
import 'package:flutter/material.dart';

// TODO: Adicionar name do type com internacionalização
enum PetType {
  dog,
  cat,
  fish,
  bird;

  String get name {
    switch (this) {
      case PetType.dog:
        return "Dog";
      case PetType.cat:
        return "Cat";
      case PetType.fish:
        return "Fish";
      case PetType.bird:
        return "Bird";
    }
  }
}

// TODO: Adicionar name do gender com internacionalização
enum PetGender {
  male,
  female;

  String get name {
    switch (this) {
      case PetGender.male:
        return "Male";
      case PetGender.female:
        return "Female";
    }
  }
}

class Pet {
  late int id;
  String name;
  PetType type;
  String kind;
  int age;
  ImageProvider image;
  PetGender gender;

  Pet(this.name, this.type, this.kind, this.age, this.gender, this.image) {
    id = Random().nextInt(10);
  }
}
