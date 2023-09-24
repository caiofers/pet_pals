import 'package:pet_pals/domain/global_path.dart';

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
  String get iconAssetName {
    switch (this) {
      case PetType.dog:
        return "${GlobalPath.imageAssetPath}dog.png";
      case PetType.cat:
        return "${GlobalPath.imageAssetPath}dog.png";
      case PetType.fish:
        return "${GlobalPath.imageAssetPath}dog.png";
      case PetType.bird:
        return "${GlobalPath.imageAssetPath}dog.png";
    }
  }
}
