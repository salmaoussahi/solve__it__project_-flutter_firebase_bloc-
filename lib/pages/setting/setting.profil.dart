import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/language/language_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_event.dart';
import 'package:flutterfirebase/bloc/user/user_state.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/authentication/authentication.signin.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutterfirebase/pages/setting/setting.modifierProfil.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(UserProfilRequested());
  }

  @override
  Widget build(BuildContext context) {
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
        title: BlocBuilder<LanguageBloc, SelectedLangue>(
          builder: (context, languestate) {
            return languestate.locale == Locale("ar", "")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      SlovitLogo(),
                    ],
                  )
                : Row(
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
                  );
          },
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
                            AppLocalizations.of(context)!.titre_setting,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      print(state);
                      if (state is LodingUserProfil) {
                        return CircularProgressIndicator(
                          color: Palette.yellow,
                        );
                      }
                      if (state is LoadedUserProfil) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: state.profil,
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return Text("Document does not exist");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  ListTile(
                                    title: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                    .email +
                                                " :",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '${data['email']}',
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.person,
                                      color: Palette.yellow,
                                    ),
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.nom +
                                              " :",
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          '${data['last_name']}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    leading: Icon(
                                      Icons.person,
                                      color: Palette.yellow,
                                    ),
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.prenom +
                                              " :",
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          '${data['first_name']}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    leading: Icon(
                                      Icons.person,
                                      color: Palette.yellow,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      ModifierProfil(
                                                          nom:
                                                              data['last_name'],
                                                          prenom: data[
                                                              'first_name']))));
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .modifier_prof,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Text("");
                          },
                        );
                      }

                      return Text("cfcfcfcc");
                    },
                  ),
                ],
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
