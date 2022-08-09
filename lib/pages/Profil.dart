import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/user_bloc.dart';
import 'package:flutterfirebase/bloc/user_event.dart';
import 'package:flutterfirebase/bloc/user_state.dart';
import 'package:flutterfirebase/pages/Authentication/SignIn/signin.dart';
import 'package:flutterfirebase/pages/home.dart';
import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class Profil extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SlovitLogo(),
              Text(
                "Profil",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          'Email :',
                          style: const TextStyle(color: Color(0xFF121522)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${user.email}',
                          style: const TextStyle(color: Color(0xFF9E9E9E)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    leading: Icon(
                      Icons.alternate_email,
                      color: Palette.grey,
                    ),
                  ),
                  ListTile(
                    title: Text("Modifier mot de passe"),
                    leading: Icon(
                      Icons.password,
                      color: Palette.grey,
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
