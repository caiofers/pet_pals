import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(),
        Text("LOGIN"),
        Form(
            child: Column(
          children: [
            Wrap(
              runSpacing: 16,
              children: [
                TextField(),
                TextField(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Login"),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text("Esqueci a senha"),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text("Registrar"),
                    ),
                  ],
                )
              ],
            ),
          ],
        ))
      ],
    );
  }
}
