import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_pals/l10n/app_localizations_manager.dart';

// TODO: Adicionar name do type com internacionalização (+ diferenciação de gênero);
enum PetType {
  dog,
  cat,
  fish,
  bird;

  String get name {
    switch (this) {
      case PetType.dog:
        return "Dog";
      case PetType.cat:
        return "Cat";
      case PetType.fish:
        return "Fish";
      case PetType.bird:
        return "Bird";
    }
  }

  // TODO: Adicionar icones para cada tipo de animal
  AssetImage get icon {
    switch (this) {
      case PetType.dog:
        return AssetImage("");
      case PetType.cat:
        return AssetImage("");
      case PetType.fish:
        return AssetImage("");
      case PetType.bird:
        return AssetImage("");
    }
  }
}

// TODO: Adicionar name do gender com internacionalização
enum PetGender {
  male,
  female;

  String get name {
    switch (this) {
      case PetGender.male:
        return "Male";
      case PetGender.female:
        return "Female";
    }
  }
}

class Pet {
  late int id;
  String name;
  PetType type;
  String breed;
  DateTime birthdate;
  ImageProvider image;
  PetGender gender;

  Pet(this.name, this.type, this.breed, this.birthdate, this.gender,
      this.image) {
    id = Random().nextInt(10);
  }

  String get age {
    int ageInDays = DateTime.now().difference(birthdate).inDays;
    int ageInMonths = ageInDays ~/ 30;
    int ageInYears = ageInMonths ~/ 12;
    ageInMonths = ageInMonths - (12 * ageInYears);

    String ageAsString = "";

    if (ageInYears > 0) {
      ageAsString =
          AppLocalizationsManager.appLocalizations?.ageYears(ageInYears) ?? "";
    }
    if (ageInMonths > 0 || ageAsString.isEmpty) {
      String ageInMonthsAsString =
          AppLocalizationsManager.appLocalizations?.ageMonths(ageInMonths) ??
              "";

      if (ageAsString.isEmpty) {
        ageAsString = ageInMonthsAsString;
      } else {
        String connectiveAnd =
            AppLocalizationsManager.appLocalizations?.connectiveAnd ?? "";
        ageAsString = "$ageAsString $connectiveAnd $ageInMonthsAsString";
      }

      return ageAsString;
    }

    return ageAsString.trim();
  }
}
