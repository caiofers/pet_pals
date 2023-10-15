// TODO: Adicionar name do gender com internacionalização
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';

enum PetGender {
  male,
  female;

  String get name {
    switch (this) {
      case PetGender.male:
        return AppLocalizationsBloc.appLocalizations.petGenderMale;
      case PetGender.female:
        return AppLocalizationsBloc.appLocalizations.petGenderFemale;
    }
  }
}
