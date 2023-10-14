import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/firebase_options.dart';
import 'package:pet_pals/init.dart';
import 'package:pet_pals/main_page.dart';
import 'package:pet_pals/presentation/bloc/alarms_bloc.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/presentation/bloc/pets_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pet_pals/presentation/bloc/theme_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthService>(
          create: (context) => FirebaseAuthService(),
        ), //TODO Passar para clean code + bloc
        ChangeNotifierProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        ChangeNotifierProvider<PetsBloc>(
          create: (context) => PetsBloc(),
        ),
        ChangeNotifierProvider<AlarmsBloc>(
          create: (context) => AlarmsBloc(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

initializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future _initFuture(BuildContext context) async {
    await Init.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = Provider.of<ThemeBloc>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeBloc.currentTheme,
      darkTheme: themeBloc.currentDarkTheme,
      themeMode: ThemeMode.system,
      home: const MainPage(),
      // FutureBuilder(
      //   future: _initFuture(context),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return const MyHomePage();
      //     } else {
      //       AppLocalizationsManager(context);
      //       //TODO: Criar SplashScreen
      //       return const Text("SplashScreen");
      //     }
      //   },
      // ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        AppLocalizationsBloc.init(context);
        return AppLocalizationsBloc.appLocalizations?.appTitle ?? "";
      },
    );
  }
}
