import 'package:flutter/material.dart';
import 'package:pet_pals/domain/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';

class Pet {
  late String id;
  String name;
  PetType type;
  String breed;
  DateTime birthdate;
  ImageProvider image;
  PetGender gender;

  Pet(this.name, this.type, this.breed, this.birthdate, this.gender,
      this.image) {
    id = UniqueKey().toString();
  }

  String get age {
    int ageInDays = DateTime.now().difference(birthdate).inDays;
    int ageInMonths = ageInDays ~/ 30;
    int ageInYears = ageInMonths ~/ 12;
    ageInMonths = ageInMonths - (12 * ageInYears);

    String ageAsString = "";

    if (ageInYears > 0) {
      ageAsString =
          AppLocalizationsBloc.appLocalizations?.ageYears(ageInYears) ?? "";
    }
    if (ageInMonths > 0 || ageAsString.isEmpty) {
      String ageInMonthsAsString =
          AppLocalizationsBloc.appLocalizations?.ageMonths(ageInMonths) ?? "";

      if (ageAsString.isEmpty) {
        ageAsString = ageInMonthsAsString;
      } else {
        String connectiveAnd =
            AppLocalizationsBloc.appLocalizations?.connectiveAnd ?? "";
        ageAsString = "$ageAsString $connectiveAnd $ageInMonthsAsString";
      }

      return ageAsString;
    }

    return ageAsString.trim();
  }
}
