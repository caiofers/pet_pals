import 'package:pet_pals/domain/enums/tutor_permissions_enum.dart';

class PetTutor {
  String id;
  String name;
  String? avatarUrl;
  TutorPermissions permissions;

  PetTutor(this.id, this.name, this.avatarUrl, this.permissions);
}
