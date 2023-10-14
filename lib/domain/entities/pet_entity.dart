import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';

class Pet {
  String id;
  String name;
  PetType type;
  String breed;
  DateTime birthdate;
  String? imageUrl;
  PetGender gender;
  List<PetTutor> tutors;
  List<String> alarmIds;

  Pet(this.id, this.name, this.type, this.breed, this.birthdate, this.gender,
      this.imageUrl, this.tutors, this.alarmIds);

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
