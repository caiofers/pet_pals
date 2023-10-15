import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/resources/assets/assets_path.dart';

// TODO: Adicionar name do type com internacionalização (+ diferenciação de gênero);
enum PetType {
  dog,
  cat,
  fish,
  bird;

  String get name {
    switch (this) {
      case PetType.dog:
        return AppLocalizationsBloc.appLocalizations.petTypeDog;
      case PetType.cat:
        return AppLocalizationsBloc.appLocalizations.petTypeCat;
      case PetType.fish:
        return AppLocalizationsBloc.appLocalizations.petTypeFish;
      case PetType.bird:
        return AppLocalizationsBloc.appLocalizations.petTypeBird;
    }
  }

  String get iconAssetName {
    switch (this) {
      case PetType.dog:
        return "${AssetsPath.images}dog.png";
      case PetType.cat:
        return "${AssetsPath.images}cat.png";
      case PetType.fish:
        return "${AssetsPath.images}fish.png";
      case PetType.bird:
        return "${AssetsPath.images}bird.png";
    }
  }
}
