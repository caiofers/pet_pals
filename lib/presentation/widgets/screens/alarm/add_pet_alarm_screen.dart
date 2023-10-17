import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_ends_enum.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_monthly_repetition_enum.dart';
import 'package:pet_pals/domain/enums/alarm_recurrence_type_enum.dart';
import 'package:pet_pals/domain/enums/alarm_type_enum.dart';
import 'package:pet_pals/domain/extensions/time_of_day_extension.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/domain/entities/alarm_recurrence_entity.dart';
import 'package:pet_pals/presentation/bloc/alarms_bloc.dart';
import 'package:pet_pals/presentation/widgets/components/tutor_pic.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddPetAlarmScreen extends StatefulWidget {
  const AddPetAlarmScreen({super.key, required this.pet, required this.alarm});

  final Pet pet;
  final Alarm? alarm;

  @override
  State<AddPetAlarmScreen> createState() => _AddPetAlarmScreenState();
}

class _AddPetAlarmScreenState extends State<AddPetAlarmScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController alarmNameController = TextEditingController();
  final TextEditingController alarmTimeController = TextEditingController();
  final TextEditingController firstAlarmDateController = TextEditingController();
  final TextEditingController alarmRecurrenceAmountOfTimeController = TextEditingController();

  Alarm? alarm;

  AlarmType? alarmType;
  TimeOfDay alarmTime = TimeOfDay.now();
  AlarmRecurrence recurrence = AlarmRecurrence(
    AlarmRecurrenceType.never,
    1,
    AlarmRecurrenceEnds.doNotEnd,
    0,
    {
      "sunday": false,
      "monday": false,
      "tuesday": false,
      "wednesday": false,
      "thursday": false,
      "friday": false,
      "saturday": false,
    },
    AlarmRecurrenceMonthlyRepetition.sameDayEachMonth,
    DateTime.now(),
    [],
  );

  DateFormat dateFormat = DateFormat(DateFormat.YEAR_MONTH_DAY, Platform.localeName);

  Map<PetTutor, bool> tutorsSelection = {};

  Map<PetTutor, bool> getPreviousTutorsSelection() {
    Map<PetTutor, bool> selection = {};
    for (var e in widget.pet.tutors) {
      selection.addAll({e: widget.alarm?.tutorIds.contains(e.id) ?? false});
    }
    return selection;
  }

  bool isSaving = false;
  MaterialStatesController saveButtonStatesController = MaterialStatesController();

  @override
  void initState() {
    super.initState();
    alarm = widget.alarm;
    if (alarm != null) {
      alarmNameController.text = alarm!.name;
      alarmType = alarm!.type;
      alarmTimeController.text = alarm!.time.toStringByLocale();
      alarmTime = alarm!.time;
      recurrence = alarm!.recurrence;
      firstAlarmDateController.text = dateFormat.format(recurrence.firstAlarmDate);
    }
    tutorsSelection = getPreviousTutorsSelection();
    saveButtonStatesController.update(
      MaterialState.disabled,
      !tutorsSelection.values.contains(true),
    );
  }

  @override
  void dispose() {
    alarmNameController.dispose();
    alarmTimeController.dispose();
    firstAlarmDateController.dispose();
    alarmRecurrenceAmountOfTimeController.dispose();
    saveButtonStatesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topSpacing = MediaQuery.of(context).padding.top + AppBar().preferredSize.height;
    final alarmsProvider = Provider.of<AlarmsBloc>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text("Adicionar alarme"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: topSpacing + 8, bottom: 8, left: 16, right: 16),
              child: Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 16,
                  children: [
                    TextFormField(
                      controller: alarmNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Enter with alarm name",
                        labelText: "Alarm name",
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please, enter with a name";
                        }

                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      value: alarmType,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          alarmType == null ? Icons.check_box_outline_blank_rounded : Icons.check_box_rounded,
                        ),
                        hintText: "Select type of alarm",
                        labelText: "Alarm type",
                      ),
                      items: AlarmType.values.map((AlarmType value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          alarmType = value;
                        }
                      },
                      validator: (value) {
                        if (value?.name.isEmpty ?? true) {
                          return "Please, select the type of alarm";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: alarmTimeController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.alarm),
                        hintText: "Enter with time for alarm",
                        labelText: "Alarm time",
                      ),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        TimeOfDay? alarmTime = await showTimePicker(context: context, initialTime: this.alarmTime);

                        if (alarmTime != null) {
                          this.alarmTime = alarmTime;
                          alarmTimeController.text = alarmTime.toStringByLocale();
                        }
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please, enter with the time";
                        }

                        return null;
                      },
                    ),
                    Column(
                      children: [
                        Wrap(
                          runSpacing: 16,
                          children: [
                            DropdownButtonFormField(
                              value: recurrence.recurrenceType,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.refresh),
                                hintText: "Select type of recurrence",
                                labelText: "Alarm recurrence",
                              ),
                              items: AlarmRecurrenceType.values.map((AlarmRecurrenceType value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  recurrence.recurrenceType = value;
                                }
                              },
                              validator: (value) {
                                if (value?.name.isEmpty ?? true) {
                                  return "Please, select the type of recurrence";
                                }

                                return null;
                              },
                            ),
                            Visibility(
                              visible: recurrence.recurrenceType == AlarmRecurrenceType.monthly ||
                                  recurrence.recurrenceType == AlarmRecurrenceType.annualy,
                              child: TextFormField(
                                controller: firstAlarmDateController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month),
                                  hintText: "Enter with alarm date",
                                  labelText: "Alarm date",
                                ),
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  DateTime? firstAlarmDate = await showDatePicker(
                                    context: context,
                                    initialDate: firstAlarmDateController.text.isEmpty
                                        ? DateTime.now()
                                        : recurrence.firstAlarmDate,
                                    firstDate: DateTime(1990),
                                    lastDate: DateTime(2100),
                                  );

                                  if (firstAlarmDate != null) {
                                    recurrence.firstAlarmDate = firstAlarmDate;
                                    firstAlarmDateController.text = dateFormat.format(firstAlarmDate);
                                  }
                                },
                                validator: (value) {
                                  if (recurrence.recurrenceType == AlarmRecurrenceType.monthly ||
                                      recurrence.recurrenceType == AlarmRecurrenceType.annualy) {
                                    if (value?.isEmpty ?? true) {
                                      return "Please, enter with the alarm date";
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                            Visibility(
                              visible: recurrence.recurrenceType == AlarmRecurrenceType.weekly,
                              child: Center(
                                child: ToggleButtons(
                                  borderRadius: BorderRadius.circular(5),
                                  onPressed: (index) {
                                    setState(() {
                                      String day = recurrence.daysOfWeekSelection.keys.elementAt(index);
                                      recurrence.daysOfWeekSelection[day] =
                                          !(recurrence.daysOfWeekSelection[day] ?? false);
                                    });
                                  },
                                  isSelected: recurrence.daysOfWeekSelection.values.toList(),
                                  children: const [
                                    Text("Sun"),
                                    Text("Mon"),
                                    Text("Tue"),
                                    Text("Wed"),
                                    Text("Thu"),
                                    Text("Fri"),
                                    Text("Sat"),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: recurrence.recurrenceType != AlarmRecurrenceType.never,
                              child: TextFormField(
                                controller: alarmRecurrenceAmountOfTimeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                  prefixIcon: Icon(Icons.numbers),
                                  hintText: "Enter with number",
                                  labelText: "Every",
                                ),
                                validator: (value) {
                                  if (recurrence.recurrenceType != AlarmRecurrenceType.never) {
                                    if (value?.isEmpty ?? true) {
                                      return "Please, enter with a number";
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Selecione o(s) tutor(es) responsáveis:"),
                        ),
                        Container(
                          height: 80,
                          width: double.infinity,
                          alignment: Alignment.topLeft,
                          child: GridView.count(
                            mainAxisSpacing: 8,
                            crossAxisCount: 1,
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var tutorEntry in tutorsSelection.entries)
                                Stack(
                                  children: [
                                    TutorPic(
                                      tutorId: tutorEntry.key.id,
                                      tutorName: tutorEntry.key.name,
                                      tutorAvatarUrl: tutorEntry.key.avatarUrl,
                                      onTap: () {
                                        setState(() {
                                          tutorsSelection[tutorEntry.key] = !tutorEntry.value;
                                          saveButtonStatesController.update(
                                            MaterialState.disabled,
                                            !tutorsSelection.values.contains(true),
                                          );
                                        });
                                      },
                                    ),
                                    if (tutorEntry.value)
                                      IgnorePointer(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: Container(
                                                color: Colors.white,
                                                child: const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                )),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        if (!tutorsSelection.values.contains(true))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Você deve selecionar pelo menos 1 tutor",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        statesController: saveButtonStatesController,
                        onPressed: () {
                          List<String> assignedTutorIds =
                              tutorsSelection.entries.where((element) => element.value).map((e) => e.key.id).toList();
                          if ((_formKey.currentState?.validate() ?? false) && assignedTutorIds.isNotEmpty) {
                            try {
                              if (alarm == null) {
                                alarmsProvider.add(
                                  alarmNameController.text,
                                  alarmType!,
                                  recurrence,
                                  alarmTime,
                                  true,
                                  widget.pet.id,
                                  assignedTutorIds,
                                );
                              } else {
                                alarmsProvider.update(
                                  alarm!.id,
                                  alarmNameController.text,
                                  alarmType!,
                                  recurrence,
                                  alarmTime,
                                  alarm!.enabled,
                                  widget.pet.id,
                                  assignedTutorIds,
                                );
                              }

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Alarme adicionado com sucesso")),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Ocorreu um erro, confira os campos e sua conexão com a internet"),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text("Salvar"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
