import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/pages/Accueil/plus_detail.dart';
import 'package:flutterfirebase/pages/Groupe/addProblem.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';
import 'package:flutterfirebase/pages/widget/solvit.logo.dart';

class GroupeProblem extends StatelessWidget {
  final String groupeLibelle;
  final String groupeId;

  const GroupeProblem({required this.groupeLibelle, required this.groupeId});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> problems =
        FirebaseFirestore.instance.collection('Problem').snapshots();
    return SafeArea(
      child: Scaffold(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Nom du groupe ',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Palette.blue),
                ),
                Text(
                  groupeLibelle,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Palette.yellow),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProblem(
                              groupeId: groupeId,
                              groupename: groupeLibelle,
                            )));
              },
              color: Palette.blue,
              child: Text(
                "Ajouter un problème",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: problems,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  final data = snapshot.requireData;
                  print(problems.runtimeType);
                  print(data.runtimeType);
                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        if (data.docs[index]['groupeId'] == groupeId) {
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
                                        'par : ${data.docs[index]['userEmail']}',
                                        style: TextStyle(fontSize: 18,color: Palette.yellow),
                                        
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Icon(Icons.star),
                                        Text("${data.docs[index]['nbrVote']}")
                                      ],
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlusDetail()));
                                      },
                                      color: Palette.blue,
                                      child: Text(
                                        "Plus de détail",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        return Column(
                          children: [
                            SvgPicture.asset('assets/nodata.svg'),
                            Text("Pas de problème pour ce groupe"),
                          ],
                        );
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
