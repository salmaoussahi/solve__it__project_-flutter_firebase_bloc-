import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/config.solvit.logo.dart';

class AddProblem extends StatefulWidget {
  String groupeId;
  String groupename;
  AddProblem({required this.groupeId, required this.groupename});

  @override
  State<AddProblem> createState() => _AddProblemState();
}

class _AddProblemState extends State<AddProblem> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    TextEditingController _intitule = new TextEditingController();
    TextEditingController _description = new TextEditingController();
    final user = FirebaseAuth.instance.currentUser!;
    print(user.email.toString());
    CollectionReference problem =
        FirebaseFirestore.instance.collection('Problem');
    Future<void> addProblem() {
      return problem
          .add({
            'libelle': _intitule.text,
            'description': _description.text,
            'isSolved': false,
            'nbrVote': 0,
            "groupeId": this.widget.groupeId,
            "userId": user.uid.toString(),
            "userEmail": user.email.toString()
          })
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Problème ajouté avec succes'))),
                Navigator.pop(context),
              })
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Text(this.widget.groupeId),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Ajouter un problème dans le groupe : \n" +
                          this.widget.groupename,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _intitule,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Intitulé de votre problème",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _description,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "Entrer un description du problème",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Palette.blue),
                onPressed: () {
                  addProblem();
                  print(_description.text);
                  print(_intitule.text);
                },
                child: const Text(
                  'Ajouter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
