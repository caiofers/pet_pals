import 'package:flutter/material.dart';
import 'package:pet_pals/data/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuthService authBloc = Provider.of<FirebaseAuthService>(context);
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: CircleAvatar(
                child: Image.network(
                  authBloc.firebaseUser?.photoURL ?? "",
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                    );
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authBloc.firebaseUser?.displayName ?? "No name",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  authBloc.firebaseUser?.email ?? "No email",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            )
          ],
        ),
        Divider(
          height: 1,
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.edit),
                    ),
                    Text("Editar perfil"),
                  ],
                ),
                onTap: () {
                  //TODO Edit profile
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.exit_to_app),
                    ),
                    Text("Logout"),
                  ],
                ),
                onTap: () {
                  authBloc.logout();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
