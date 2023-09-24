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
