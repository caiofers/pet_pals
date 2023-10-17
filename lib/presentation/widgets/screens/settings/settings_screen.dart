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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const Icon(Icons.share),
            title: const Text("Green Theme"),
            onTap: () {
              provider.theme = ThemeOptions.greenTheme;
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const Icon(Icons.share),
            title: const Text("Default Theme"),
            onTap: () {
              provider.theme = ThemeOptions.defaultTheme;
            },
          )
        ],
      ),
    );
  }
}
