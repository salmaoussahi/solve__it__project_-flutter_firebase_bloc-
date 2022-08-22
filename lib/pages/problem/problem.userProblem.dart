import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/problem/problem_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/commentaire/commentaire.groupComments.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';

class Accueil extends StatefulWidget {
  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  void _userProblem(context) {
    BlocProvider.of<ProblemBloc>(context).add(UserProblemsRequested());
  }

  @override
  void initState() {
    _userProblem(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return Text(
                        "Mes problèmes",
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
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    "assets/mesproblem.svg",
                    width: 100,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: BlocBuilder<ProblemBloc, ProblemState>(
                builder: (((context, state) {
              if (state is LodingUserProblems) {
                return CircularProgressIndicator(color: Palette.yellow,);
              }
              if (state is ErrorUserProblems) {
                return Text("erreur : " + state.errormessage);
              }
              if (state is LoadedUserProblems) {
                return StreamBuilder<QuerySnapshot>(
                  stream: state.problems,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('error');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(color: Palette.yellow,));
                    }
                    final data = snapshot.requireData;
                    if (data.size == 0) {
                      return Column(
                        children: [
                          SvgPicture.asset(
                            "assets/nodata.svg",
                            width: MediaQuery.of(context).size.width,
                          ),
                          Text(
                            "Vous n'avez aucun problème",
                            style: TextStyle(color: Palette.yellow),
                          ),
                        ],
                      );
                    }
                    return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                ListTile(
                                  trailing: Icon(
                                    Icons.check_circle,
                                    color: data.docs[index]['isSolved'] == true
                                        ? Colors.green
                                        : Palette.grey,
                                  ),
                                  title: Column(
                                    children: [
                                      Text(
                                        '${data.docs[index]['libelle']}',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                      data.docs[index]['description']
                                                  .toString()
                                                  .length <
                                              70
                                          ? '${data.docs[index]['description']} '
                                          : '${data.docs[index]['description'].substring(0, 70)}... ',
                                      style: TextStyle(color: Palette.grey)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlusDetail(
                                                      problemId:
                                                          data.docs[index].id,
                                                      description:
                                                          data.docs[index]
                                                              ['description'],
                                                      isSolved: data.docs[index]
                                                          ['isSolved'],
                                                      libelle: data.docs[index]
                                                          ['libelle'],
                                                      userEmail:
                                                          data.docs[index]
                                                              ['userEmail'],
                                                    )));
                                      },
                                      child: Text(
                                        "Voir les commentaires",
                                        style: TextStyle(color: Palette.yellow),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                    ;
                  },
                );
              }
              return Container();
            }))))
          ],
        ),
      ),
    );
  }
}
