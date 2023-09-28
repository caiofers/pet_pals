import 'package:flutter/material.dart';
import 'package:pet_pals/presentation/bloc/theme_bloc.dart';
import 'package:pet_pals/domain/enums/theme_options_enum.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeBloc>(context);
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Icon(Icons.share),
            title: Text("Green Theme"),
            onTap: () {
              provider.theme = ThemeOptions.greenTheme;
              print(provider.currentThemeName);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Icon(Icons.share),
            title: Text("Default Theme"),
            onTap: () {
              provider.theme = ThemeOptions.defaultTheme;
              print(provider.currentThemeName);
            },
          )
        ],
      ),
    );
  }
}
