import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/groupe/goupe_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';

import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutterfirebase/pages/problem/problem.groupProblem.dart';

class UserGroupe extends StatefulWidget {
  const UserGroupe({Key? key}) : super(key: key);

  @override
  State<UserGroupe> createState() => _UserGroupeState();
}

class _UserGroupeState extends State<UserGroupe> {
  void _userProblem(context) {
    BlocProvider.of<GoupeBloc>(context).add(UserGroupeRequested());
  }

  @override
  // ignore: must_call_super
  void initState() {
    _userProblem(context);
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SlovitLogo(),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        _userProblem(context);
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
        body: Column(
          children: [
            Flexible(
              child: BlocBuilder<GoupeBloc, GoupeState>(
                  builder: ((context, state) {
                print(state);

                if (state is LodingUserGroupe) {
                  return CircularProgressIndicator(
                    color: Palette.yellow,
                  );
                }
                if (state is ErrorUserGroupe) {
                  return Text(AppLocalizations.of(context)!.error + state.errormessage);
                }
                if (state is LoadedUserGroupe) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: state.groupes,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text(AppLocalizations.of(context)!.error);
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Palette.yellow,
                          ));
                        }
                        final data = snapshot.requireData;

                        return data.size == 0
                            ? Column(
                                children: [
                                  SvgPicture.asset("assets/images/nodata.svg"),
                                  Text(
                                    AppLocalizations.of(context)!.pas_de_grp,
                                    style: TextStyle(color: Palette.yellow),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemCount: data.size,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: BlocBuilder<ThemeBloc, ThemeState>(
                                      builder: (context, state) {
                                        if (state is ThemeState) {}
                                        return Icon(Icons.group_outlined,
                                            color: state.themeData ==
                                                    MyTheme.darkTheme
                                                ? Palette.yellow
                                                : Palette.blue);
                                      },
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(
                                                '${data.docs[index]['libelle']}')),
                                        // data.docs[index]['userId'] ==
                                        //         FirebaseAuth
                                        //             .instance.currentUser!.uid
                                        //     ? Text(
                                        //         "Admin",
                                        //         style: TextStyle(
                                        //             color: Palette.yellow),
                                        //       )
                                        //     : Text('Non Admin'),
                                      ],
                                    ),
                                    subtitle: Text(
                                        '${data.docs[index]['domaine']}',
                                        style: TextStyle(color: Palette.grey)),
                                    trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GroupeProblem(
                                                      groupeLibelle:
                                                          data.docs[index]
                                                              ['libelle'],
                                                      groupeId:
                                                          data.docs[index].id,
                                                      membres: data.docs[index]
                                                          ['membres'],
                                                      userId: data.docs[index]
                                                          ['userId'],
                                                    )));
                                      },
                                      icon: Icon(
                                        Icons.keyboard_double_arrow_right,
                                        color: Palette.grey,
                                      ),
                                    ),
                                  );
                                });
                      });
                }
                return Text("");
              })),
            ),
          ],
        ));
  }
}
