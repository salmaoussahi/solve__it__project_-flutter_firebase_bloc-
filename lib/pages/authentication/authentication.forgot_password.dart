import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController _email = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SlovitLogo(),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.modifier_mdp,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              
              children: [
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
                              cursorColor: Colors.grey,
                              keyboardType: TextInputType.emailAddress,
                              controller: _email,
                              decoration:  InputDecoration(
                                hintText: AppLocalizations.of(context)!.email_hint,
                                border: OutlineInputBorder(),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return value != null &&
                                        !EmailValidator.validate(value)
                                    ? AppLocalizations.of(context)!.valid_email
                                    : null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ElevatedButton(
                              
                                onPressed: () {
                                  try {
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: _email.text);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                AppLocalizations.of(context)!.envoyer_dem_sub)));
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child:  Text(
                                  AppLocalizations.of(context)!.envoyer_dem,
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
            SizedBox(height: 10,)
          ],
        ),
        
      ),
    );
  }
}
