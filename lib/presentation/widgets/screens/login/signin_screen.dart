import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/resources/assets/assets_path.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;
  MaterialStatesController loginButtonStatesController = MaterialStatesController();
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<FirebaseAuthService>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Image.asset(
                "${AssetsPath.images}logo.png",
                width: 150,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      width: double.infinity,
                      child: Text(
                        isLogin
                            ? AppLocalizationsBloc.appLocalizations.loginText
                            : AppLocalizationsBloc.appLocalizations.createAccountText,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: isLogin ? loginForm(authBloc) : registerForm(authBloc))
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Column(
            children: [
              ElevatedButton.icon(
                statesController: loginButtonStatesController,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                    loginButtonStatesController.update(MaterialState.disabled, true);
                  });
                  if (isLogin) {
                    if (_loginFormKey.currentState?.validate() ?? false) {
                      try {
                        await authBloc.loginEmailPassword(
                          emailController.text,
                          passwordController.text,
                        );
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                          loginButtonStatesController.update(MaterialState.disabled, false);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizationsBloc.appLocalizations.formSaveErrorText),
                          ),
                        );
                      }
                    } else {
                      setState(() {
                        isLoading = false;
                        loginButtonStatesController.update(MaterialState.disabled, false);
                      });
                    }
                  } else {
                    if (_registerFormKey.currentState?.validate() ?? false) {
                      try {
                        await authBloc.registerEmailPassword(
                          nameController.text,
                          null, //TODO upload profile image
                          emailController.text,
                          passwordController.text,
                        );
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                          loginButtonStatesController.update(MaterialState.disabled, false);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizationsBloc.appLocalizations.formSaveErrorText),
                          ),
                        );
                      }
                    } else {
                      setState(() {
                        isLoading = false;
                        loginButtonStatesController.update(MaterialState.disabled, false);
                      });
                    }
                  }
                },
                icon: isLoading
                    ? Center(
                        child: Container(
                            height: 16,
                            width: 16,
                            margin: const EdgeInsets.only(right: 8),
                            child: const CircularProgressIndicator()),
                      )
                    : const Icon(Icons.login_rounded),
                label: Text(
                  isLogin
                      ? AppLocalizationsBloc.appLocalizations.loginText
                      : AppLocalizationsBloc.appLocalizations.createAccountText,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(AppLocalizationsBloc.appLocalizations.forgotPasswordButtonText),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin
                          ? AppLocalizationsBloc.appLocalizations.changeToRegisterButtonText
                          : AppLocalizationsBloc.appLocalizations.changeToLoginButtonText,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Form loginForm(FirebaseAuthService authBloc) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          Wrap(
            runSpacing: 16,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: AppLocalizationsBloc.appLocalizations.formLoginEmailHintText,
                  labelText: AppLocalizationsBloc.appLocalizations.formLoginEmailLabelText,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return AppLocalizationsBloc.appLocalizations.formLoginEmailEmptyErrorText;
                  }
                  // TODO Email validator
                  // AppLocalizationsBloc.appLocalizations.formLoginEmailInvalidErrorText;
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: AppLocalizationsBloc.appLocalizations.formLoginPasswordHintText,
                  labelText: AppLocalizationsBloc.appLocalizations.formLoginPasswordLabelText,
                ),
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return AppLocalizationsBloc.appLocalizations.formLoginPasswordEmptyErrorText;
                    }
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form registerForm(FirebaseAuthService authBloc) {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          Wrap(
            runSpacing: 16,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.abc),
                  hintText: AppLocalizationsBloc.appLocalizations.formLoginNameHintText,
                  labelText: AppLocalizationsBloc.appLocalizations.formLoginNameLabelText,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return AppLocalizationsBloc.appLocalizations.formLoginNameEmptyErrorText;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: AppLocalizationsBloc.appLocalizations.formLoginEmailHintText,
                  labelText: AppLocalizationsBloc.appLocalizations.formLoginEmailLabelText,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return AppLocalizationsBloc.appLocalizations.formLoginEmailEmptyErrorText;
                  }
                  // TODO Email validator
                  // AppLocalizationsBloc.appLocalizations.formLoginEmailInvalidErrorText;
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: AppLocalizationsBloc.appLocalizations.formLoginPasswordHintText,
                  labelText: AppLocalizationsBloc.appLocalizations.formLoginPasswordLabelText,
                ),
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return AppLocalizationsBloc.appLocalizations.formLoginPasswordEmptyErrorText;
                    } else if (value.length < 6) {
                      return AppLocalizationsBloc.appLocalizations.formLoginPasswordInvalidErrorText;
                    }
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
