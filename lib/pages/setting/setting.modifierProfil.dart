// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_event.dart';
import 'package:flutterfirebase/bloc/user/user_state.dart';
import 'package:flutterfirebase/pages/authentication/authentication.signin.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';

class ModifierProfil extends StatefulWidget {
  String nom;
  String prenom;
  ModifierProfil({
    required this.nom,
    required this.prenom,
  });
  @override
  State<ModifierProfil> createState() => _ModifierProfilState();
}

class _ModifierProfilState extends State<ModifierProfil> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.nom != null && widget.prenom != null) {
      _nomcontroller.text = widget.nom;
      _prenomcontroller.text = widget.prenom;
    }
  }

  TextEditingController _nomcontroller = new TextEditingController();
  TextEditingController _prenomcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    void updateUser(String nom, String prenom) {
      BlocProvider.of<AuthBloc>(context).add(
        UserProfilUpdateRequested(nom: nom, prenom: prenom),
      );
    }

    return Scaffold(
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SlovitLogo(),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(UserProfilRequested());
                    },
                    icon: Icon(Icons.refresh,
                        color: state.themeData == MyTheme.darkTheme
                            ? Palette.yellow
                            : Palette.blue));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is UnAuthenticated) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SignIn()),
                      (route) => false,
                    );
                  }
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return Text(
                            "Modifier votre profile",
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
              ),
              SvgPicture.asset(
                "assets/images/user.svg",
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoadedUserProfilUpdate) {
                    BlocProvider.of<AuthBloc>(context)
                        .add(UserProfilRequested());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Profil mis à jour",
                        style: TextStyle(color: Palette.blue),
                      ),
                      backgroundColor: Palette.yellow,
                    ));
                    Navigator.of(context).pop();
                  }
                  if (state is ErrorUserProfilUpdate) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errormessage)));
                  }
                },
                builder: (context, state) {
                  print(state);
                  if (state is LodingUserProfilUpdate) {
                    return CircularProgressIndicator(color: Palette.yellow);
                  }
                  return Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.text,
                        controller: _nomcontroller,
                        decoration: const InputDecoration(
                          hintText: "Modifier le nom",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.text,
                        controller: _prenomcontroller,
                        decoration: const InputDecoration(
                          hintText: "Modifier le prénom",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      updateUser(_nomcontroller.text, _prenomcontroller.text);
                    },
                    child: Text(
                      'Modifier votre profile',
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
