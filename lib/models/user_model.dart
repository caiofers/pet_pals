import 'dart:math';

class User {
  late int id;
  String name;

  User(this.name) {
    id = Random().nextInt(10);
  }
}
