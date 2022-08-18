import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/database/database_bloc.dart';
import 'package:flutterfirebase/pages/add.membre.dart';

import 'package:flutterfirebase/pages/problem.addProblem.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/problem.plus_detail.dart';
import 'package:flutterfirebase/pages/config.solvit.logo.dart';

class GroupeProblem extends StatefulWidget {
  final String groupeLibelle;
  final String groupeId;
  var membres = [];

  GroupeProblem(
      {required this.groupeLibelle,
      required this.groupeId,
      required this.membres});

  @override
  State<GroupeProblem> createState() => _GroupeProblemState();
}

class _GroupeProblemState extends State<GroupeProblem> {
  void _groupProblem(context) {
    BlocProvider.of<DatabaseBloc>(context)
        .add(GroupProblemsRequested(problemId: widget.groupeId));
  }

  @override
  void initState() {
    _groupProblem(context);
  }

  void _deleteGroupe(BuildContext context) {
    BlocProvider.of<DatabaseBloc>(context).add(
      DeleteGroupe(groupeId: widget.groupeId),
    );
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
          SizedBox(
            height: 10,
          ),
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
                    'Information du groupe',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Palette.blue),
                  ),
                  subtitle: Text(
                    widget.groupeLibelle,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Palette.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _deleteGroupe(context);
                      Navigator.pop(context);
                      // print(widget.groupeId);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ExpansionTile(
                          title: Text("Membres du groupe"),
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: widget.membres.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(widget.membres[index]),
                                    leading: Icon(Icons.person),
                                  );
                                }),
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
                                child: const Text(
                                  'Ajouter un membre',
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
          Expanded(child: BlocBuilder<DatabaseBloc, DatabaseState>(
              builder: (((context, state) {
            if (state is LodingGroupProblems) {
              return CircularProgressIndicator();
            }
            if (state is ErrorGroupProblems) {
              return Text("erreur : " + state.errormessage);
            }
            if (state is LoadedGroupProblems) {
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
                                title: Text(
                                  '${data.docs[index]['libelle']}',
                                  style: TextStyle(fontSize: 24),
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
                                              builder: (context) => PlusDetail(
                                                    problemId:
                                                        data.docs[index].id,
                                                    description:
                                                        data.docs[index]
                                                            ['description'],
                                                    isSolved: data.docs[index]
                                                        ['isSolved'],
                                                    libelle: data.docs[index]
                                                        ['libelle'],
                                                    userEmail: data.docs[index]
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
