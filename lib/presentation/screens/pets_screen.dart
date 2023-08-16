import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            "Curiosidade do dia - Cachorro",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          color: Colors.red,
          child: Container(
            //margin: EdgeInsets.symmetric(horizontal: 8),
            height: 250,
            child: Center(
                child: Text(AppLocalizations.of(context)!.helloUser("Caio"))),
          ),
        ),
        Card(
          child: Container(
            //margin: EdgeInsets.symmetric(horizontal: 8),
            height: 250,
            child: Center(child: Text("Test")),
          ),
        ),
        Container(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Card(
                color: Colors.red,
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 300,
                  child: Center(child: Text("Test")),
                ),
              ),
              Card(
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 300,
                  child: Center(child: Text("Test")),
                ),
              ),
              Card(
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 300,
                  child: Center(child: Text("Test")),
                ),
              ),
              Card(
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 300,
                  child: Center(child: Text("Test")),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
