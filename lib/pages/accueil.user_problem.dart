import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/database/database_bloc.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/problem.plus_detail.dart';

class Accueil extends StatefulWidget {
  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  void _userProblem(context) {
    BlocProvider.of<DatabaseBloc>(context).add(UserProblemsRequested());
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
                Text(
                  "Mes problèmes",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
            Expanded(child: BlocBuilder<DatabaseBloc, DatabaseState>(
                builder: (((context, state) {
              if (state is LodingUserProblems) {
                return CircularProgressIndicator();
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
                      return Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.requireData;
                    if (data.size == 0) {
                      return Column(
                        children: [
                          SvgPicture.asset("assets/nodata.svg",width: MediaQuery.of(context).size.width*0.9,),
                          Text("Vous n'avez aucun problème"),
                         
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
                                      color: Palette.blue,
                                      child: Text(
                                        "Voir les commentaires",
                                        style: TextStyle(color: Colors.white),
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
