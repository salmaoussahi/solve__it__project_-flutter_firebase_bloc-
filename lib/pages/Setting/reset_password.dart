import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfirebase/pages/Accueil/plus_detail.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';
import 'package:flutterfirebase/pages/widget/solvit.logo.dart';

class ResetPassword extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController _email = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlovitLogo(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Modifier mot de passe",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            
            
            SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/ressetpassword.svg"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Palette.yellow),
                            onPressed: () {
                              try {
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: user.email.toString());
                               
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Un email a été envoyé pour modifier votre mot de passe vueillez vérifier')));
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: const Text(
                              'Envoyer demande',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
