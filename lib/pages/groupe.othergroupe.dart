import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/database/database_bloc.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/config.solvit.logo.dart';
import 'groupe.probleme.dart';

class OtherGroup extends StatefulWidget {
  OtherGroup({Key? key}) : super(key: key);

  @override
  State<OtherGroup> createState() => _OtherGroupState();
}

class _OtherGroupState extends State<OtherGroup> {
  void _userProblem(context) {
    BlocProvider.of<DatabaseBloc>(context).add(UserOtherGroupeRequested());
  }

  @override
  void initState() {
    _userProblem(context);
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
        body: Column(
          children: [
            Expanded(child: BlocBuilder<DatabaseBloc, DatabaseState>(
                builder: ((context, state) {
              if (state is LodingUserOtherGroupe) {
                return Text("Loading");
              }
              if (state is ErrorUserOtherGroupe) {
                return Text("erreur : " + state.errormessage);
              }
              if (state is LoadedUserOtherGroupe) {
                return StreamBuilder<QuerySnapshot>(
                  stream: state.othergroupes,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.requireData;
                    print(data.size);
                    if (data.size == 0) {
                      return Column(
                        children: [
                          SvgPicture.asset("assets/nodata.svg"),
                          Text("Vous ne faites pas membre d'un autre groupe"),
                        ],
                      );
                    }
                    return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          if (data.docs[index]['membres'].contains(
                              FirebaseAuth.instance.currentUser!.email)) {
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
                                  data.docs[index]['userId'] ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? print("admin")
                                      : print(("non admin"));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GroupeProblem(
                                                groupeLibelle: data.docs[index]
                                                    ['libelle'],
                                                groupeId: data.docs[index].id,
                                                membres: data.docs[index]
                                                    ['membres'],
                                              )));
                                },
                                icon: Icon(
                                  Icons.keyboard_double_arrow_right,
                                  color: Palette.grey,
                                ),
                              ),
                            );
                            print("exist");
                          } else {
                            print("not exist");
                          }

                          return Container();
                        });
                  },
                );
              }
              return Text("");
            })))
          ],
        ));
  }
}
