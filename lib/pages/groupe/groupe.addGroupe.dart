import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/groupe/goupe_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_event.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddGroupe extends StatefulWidget {
  AddGroupe({Key? key}) : super(key: key);

  @override
  State<AddGroupe> createState() => _AddGroupeState();
}

class _AddGroupeState extends State<AddGroupe> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _libelle = new TextEditingController();
    TextEditingController _domaine = new TextEditingController();
    void _addGroupe(BuildContext context) {
      BlocProvider.of<GoupeBloc>(context).add(
        AddGroupeRequested(
          domaine: _domaine.text,
          libelle: _libelle.text,
        ),
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
        child: BlocConsumer<GoupeBloc, GoupeState>(
          builder: (context, state) {
            if (state is LodingAddGroup) {
              return Center(
                  child: CircularProgressIndicator(
                color: Palette.yellow,
              ));
            }

            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return Text(
                           AppLocalizations.of(context)!.ajouter_grp,
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
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Form(
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            controller: _libelle,
                            decoration:  InputDecoration(
                              fillColor: Colors.grey,
                              hintText: AppLocalizations.of(context)!.libelle_grp,
                              border: OutlineInputBorder(),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            controller: _domaine,
                            decoration:  InputDecoration(
                              hintText: AppLocalizations.of(context)!.domaine_grp,
                              border: OutlineInputBorder(),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      _addGroupe(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.grp_scaff,
                          style: TextStyle(color: Palette.blue),
                        ),
                        backgroundColor: Palette.yellow,
                      ));
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.creer_grp),
                  ),
                )
              ],
            );
          },
          listener: (context, state) {
            if (state is LoadedAddGroup) {
              // Navigator.of(context).pop();
            }
            if (state is ErrorAddGroup) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errormessage)));
            }
          },
        ),
      ),
    );
  }
}
