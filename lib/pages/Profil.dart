import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_state.dart';
import 'package:flutterfirebase/pages/Authentication/SignIn/signin.dart';
import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('UserData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is UnAuthenticated) {
                  
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignIn()),
                    (route) => false,
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlovitLogo(),
                  Text(
                    "Profil",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Email :',
                        style: const TextStyle(color: Color(0xFF121522)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${user.email}',
                        style: const TextStyle(color: Color(0xFF9E9E9E)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  leading: Icon(
                    Icons.alternate_email,
                    color: Palette.grey,
                  ),
                  ),
                  FutureBuilder<DocumentSnapshot>(
                  future: users.doc(user.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              'Nom et Prénom : ',
                              style: const TextStyle(
                                  color: Color(0xFF121522)),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${data['first_name']} ${data['last_name']}',
                              style: const TextStyle(
                                  color: Color(0xFF9E9E9E)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Palette.grey,
                        ),
                      );
                    }

                    return Text("");
                  },
                  )
                ],
              ),
            ),

            //
          ],
        ),
      ),
    );
  }
}
