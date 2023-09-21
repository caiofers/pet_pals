import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_pals/extensions/time_of_day_extension.dart';
import 'package:pet_pals/models/alarm.dart';
import 'package:pet_pals/models/pet.dart';
import 'package:pet_pals/models/user.dart';
import 'package:pet_pals/repositories/alarms_repository.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddPetAlarmScreen extends StatefulWidget {
  const AddPetAlarmScreen({super.key, required this.alarm});

  final Alarm? alarm;

  @override
  State<AddPetAlarmScreen> createState() => _AddPetAlarmScreenState();
}

class _AddPetAlarmScreenState extends State<AddPetAlarmScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController alarmNameController = TextEditingController();
  final TextEditingController alarmTimeController = TextEditingController();
  final TextEditingController firstAlarmDateController =
      TextEditingController();

  Alarm? alarm;

  AlarmType alarmType = AlarmType.food;
  TimeOfDay alarmTime = TimeOfDay.now();
  AlarmRecurrence recurrence = AlarmRecurrence();

  DateFormat dateFormat =
      DateFormat(DateFormat.YEAR_MONTH_DAY, Platform.localeName);

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
      firstAlarmDateController.text =
          dateFormat.format(recurrence.firstAlarmDate);
    }
  }

  @override
  void dispose() {
    alarmNameController.dispose();
    alarmTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topSpacing =
        MediaQuery.of(context).padding.top + AppBar().preferredSize.height;
    final alarmsProvider = Provider.of<AlarmsRepository>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text("Adicionar alarme"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: topSpacing + 8, bottom: 8, left: 16, right: 16),
              child: Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 16,
                  children: [
                    TextFormField(
                      controller: alarmNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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
                        prefixIcon: Icon(Icons.abc),
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        hintText: "Enter with time for alarm",
                        labelText: "Alarm time",
                      ),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        TimeOfDay? alarmTime = await showTimePicker(
                            context: context, initialTime: this.alarmTime);

                        if (alarmTime != null) {
                          this.alarmTime = alarmTime;
                          alarmTimeController.text =
                              alarmTime.toStringByLocale();
                        }
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please, enter with the birthdate";
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Text("Alarm sound"),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Text("Pets para qual esse alarme tem que tocar"),
                    ),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Text("Tutores responsáveis"),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Text(
                          "Ativado e desativado - No card, não na tela de adicionar/editar"),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                top: 16,
                                bottom: 8,
                                left: 16,
                                right: 16,
                              ),
                              child: Column(
                                children: [
                                  Wrap(
                                    runSpacing: 16,
                                    children: [
                                      DropdownButtonFormField(
                                        value: recurrence.recurrenceType,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.abc),
                                          hintText: "Select type of recurrence",
                                          labelText: "Alarm recurrence",
                                        ),
                                        items: RecurrenceType.values
                                            .map((RecurrenceType value) {
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
                                            return "Please, select the type of alarm";
                                          }

                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: firstAlarmDateController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.abc),
                                          hintText: "Enter with alarm date",
                                          labelText: "Alarm date",
                                        ),
                                        onTap: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          DateTime? firstAlarmDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                firstAlarmDateController
                                                        .text.isEmpty
                                                    ? DateTime.now()
                                                    : recurrence.firstAlarmDate,
                                            firstDate: DateTime(1990),
                                            lastDate: DateTime(2100),
                                          );

                                          if (firstAlarmDate != null) {
                                            recurrence.firstAlarmDate =
                                                firstAlarmDate;
                                            firstAlarmDateController.text =
                                                dateFormat
                                                    .format(firstAlarmDate);
                                          }

                                          recurrence.updateRecurrenceType(
                                              RecurrenceType.monthly);
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            return "Please, enter with the alarm date";
                                          }

                                          return null;
                                        },
                                      ),
                                      ToggleButtons(
                                        borderRadius: BorderRadius.circular(5),
                                        children: [
                                          Text("Sun"),
                                          Text("Mon"),
                                          Text("Tue"),
                                          Text("Wed"),
                                          Text("Thu"),
                                          Text("Fri"),
                                          Text("Sat"),
                                        ],
                                        onPressed: (index) {
                                          setState(() {
                                            String day = recurrence
                                                .daysOfWeekSelection.keys
                                                .elementAt(index);
                                            recurrence.daysOfWeekSelection[
                                                day] = !(recurrence
                                                    .daysOfWeekSelection[day] ??
                                                false);
                                          });

                                          print(recurrence.daysOfWeekSelection);
                                        },
                                        isSelected: recurrence
                                            .daysOfWeekSelection.values
                                            .toList(),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Sair"),
                                      ),
                                      Text("teste"),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text("Alterar recorrência"),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (true) {
                            if (alarm == null) {
                              alarmsProvider.add(
                                Alarm(
                                  alarmNameController.text,
                                  alarmType,
                                  recurrence,
                                  alarmTime,
                                  [],
                                  [],
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Olá")),
                              );
                            } else {
                              alarmsProvider.update(
                                alarm!.id,
                                alarmNameController.text,
                                alarmType,
                                recurrence,
                                alarmTime,
                                [],
                                [],
                              );
                            }
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Save"),
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
