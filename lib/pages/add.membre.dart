import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/config.solvit.logo.dart';


class AddMembre extends StatefulWidget {
  final String groupeLibelle;
  final String groupeId;
  const AddMembre({
    Key? key,
    required this.groupeLibelle,
    required this.groupeId,
  }) : super(key: key);

  @override
  State<AddMembre> createState() => _AddMembreState();
}

class _AddMembreState extends State<AddMembre> {
  TextEditingController _email = new TextEditingController();
  var membres = [];

  Map<String, dynamic> _userMap = {
    'last_name': '',
    'id': '',
    'first_name': '',
    'email': ''
  };
  CollectionReference groupe = FirebaseFirestore.instance.collection('Groupe');
  Future<void> updateGroupe() {
  return groupe
    .doc(this.widget.groupeId)
    .update({'membres': FieldValue.arrayUnion(membres)})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}

  void _onSearch() async {
    var data = await FirebaseFirestore.instance
        .collection("UserData")
        .where("email", isEqualTo: _email.text)
        .get()
        .then((value) {
      setState(() {
        _userMap = value.docs[0].data();
      });
      print(_userMap);
    });
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ajouter un membre au groupe :\n" + this.widget.groupeLibelle,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _email,
                decoration: InputDecoration(
                    hintText: "Entrer l'email du membre",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.search), onPressed: _onSearch)),
              ),
            ),
            _userMap != {}
                ? ListTile(
                    onTap: (() {
                      print(_userMap);
                    }),
                    title: Row(
                      children: [
                        Text(_userMap['first_name']),
                      ],
                    ),
                    subtitle: Text(_userMap['email']),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Palette.grey,
                        ),
                        onPressed: (() {
                          membres.add(_userMap['email']);
                          _onSearch();
                          print(membres.length);
                          print(membres);
                        })),
                  )
                : Container(),
            Text(
              "Vous avez ajouter : ",
              style: TextStyle(color: Palette.yellow, fontSize: 22),
            ),
            membres.length == 0
                ? Text("personne")
                : Expanded(
                    child: ListView.builder(
                        itemCount: membres.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(membres[index]),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_forever_sharp,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                membres.removeAt(index);
                                _onSearch();
                                print(membres);
                              },
                            ),
                          );
                        }),
                  ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Palette.blue),
                onPressed: () {
                  updateGroupe();
                  
                },
                child: const Text(
                  'Confirmer',
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
