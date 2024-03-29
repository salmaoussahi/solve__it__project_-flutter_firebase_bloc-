import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfirebase/bloc/language/language_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPassword extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController _email = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(Icons.arrow_back,
                    color: state.themeData == MyTheme.darkTheme
                        ? Palette.yellow
                        : Palette.blue),
                onPressed: () => Navigator.of(context).pop(),
              );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: BlocBuilder<LanguageBloc, SelectedLangue>(
            builder: (context, languestate) {
              return Row(
                mainAxisAlignment: languestate.locale == Locale("ar", "")
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  SlovitLogo(),
                ],
              );
            },
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return Text(
                        AppLocalizations.of(context)!.modifier_mdp,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: state.themeData == MyTheme.darkTheme
                                ? Palette.yellow
                                : Palette.blue),
                      );
                    },
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
                        SvgPicture.asset("assets/images/ressetpassword.svg"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            onPressed: () {
                              try {
                                FirebaseAuth.instance.sendPasswordResetEmail(
                                    email: user.email.toString());

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  AppLocalizations.of(context)!.envoyer_dem_sub,
                                )));
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: Text(
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
      ),
    );
  }
}
