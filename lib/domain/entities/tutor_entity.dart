import 'package:pet_pals/domain/enums/tutor_permissions_enum.dart';

class Tutor {
  String id;
  String name;
  String avatarUrl;
  TutorPermissions permissions;

  Tutor(this.id, this.name, this.avatarUrl, this.permissions);
}
