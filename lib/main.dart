import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_pals/presentation/screens/home_screen.dart';
import 'package:pet_pals/presentation/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetPals',
      theme: ThemeData(
        fontFamily: "Manrope",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(180, 95, 6, 1),
          background: Color.fromRGBO(245, 232, 216, 1),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
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
    HomeScreen(),
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
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
          backgroundColor: Color.fromRGBO(245, 232, 216, 0.95),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 4),
          color: Color.fromRGBO(245, 232, 216, 0.4),
          child: Container(
            padding: const EdgeInsets.only(top: 6),
            color: Color.fromRGBO(245, 232, 216, 1),
            child: BottomNavigationBar(
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
                    label:
                        AppLocalizations.of(context)!.notificationsPageLabel),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: AppLocalizations.of(context)!.settingsPageLabel),
              ],
              //backgroundColor: Color.fromRGBO(245, 232, 216, 1),
              //selectedItemColor: Theme.of(context).colorScheme.primary,
              selectedItemColor: Color.fromRGBO(56, 118, 29, 1),
              unselectedItemColor: Theme.of(context).colorScheme.secondary,
              currentIndex: _selectedIndex,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
            ),
          ),
        ),
        body: _screens[_selectedIndex]);
  }
}
