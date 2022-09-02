import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterfirebase/bloc/groupe/goupe_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import '../problem/problem.groupProblem.dart';

class OtherGroup extends StatefulWidget {
  OtherGroup({Key? key}) : super(key: key);

  @override
  State<OtherGroup> createState() => _OtherGroupState();
}

class _OtherGroupState extends State<OtherGroup> {
  void _userProblem(context) {
    BlocProvider.of<GoupeBloc>(context).add(UserOtherGroupeRequested());
  }

  @override
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
            Expanded(child:
                BlocBuilder<GoupeBloc, GoupeState>(builder: ((context, state) {
              if (state is LodingUserOtherGroupe) {
                return CircularProgressIndicator(
                  color: Palette.yellow,
                );
              }
              if (state is ErrorUserOtherGroupe) {
                return Text(
                    AppLocalizations.of(context)!.error + state.errormessage);
              }
              if (state is LoadedUserOtherGroupe) {
                return StreamBuilder<QuerySnapshot>(
                  stream: state.othergroupes,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text(AppLocalizations.of(context)!.error);
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child:
                              CircularProgressIndicator(color: Palette.yellow));
                    }

                    final data = snapshot.requireData;
                    // print(data.size);
                    int i = 0;
                    return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          if (data.docs[index]['membres'].contains(
                              FirebaseAuth.instance.currentUser!.email)) {
                            i++;
                            print(i);
                            return ListTile(
                              leading: Icon(
                                Icons.group_outlined,
                                color: Palette.blue,
                              ),
                              title: Text('${data.docs[index]['libelle']}'),
                              subtitle: Text('${data.docs[index]['domaine']}',
                                  style: TextStyle(color: Palette.grey)),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GroupeProblem(
                                                groupeLibelle: data.docs[index]
                                                    ['libelle'],
                                                groupeId: data.docs[index].id,
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
                          } else {
                            Container();
                          }

                          return Container();
                        });
                  },
                );
              }
              return Text("");
            })))
          ],
        ));
  }
}
