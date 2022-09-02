

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/groupe/goupe_bloc.dart';
import 'package:flutterfirebase/bloc/problem/problem_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutterfirebase/pages/groupe/groupe.addMembre.dart';

import 'package:flutterfirebase/pages/problem/problem.addProblem.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/commentaire/commentaire.groupComments.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class GroupeProblem extends StatefulWidget {
  final String userId;
  final String groupeLibelle;
  final String groupeId;
  var membres = [];

  GroupeProblem(
      {required this.userId,
      required this.groupeLibelle,
      required this.groupeId,
      required this.membres});

  @override
  State<GroupeProblem> createState() => _GroupeProblemState();
}

class _GroupeProblemState extends State<GroupeProblem> {
  @override
  void initState() {
    _groupProblem(context);
  }

  void _groupProblem(context) {
    BlocProvider.of<ProblemBloc>(context)
        .add(GroupProblemsRequested(problemId: widget.groupeId));
    BlocProvider.of<GoupeBloc>(context)
        .add(GroupMembresrquested(groupeId: widget.groupeId));
    BlocProvider.of<GoupeBloc>(context).add(UserGroupeRequested());
  }

  void _deleteGroupe(BuildContext context) {
    BlocProvider.of<GoupeBloc>(context).add(
      DeleteGroupe(groupeId: widget.groupeId),
    );
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
              onPressed: () {
                BlocProvider.of<GoupeBloc>(context).add(UserGroupeRequested());
                Navigator.of(context).pop();
              },
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
                      _groupProblem(context);
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
          SizedBox(
            height: 10,
          ),
          //Information du groupe
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Palette.yellow,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.info_grp,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.groupeLibelle,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Palette.grey),
                  ),
                  trailing:
                      widget.userId == FirebaseAuth.instance.currentUser!.uid
                          ? IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _deleteGroupe(context);
                                Navigator.pop(context);
                                BlocProvider.of<GoupeBloc>(context)
                                    .add(UserGroupeRequested());
                                // print(widget.groupeId);
                              },
                            )
                          : Text(""),
                ),

                //Membre du groupe
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ExpansionTile(
                          onExpansionChanged: (bool isExpanded) {
                            BlocProvider.of<GoupeBloc>(context).add(
                                GroupMembresrquested(
                                    groupeId: widget.groupeId));
                          },
                          title: ListTile(
                            title: Text(
                              AppLocalizations.of(context)!.membre_grp,
                              style: TextStyle(color: Palette.grey),
                            ),
                          ),
                          iconColor: Palette.grey,
                          children: [
                            BlocBuilder<GoupeBloc, GoupeState>(
                              builder: (context, state) {
                                print(state);

                                if (state is LodingGroupeMembres) {
                                  return CircularProgressIndicator(
                                    color: Palette.yellow,
                                  );
                                }
                                if (state is ErrorGroupeMembres) {
                                  print(state.errormessage);
                                }
                                if (state is LoadedGroupeMembres) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: widget.membres.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(widget.membres[index]),
                                          leading: Icon(Icons.person),
                                        );
                                      });
                                }
                                return Container(
                                  child: Text(""),
                                );
                              },
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Palette.blue),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => AddMembre(
                                              groupeLibelle:
                                                  this.widget.groupeLibelle,
                                              groupeId:
                                                  this.widget.groupeId))));
                                },
                                child:  Text(
                                  AppLocalizations.of(context)!.add_mem_titre,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: BlocBuilder<ProblemBloc, ProblemState>(
              builder: (((context, state) {
            // _groupProblem(context);

            if (state is LodingGroupProblems) {
              return CircularProgressIndicator(
                color: Palette.yellow,
              );
            }
            if (state is ErrorGroupProblems) {
              return Text(AppLocalizations.of(context)!.error + state.errormessage);
            }
            if (state is LoadedGroupProblems) {
              return StreamBuilder<QuerySnapshot>(
                stream: state.problems,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(AppLocalizations.of(context)!.error);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Palette.yellow,
                    ));
                  }
                  final data = snapshot.requireData;

                  return data.size == 0
                      ? Column(
                          children: [
                            SvgPicture.asset(
                              "assets/images/nodata.svg",
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            Text(AppLocalizations.of(context)!.grp_pas_de_prob)
                          ],
                        )
                      : ListView.builder(
                          itemCount: data.size,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        data.docs[index]['userId'] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  print(data.docs[index].id);
                                                  FirebaseFirestore.instance
                                                      .collection("Problem")
                                                      .doc(data.docs[index].id)
                                                      .delete();
                                                  FirebaseFirestore.instance
                                                      .collection('Commentaire')
                                                      .where("problemId",
                                                          isEqualTo: data
                                                              .docs[index].id)
                                                      .get()
                                                      .then((value) {
                                                    for (DocumentSnapshot ds
                                                        in value.docs) {
                                                      ds.reference.delete();
                                                    }
                                                  });
                                                },
                                              )
                                            : Text(""),
                                        Icon(
                                          Icons.check_circle,
                                          color: data.docs[index]['isSolved'] ==
                                                  true
                                              ? Colors.green
                                              : Palette.grey,
                                        ),
                                      ],
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data.docs[index]['userEmail']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${data.docs[index]['libelle']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Palette.yellow),
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
                                                        isSolved:
                                                            data.docs[index]
                                                                ['isSolved'],
                                                        libelle:
                                                            data.docs[index]
                                                                ['libelle'],
                                                        userEmail:
                                                            data.docs[index]
                                                                ['userEmail'],
                                                      )));
                                        },
                                        child: Text(AppLocalizations.of(context)!.voir_commts),
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
            state is LoadedAddGroup;
            return Center(
                child: CircularProgressIndicator(
              color: Palette.yellow,
            ));
          })))),
          SizedBox(
            height: 100,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProblem(
                        groupeId: widget.groupeId,
                        groupename: widget.groupeLibelle,
                      )));
        },
        child: Icon(
          Icons.add,
          color: Palette.blue,
        ),
        backgroundColor: Palette.yellow,
      ),
    );
  }
}
