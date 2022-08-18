// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/database/database_bloc.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/problem.addComment.dart';

class PlusDetail extends StatefulWidget {
  String problemId;
  String libelle;
  String description;
  String userEmail;
  bool isSolved;
  PlusDetail({
    Key? key,
    required this.problemId,
    required this.libelle,
    required this.description,
    required this.userEmail,
    required this.isSolved,
  }) : super(key: key);

  @override
  State<PlusDetail> createState() => _PlusDetailState();
}

class _PlusDetailState extends State<PlusDetail> {
  void _problemComments(context) {
    BlocProvider.of<DatabaseBloc>(context)
        .add(ProblemCommentsRequested(problemId: widget.problemId));
  }

  @override
  void initState() {
    print("object");
    _problemComments(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Detail du problème",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Palette.blue),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
                child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  ListTile(
                    trailing: Icon(
                      Icons.check_circle,
                      color: this.widget.isSolved == true
                          ? Colors.green
                          : Palette.grey,
                    ),
                    title: Column(
                      children: [
                        Text(
                          'Par : ' + this.widget.userEmail,
                          style: TextStyle(fontSize: 18, color: Palette.yellow),
                        ),
                        Text(
                          this.widget.libelle,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    subtitle: Text(this.widget.description,
                        style: TextStyle(color: Palette.grey)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Commenter(
                                    problemId: this.widget.problemId,
                                  ));
                        },
                        color: Palette.blue,
                        child: Text(
                          "Commenter",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
            Expanded(child: BlocBuilder<DatabaseBloc, DatabaseState>(
              builder: (context, state) {
                if (state is LodingProblemComments) {
                  return CircularProgressIndicator();
                }
                if (state is ErrorProblemComments) {
                  return Text("erreur : " + state.errormessage);
                }
                if (state is LoadedProblemComments) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: state.comments,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('error');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      final data = snapshot.requireData;
                      print(data.size);

                      return ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("${data.docs[index]['userEmail']}"),
                              subtitle: TextButton(
                                child:
                                    Text("${data.docs[index]['commentaire']}"),
                                onPressed: () {
                                  setState(() {
                                    data.docs[index]['valide'] == true;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star),
                            );
                          });
                    },
                  );
                }
                return Container();
              },
            ))
          ],
        ),
      ),
    );
  }
}
