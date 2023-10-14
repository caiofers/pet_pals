import 'package:pet_pals/domain/enums/auth_error_code_enum.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}
