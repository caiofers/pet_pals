import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/presentation/widgets/screens/home/home_screen.dart';
import 'package:pet_pals/presentation/widgets/screens/login/auth_check.dart';
import 'package:pet_pals/presentation/widgets/screens/profile/profile_screen.dart';
import 'package:pet_pals/presentation/widgets/screens/settings/settings_screen.dart';
import 'package:pet_pals/presentation/widgets/screens/alarm/alarm_list_screen.dart';
import 'package:pet_pals/presentation/widgets/screens/pet/pet_list_screen.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/resources/assets/assets_path.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool ignoreAuth = true;

  final List<Widget> _screens = const [
    HomeScreen(),
    PetListScreen(),
    AlarmListScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseAuthService authBloc = Provider.of<FirebaseAuthService>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Container(
          alignment: AlignmentDirectional.centerStart,
          child: Image(
            image: AssetImage('${AssetsPath.images}logo.png'),
            width: 180,
          ),
        ),
        centerTitle: false,
        actions: [
          if (authBloc.firebaseUser != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => const AuthCheck(
                      pageToOpen: ProfileScreen(),
                    ),
                  );
                },
                icon: Image.network(
                  authBloc.firebaseUser?.photoURL ?? "",
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                    );
                  },
                ),
                label: Text(authBloc.firebaseUser?.displayName ?? "-"),
              ),
            ),
          if (authBloc.firebaseUser == null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => const AuthCheck(pageToOpen: ProfileScreen()),
                  );
                },
                icon: const Icon(Icons.account_circle_rounded),
                label: Text(AppLocalizationsBloc.appLocalizations.loginText),
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
              icon: const Icon(Icons.home),
              label: AppLocalizationsBloc.appLocalizations.homePageLabel,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pets),
              label: AppLocalizationsBloc.appLocalizations.petsPageLabel,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: AppLocalizationsBloc.appLocalizations.alarmsPageLabel,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizationsBloc.appLocalizations.settingsPageLabel,
            ),
          ],
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(
              () {
                ignoreAuth = value == 0;
                _selectedIndex = value;
              },
            );
          },
        ),
      ),
      body: ignoreAuth
          ? _screens[_selectedIndex]
          : AuthCheck(
              showAsInternalPage: true,
              pageToOpen: _screens[_selectedIndex],
            ),
    );
  }
}
