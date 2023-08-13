import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Icon(Icons.share),
          title: Text("Compartilhar"),
          onTap: () {
            print("Compartilhar");
          },
        )
      ],
    );
  }
}
