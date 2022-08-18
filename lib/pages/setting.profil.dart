import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_state.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/authentication.signin.dart';
import 'package:flutterfirebase/pages/config.solvit.logo.dart';


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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlovitLogo(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Profil",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset("assets/user.svg",width: MediaQuery.of(context).size.width*0.7,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        style: const TextStyle(color: Color(0xFF121522)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  leading: Icon(
                    Icons.alternate_email,
                    color: Palette.yellow,
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
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Text(
                                  'Nom : ',
                                  style:
                                      const TextStyle(color: Color(0xFF121522)),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${data['last_name']}',
                                  style:
                                      const TextStyle(color: Color(0xFF121522)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            leading: Icon(
                              Icons.person,
                              color: Palette.yellow,
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                Text(
                                  'Prénom : ',
                                  style:
                                      const TextStyle(color: Color(0xFF121522)),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${data['first_name']}',
                                  style:
                                      const TextStyle(color: Color(0xFF121522)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            leading: Icon(
                              Icons.person,
                              color: Palette.yellow,
                            ),
                          ),
                        ],
                      );
                    }

                    return Text("");
                  },
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Palette.blue),
                onPressed: () {},
                child: const Text(
                  'Modifier votre profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            //
          ],
        ),
      ),
    );
  }
}
