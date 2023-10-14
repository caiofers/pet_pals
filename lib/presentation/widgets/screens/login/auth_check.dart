import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/presentation/widgets/screens/login/signin_screen.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck(
      {super.key, this.showAsInternalPage = false, required this.pageToOpen});

  final Widget pageToOpen;
  final bool showAsInternalPage;

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuthService auth = Provider.of<FirebaseAuthService>(context);
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    if (auth.isLoading) {
      return loading();
    } else if (auth.firebaseUser == null) {
      if (widget.showAsInternalPage) {
        return Padding(
          padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
          child: const SignInScreen(),
        );
      } else {
        return const SignInScreen();
      }
    } else {
      return widget.pageToOpen;
    }
  }

  loading() {
    return const CircularProgressIndicator();
  }
}
