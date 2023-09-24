import 'package:flutter/foundation.dart';

class User {
  late String id;
  String name;

  User(this.name) {
    id = UniqueKey().toString();
  }
}
