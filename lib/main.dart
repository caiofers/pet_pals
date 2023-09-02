import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_pals/init.dart';
import 'package:pet_pals/l10n/app_localizations_manager.dart';
import 'package:pet_pals/presentation/screens/notifications_screen.dart';
import 'package:pet_pals/presentation/screens/pets_screen.dart';
import 'package:pet_pals/repositories/pets_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_pals/presentation/screens/home_screen.dart';
import 'package:pet_pals/presentation/screens/settings_screen.dart';
import 'package:pet_pals/presentation/themes/theme_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeDataManager>(
            create: (context) => ThemeDataManager()),
        ChangeNotifierProvider<PetsRepository>(
            create: (context) => PetsRepository()),
      ],
      child: const InitializationApp(),
    ),
  );
}

class InitializationApp extends StatelessWidget {
  const InitializationApp({super.key});

  Future _initFuture(BuildContext context) async {
    await Init.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeDataManager>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: provider.currentTheme,
      darkTheme: provider.currentDarkTheme,
      themeMode: ThemeMode.system,
      home: FutureBuilder(
        future: _initFuture(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const MyHomePage();
          } else {
            AppLocalizationsManager(context);
            //TODO: Criar SplashScreen
            return const Text("SplashScreen");
          }
        },
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        return AppLocalizationsManager.appLocalizations?.appTitle ?? "";
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    PetsScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Container(
              alignment: AlignmentDirectional.centerStart,
              child: Image(
                image: AssetImage('lib/assets/images/logoofc1.png'),
                width: 180,
              )),
          centerTitle: false,
          actions: [
            SizedBox(
              width: 50,
              child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.account_circle_rounded),
                onPressed: () {
                  if (kDebugMode) {
                    print("Abrir login");
                  }
                },
              ),
            )
          ],
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 8),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: AppLocalizations.of(context)!.homePageLabel),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pets),
                  label: AppLocalizations.of(context)!.petsPageLabel),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: AppLocalizations.of(context)!.notificationsPageLabel),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.settingsPageLabel),
            ],
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            selectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
          ),
        ),
        body: _screens[_selectedIndex]);
  }
}
