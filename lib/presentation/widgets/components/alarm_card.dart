import 'package:flutter/material.dart';
import 'package:pet_pals/domain/extensions/time_of_day_extension.dart';
import 'package:pet_pals/domain/entities/alarm_entity.dart';
import 'package:pet_pals/presentation/bloc/alarms_bloc.dart';
import 'package:provider/provider.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key, required this.alarm, required this.onCardTap});
  final Alarm alarm;
  final Function onCardTap;

  @override
  Widget build(BuildContext context) {
    final alarmsProvider = Provider.of<AlarmsBloc>(context);
    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () {
          onCardTap();
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8, left: 16, right: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alarm.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Row(
                          children: [
                            Text(alarm.type.name),
                            Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  color: Colors.amber,
                                  child: const Icon(
                                    size: 20,
                                    Icons.pets,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: alarm.enabled,
                    onChanged: (enabled) {
                      alarmsProvider.switchAlarmOnOff(alarm.id, enabled);
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              indent: 16,
              endIndent: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Row(
                children: [
                  Container(margin: const EdgeInsets.only(right: 8), child: const Icon(Icons.alarm)),
                  Text(
                    alarm.time.toStringByLocale(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.only(right: 0),
                        child: const CircleAvatar(
                          backgroundColor: Colors.red,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.only(right: 24),
                        child: const CircleAvatar(
                          backgroundColor: Colors.amber,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 48),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 72),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 96),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 120),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ],
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
