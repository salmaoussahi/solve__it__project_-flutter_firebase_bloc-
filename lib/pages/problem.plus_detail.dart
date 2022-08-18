import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/problem.addComment.dart';
import 'package:flutterfirebase/pages/config.palette.dart';

class PlusDetail extends StatefulWidget {
  String problemId;
  PlusDetail({Key? key, required this.problemId}) : super(key: key);

  @override
  State<PlusDetail> createState() => _PlusDetailState();
}

class _PlusDetailState extends State<PlusDetail> {
  final user = FirebaseAuth.instance.currentUser!;

  final Stream<QuerySnapshot> problem =
      FirebaseFirestore.instance.collection('Problem').snapshots();

  final Stream<QuerySnapshot> comments =
      FirebaseFirestore.instance.collection('Commentaire').snapshots();

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
              child: StreamBuilder<QuerySnapshot>(
                stream: problem,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  final data = snapshot.requireData;
                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        if (data.docs[index].id == widget.problemId) {
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
                                        'Par : ${data.docs[index]['userEmail']}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Palette.yellow),
                                      ),
                                      Text(
                                        '${data.docs[index]['libelle']}',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                      '${data.docs[index]['description']} ',
                                      style: TextStyle(color: Palette.grey)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    MaterialButton(
                                      onPressed: () {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Commenter(
                                                  problemId:
                                                      this.widget.problemId,
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
                          );
                        }
                        return Container();
                      });
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: comments,
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
                        if (data.docs[index]['problemId'] ==
                            this.widget.problemId) {
                          return ListTile(
                            title: Text("${data.docs[index]['userEmail']}"),
                            subtitle: TextButton(
                              child: Text(
                                  // data.docs[index]['userId'] == user.uid
                                  //     ? "valider"
                                  //     : "",
                                  // style: TextStyle(color: Palette.yellow),
                                  "${data.docs[index]['commentaire']}"),
                              onPressed: () {
                                setState(() {
                                  data.docs[index]['valide'] == true;
                                });
                              },
                            ),
                            trailing: Icon(Icons.star),
                          );
                        }
                        return Container();
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
