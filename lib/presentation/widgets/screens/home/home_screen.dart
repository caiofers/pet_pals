import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            "Curiosidade do dia - Cachorro",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          color: Colors.red,
          child: SizedBox(
            //margin: EdgeInsets.symmetric(horizontal: 8),
            height: 250,
            child: Center(child: Text(AppLocalizations.of(context)!.helloUser("Caio"))),
          ),
        ),
        const Card(
          child: SizedBox(
            //margin: EdgeInsets.symmetric(horizontal: 8),
            height: 250,
            child: Center(child: Text("Test")),
          ),
        ),
        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              Card(
                color: Colors.red,
                child: SizedBox(
                  //margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 300,
                  child: Center(child: Text("Test")),
                ),
              ),
              Card(
                child: SizedBox(
                  //margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 300,
                  child: Center(child: Text("Test")),
                ),
              ),
              Card(
                child: SizedBox(
                  //margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 300,
                  child: Center(child: Text("Test")),
                ),
              ),
              Card(
                child: SizedBox(
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
