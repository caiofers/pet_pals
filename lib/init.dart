class Init {
  static Future initialize() async {
    await _registerServices();
    await _loadSettings();
  }

  static _registerServices() async {
    // TODO: Registrar serviços como firebase, etc
  }

  static _loadSettings() async {
    // TODO: Carregar configurações
  }
}
