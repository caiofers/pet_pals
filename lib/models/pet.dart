import 'dart:math';

enum PetType { dog, cat, fish, bird }

enum PetGender { male, female }

class Pet {
  late int id;
  String name;
  PetType type;
  String kind;
  int age;
  String image;
  PetGender gender;

  Pet(this.name, this.type, this.kind, this.age, this.gender, this.image) {
    id = Random().nextInt(10);
  }
}
