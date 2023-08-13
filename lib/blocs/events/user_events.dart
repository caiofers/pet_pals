interface class UserEvent {}

class LoginUserEvent extends UserEvent {}

class LogoutUserEvent extends UserEvent {}

class RegisterUserEvent extends UserEvent {}

class RecoverPasswordUserEvent extends UserEvent {}