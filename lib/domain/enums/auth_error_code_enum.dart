enum AuthErrorCode {
  userNotFound,
  wrongPassword,
  weakPassword,
  emailAlreadyInUse;

  get message {
    switch (this) {
      case AuthErrorCode.userNotFound:
        return "Usuário não encontrado, cadastre-se";
      case AuthErrorCode.wrongPassword:
        return "Senha incorreta. Tente novamente.";
      case AuthErrorCode.weakPassword:
        return "A senha é muito fraca!";
      case AuthErrorCode.emailAlreadyInUse:
        return "Este email já está cadastrado.";
    }
  }
}
