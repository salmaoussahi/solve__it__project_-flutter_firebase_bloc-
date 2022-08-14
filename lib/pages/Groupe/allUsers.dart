import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/Groupe/multiselect.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';

class AllUsrers extends StatefulWidget {
  @override
  State<AllUsrers> createState() => _AllUsrersState();
}

class _AllUsrersState extends State<AllUsrers> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('UserData').snapshots();
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Row(
            children: [
              // SlovitLogo(),
            ],
          ),
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
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                  Center(
                    child: Text(
                      "Séléctionner le(s) membre(s) du groupe",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                onPressed: () {},
                child: const Text(
                  'Créer le groupe',
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
