import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_event.dart';
import 'package:flutterfirebase/bloc/user/user_state.dart';
import 'package:flutterfirebase/pages/Authentication/SignIn/signin.dart';
import 'package:flutterfirebase/pages/home.dart';
import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class Logout extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
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
            Column(children: [
              Text(
              '${user.email}',
              style: const TextStyle(fontSize: 24,color:Color(0xFFFDD037)),
              textAlign: TextAlign.center,
            ),
            Text(
              'Voulez-vous vous déconnecter ?',
              style: const TextStyle(fontSize: 20,color: Colors.grey),
              textAlign: TextAlign.center,
              
            ),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Palette.blue
                  ),
                  child: const Text('Oui',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    // Signing out the user
                    context.read<AuthBloc>().add(SignOutRequested());
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Palette.yellow
                  ),
                  child: const Text('Non',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
