import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:pet_pals/domain/global_path.dart';
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

  String get authHeaderText {
    if (isLogin) {
      return "Login";
    } else {
      return "Registrar";
    }
  }

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
                "${GlobalPath.imageAssetPath}logoofc1.png",
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      width: double.infinity,
                      child: Text(authHeaderText),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: isLogin
                            ? loginForm(authBloc)
                            : registerForm(authBloc))
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
              ElevatedButton(
                onPressed: () {
                  if (isLogin) {
                    if (_loginFormKey.currentState?.validate() ?? false) {
                      try {
                        authBloc.loginEmailPassword(
                          emailController.text,
                          passwordController.text,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Falhou"),
                          ),
                        );
                      }
                    }
                  } else {
                    if (_registerFormKey.currentState?.validate() ?? false) {
                      try {
                        authBloc.registerEmailPassword(
                          nameController.text,
                          null, //TODO upload profile image
                          emailController.text,
                          passwordController.text,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Falhou"),
                          ),
                        );
                      }
                    }
                  }
                },
                child: isLogin ? Text("Login") : Text("Register"),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("Esqueci a senha"),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: isLogin
                        ? Text("Não tem conta? Registre-se")
                        : Text("Voltar para login"),
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
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Enter with email",
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Please, enter with an email";
                  }
                  // TODO Email validator
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Enter with password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Please, enter with a password";
                    } else if (value.length < 6) {
                      return "Please, enter with an valid password (at least 6 characteres)";
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
                  prefixIcon: Icon(Icons.abc),
                  hintText: "Enter with name",
                  labelText: "Name",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Please, enter with a name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Enter with email",
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Please, enter with an email";
                  }
                  // TODO Email validator
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Enter with password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Please, enter with a password";
                    } else if (value.length < 6) {
                      return "Please, enter with an valid password (at least 6 characteres)";
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
