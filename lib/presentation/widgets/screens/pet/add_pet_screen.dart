import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/enums/pet_gender_enum.dart';
import 'package:pet_pals/domain/enums/pet_type_enum.dart';
import 'package:pet_pals/domain/enums/tutor_permissions_enum.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/resources/assets/assets_path.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/presentation/bloc/pets_bloc.dart';
import 'package:pet_pals/presentation/bloc/tutors_bloc.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key, required this.pet});

  final Pet? pet;

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  Pet? pet;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petBirthdateController = TextEditingController();
  DateTime petBirthdate = DateTime.now();
  PetType? petType;
  PetGender? petGender;
  File? image;

  bool isSaving = false;
  MaterialStatesController saveButtonStatesController =
      MaterialStatesController();

  DateFormat dateFormat =
      DateFormat(DateFormat.YEAR_MONTH_DAY, Platform.localeName);
  @override
  void initState() {
    super.initState();
    pet = widget.pet;
    if (pet != null) {
      petNameController.text = pet!.name;
      petBirthdateController.text = dateFormat.format(pet!.birthdate);
      petBirthdate = pet!.birthdate;
      petType = pet!.type;
      petGender = pet!.gender;
    }
  }

  @override
  void dispose() {
    petNameController.dispose();
    petBirthdateController.dispose();
    saveButtonStatesController.dispose();
    super.dispose();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizationsBloc
              .appLocalizations.formPetChangePetImageErrorText),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final topSpacing =
        MediaQuery.of(context).padding.top + AppBar().preferredSize.height;
    final petsBloc = Provider.of<PetsBloc>(context);
    final tutorsBloc = Provider.of<TutorsBloc>(context);
    final authBloc = Provider.of<FirebaseAuthService>(context);

    Image getPetImage() {
      if (image != null) {
        return Image.file(
          image!,
          fit: BoxFit.cover,
        );
      } else if (pet?.imageUrl?.isNotEmpty ?? false) {
        return Image.network(
          pet!.imageUrl ?? "",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "${AssetsPath.images}pet_img_placeholder.png",
              color: Colors.black54,
            );
          },
        );
      } else {
        return Image.asset(
          "${AssetsPath.images}pet_img_placeholder.png",
          color: Colors.black54,
        );
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Column(
                    children: [
                      Text(
                        pet == null
                            ? AppLocalizationsBloc
                                .appLocalizations.cancelAddingFormPetDialogTitle
                            : AppLocalizationsBloc.appLocalizations
                                .cancelEditingFormPetDialogTitle,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizationsBloc.appLocalizations
                              .cancelEditingFormPetDialogSubtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizationsBloc.appLocalizations
                          .cancelEditingFormPetDialogCancelButtonText),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizationsBloc.appLocalizations
                          .cancelEditingFormPetDialogContinueButtonText),
                    )
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(pet == null
            ? AppLocalizationsBloc.appLocalizations.addNewPetScreenTitle
            : AppLocalizationsBloc.appLocalizations.editPetScreenTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: topSpacing),
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  Center(child: getPetImage()),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(Icons.edit),
                        label: Text(AppLocalizationsBloc
                            .appLocalizations.formPetChangePetImageText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 16,
                  children: [
                    TextFormField(
                      controller: petNameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        hintText: AppLocalizationsBloc
                            .appLocalizations.formPetNameHintText,
                        labelText: AppLocalizationsBloc
                            .appLocalizations.formPetNameLabelText,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return AppLocalizationsBloc
                              .appLocalizations.formPetNameEmptyErrorText;
                        }

                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      value: petType,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          petType == null
                              ? Icons.check_box_outline_blank_rounded
                              : Icons.check_box_rounded,
                        ),
                        hintText: AppLocalizationsBloc
                            .appLocalizations.formPetTypeHintText,
                        labelText: AppLocalizationsBloc
                            .appLocalizations.formPetTypeLabelText,
                      ),
                      items: PetType.values.map((PetType value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Image.asset(
                                  value.iconAssetName,
                                  width: 16,
                                ),
                              ),
                              Text(value.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          petType = value;
                        }
                      },
                      validator: (value) {
                        if (value?.name.isEmpty ?? true) {
                          return AppLocalizationsBloc
                              .appLocalizations.formPetTypeEmptyErrorText;
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: petBirthdateController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        hintText: AppLocalizationsBloc
                            .appLocalizations.formPetBirthdateHintText,
                        labelText: AppLocalizationsBloc
                            .appLocalizations.formPetBirthdateLabelText,
                      ),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? birthdate = await showDatePicker(
                          context: context,
                          initialDate: petBirthdateController.text.isEmpty
                              ? DateTime.now()
                              : petBirthdate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (birthdate != null) {
                          petBirthdate = birthdate;
                          petBirthdateController.text =
                              dateFormat.format(birthdate);
                        }
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return AppLocalizationsBloc
                              .appLocalizations.formPetBirthdateEmptyErrorText;
                        }

                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      value: petGender,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          petGender == null
                              ? Icons.check_box_outline_blank_rounded
                              : Icons.check_box_rounded,
                        ),
                        hintText: AppLocalizationsBloc
                            .appLocalizations.formPetGenderHintText,
                        labelText: AppLocalizationsBloc
                            .appLocalizations.formPetGenderLabelText,
                      ),
                      items: PetGender.values.map((PetGender value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            petGender = value;
                          });
                        }
                      },
                      validator: (value) {
                        if (value?.name.isEmpty ?? true) {
                          return AppLocalizationsBloc
                              .appLocalizations.formPetGenderEmptyErrorText;
                        }

                        return null;
                      },
                    ),

                    TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizationsBloc
                                  .appLocalizations.unavailableFeat),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_circle_right_rounded),
                        label: Text(AppLocalizationsBloc
                            .appLocalizations.formPetBreedText))

                    //TODO Fazer uma página para selecionar raça (Buscar de uma API e mostrar nome com foto)
                  ],
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Text(pet == null
                                    ? AppLocalizationsBloc.appLocalizations
                                        .cancelAddingFormPetDialogTitle
                                    : AppLocalizationsBloc.appLocalizations
                                        .cancelEditingFormPetDialogTitle),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppLocalizationsBloc.appLocalizations
                                        .cancelEditingFormPetDialogSubtitle,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text(AppLocalizationsBloc
                                        .appLocalizations
                                        .cancelEditingFormPetDialogCancelButtonText),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(AppLocalizationsBloc
                                        .appLocalizations
                                        .cancelEditingFormPetDialogContinueButtonText),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.close),
                    label: Text(AppLocalizationsBloc
                        .appLocalizations.cancelFormPetActionText),
                  ),
                  ElevatedButton.icon(
                    statesController: saveButtonStatesController,
                    onPressed: () async {
                      setState(() {
                        isSaving = true;
                        saveButtonStatesController.update(
                            MaterialState.disabled, true);
                      });
                      try {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (pet == null) {
                            String? imageUrl;
                            if (image != null) {
                              imageUrl =
                                  await petsBloc.uploadImage(image?.path ?? "");
                            }
                            String petId = await petsBloc.add(
                              petNameController.text,
                              petType!,
                              "Undefined",
                              petBirthdate,
                              petGender!,
                              imageUrl,
                              [
                                PetTutor(
                                  authBloc.firebaseUser?.uid ?? "",
                                  authBloc.firebaseUser?.displayName ?? "",
                                  authBloc.firebaseUser?.photoURL,
                                  TutorPermissions.admin,
                                )
                              ],
                              [], //TODO: Add alarmIds
                            );

                            await tutorsBloc.addPetToTutor(
                                authBloc.firebaseUser?.uid ?? "", petId);
                          } else {
                            String? imageUrl = pet!.imageUrl;
                            if (image != null) {
                              imageUrl =
                                  await petsBloc.uploadImage(image?.path ?? "");
                            }
                            await petsBloc.update(
                              pet!.id,
                              petNameController.text,
                              petType!,
                              "Undefined",
                              petBirthdate,
                              petGender!,
                              imageUrl,
                              pet!.tutors,
                              pet!.alarmIds,
                            );
                          }

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizationsBloc
                                  .appLocalizations.formSaveSucessText),
                            ),
                          );
                        } else {
                          setState(() {
                            isSaving = false;
                            saveButtonStatesController.update(
                                MaterialState.disabled, false);
                          });
                        }
                      } catch (e) {
                        setState(() {
                          isSaving = false;
                          saveButtonStatesController.update(
                              MaterialState.disabled, false);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizationsBloc
                                .appLocalizations.formSaveErrorText),
                          ),
                        );
                      }
                    },
                    icon: isSaving
                        ? Center(
                            child: Container(
                                height: 16,
                                width: 16,
                                margin: EdgeInsets.only(right: 8),
                                child: CircularProgressIndicator()),
                          )
                        : Icon(Icons.save),
                    label: Text(AppLocalizationsBloc
                        .appLocalizations.saveFormPetActionText),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
