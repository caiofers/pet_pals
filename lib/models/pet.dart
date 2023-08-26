import 'dart:math';
import 'package:flutter/material.dart';

// TODO: Adicionar name do type com internacionalização
enum PetType { dog, cat, fish, bird }

// TODO: Adicionar name do gender com internacionalização
enum PetGender { male, female }

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
