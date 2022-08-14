import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/groupe/groupe_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/pages/Groupe/multiselect.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';
import 'package:flutterfirebase/pages/widget/solvit.logo.dart';


class AddGroupe extends StatefulWidget {
  AddGroupe({Key? key}) : super(key: key);

  @override
  State<AddGroupe> createState() => _AddGroupeState();
}

class _AddGroupeState extends State<AddGroupe> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _libelle = new TextEditingController();
    TextEditingController _domaine = new TextEditingController();
    final user = FirebaseAuth.instance.currentUser!;
    final Stream<QuerySnapshot> users =
        FirebaseFirestore.instance.collection('UserData').snapshots();
    CollectionReference groupe =
        FirebaseFirestore.instance.collection('Groupe');

    Future<void> addGroupe() {
      return groupe
          .add({
            'libelle': _libelle.text,
            'domaine': _domaine.text,
            "userId": user.uid.toString()
          })
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Groupe ajouté avec succes'))))
          .catchError((error) => print("Error: $error"));
    }

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
      body: SafeArea(
        child: Column(
          children: [
            // SlovitLogo(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ajouter un groupe",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _libelle,
                        decoration: const InputDecoration(
                          hintText: "Libellé du groupe",
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _domaine,
                        decoration: const InputDecoration(
                          hintText: "Domaine du groupe",
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    
                    
                  ],
                ),
              ),
            ),
            Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: users,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('error');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }
                          final data = snapshot.requireData;
                          print(users.runtimeType);
                          print(data.runtimeType);
                          return ListView.builder(
                              itemCount: data.size,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('${data.docs[index]['email']}'),
                                  subtitle: Text(
                                      '${data.docs[index]['first_name']} ${data.docs[index]['last_name']}',
                                      style: TextStyle(color: Palette.yellow)),
                                );
                              });
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Palette.blue),
                        onPressed: () {
                          addGroupe();
                          print(_domaine.text);
                        },
                        child: const Text(
                          'Créer le groupe',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
          ],
        ),
      ),
    );
  }
}
