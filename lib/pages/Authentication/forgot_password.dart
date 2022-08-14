import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfirebase/pages/Accueil/plus_detail.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';

import '../widget/solvit.logo.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController _email = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                SlovitLogo(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Modifier le mot de passe",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _email,
                          decoration: const InputDecoration(
                            hintText: "Entrer votre email",
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value != null &&
                                    !EmailValidator.validate(value)
                                ? 'Enter a valid email'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Palette.yellow),
                            onPressed: () {
                              try {
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: _email.text);

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Un email a été envoyé pour modifier votre mot de passe vueillez vérifier')));
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
