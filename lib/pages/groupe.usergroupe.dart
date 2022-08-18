import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/database/database_bloc.dart';
import 'package:flutterfirebase/pages/groupe.addGroupe.dart';
import 'package:flutterfirebase/pages/groupe.probleme.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/config.solvit.logo.dart';

class UserGroupe extends StatefulWidget {
  const UserGroupe({Key? key}) : super(key: key);

  @override
  State<UserGroupe> createState() => _UserGroupeState();
}

class _UserGroupeState extends State<UserGroupe> {
  void _userProblem(context) {
    BlocProvider.of<DatabaseBloc>(context).add(UserGroupeRequested());
  }

  @override
  void initState() {
    _userProblem(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [
            Flexible(
              child: BlocBuilder<DatabaseBloc, DatabaseState>(
                  builder: ((context, state) {
                print(state);

                if (state is LodingUserGroupe) {
                  return CircularProgressIndicator();
                }
                if (state is ErrorUserGroupe) {
                  return Text("erreur : " + state.errormessage);
                }
                if (state is LoadedUserGroupe) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: state.groupes,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('error');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final data = snapshot.requireData;
                        print(data.size);
                        if (data.size == 0) {
                          return Column(
                            children: [
                              SvgPicture.asset("assets/nodata.svg"),
                              Text("Vous n'avez pas de groupe"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                AddGroupe())));
                                  },
                                  child: Text(
                                    "créer un !",
                                    style: TextStyle(color: Palette.yellow),
                                  ))
                            ],
                          );
                        }
                        return ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(
                                  Icons.group_outlined,
                                  color: Palette.blue,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${data.docs[index]['libelle']}'),
                                    data.docs[index]['userId'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? Text(
                                            "Admin",
                                            style: TextStyle(
                                                color: Palette.yellow),
                                          )
                                        : Text('Non Admin'),
                                  ],
                                ),
                                subtitle: Text('${data.docs[index]['domaine']}',
                                    style: TextStyle(color: Palette.grey)),
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GroupeProblem(
                                                  groupeLibelle: data
                                                      .docs[index]['libelle'],
                                                  groupeId: data.docs[index].id,
                                                  membres: data.docs[index]
                                                      ['membres'],
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
                return Container();
              })),
            ),
          ],
        ));
  }
}
