import 'package:flutter/material.dart';
import 'package:pet_pals/models/alarm.dart';
import 'package:pet_pals/presentation/screens/add_pet_alarm_screen.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key, required this.alarm});
  final Alarm alarm;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddPetAlarmScreen(
                alarm: alarm,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 8, left: 16, right: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alarm.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Row(
                          children: [Text(alarm.type.name)],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.amber,
                          child: const Icon(Icons.pets)),
                    ),
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
                  Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: const Icon(Icons.alarm)),
                  Text(
                    alarm.time.format(context),
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
                        margin: EdgeInsets.only(right: 0),
                        child: CircleAvatar(
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
                        margin: EdgeInsets.only(right: 24),
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 48),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 72),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 96),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 120),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
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
