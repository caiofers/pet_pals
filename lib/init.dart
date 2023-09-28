import 'package:flutter/material.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';

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
