import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/Groupe/add.groupe.dart';
import 'package:flutterfirebase/pages/Groupe/allUsers.dart';
import 'package:flutterfirebase/pages/Groupe/groupe.probleme.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';

class Groupe extends StatefulWidget {
  Groupe({Key? key}) : super(key: key);

  @override
  State<Groupe> createState() => _GroupeState();
}

class _GroupeState extends State<Groupe> {
  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser!;
    print(user.uid.toString());
    uid = user.uid;
  }

  final Stream<QuerySnapshot> groupes =
      FirebaseFirestore.instance.collection('Groupe').snapshots();
  String uid = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Palette.blue),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddGroupe())));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Ajouter un groupe',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Mes groupes",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: groupes,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                final data = snapshot.requireData;
                print(data);
                return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      if (data.docs[index]['userId'] == uid) {
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
                                      builder: (context) => GroupeProblem(groupeLibelle: data.docs[index]['libelle'], groupeId: data.docs[index].id,)));
                            },
                            icon: Icon(
                              Icons.keyboard_double_arrow_right,
                              color: Palette.yellow,
                            ),
                          ),
                        );
                      }
                      return Container();
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
