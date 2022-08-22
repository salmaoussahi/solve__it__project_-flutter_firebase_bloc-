import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/groupe/goupe_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';

import '../../bloc/problem/problem_bloc.dart';

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

  void _addMembers(BuildContext context) {
    BlocProvider.of<GoupeBloc>(context)
        .add(AddMembres(groupeId: widget.groupeId, membres: membres));
  }

  void _onSearch(String email) async {
    await FirebaseFirestore.instance
        .collection("UserData")
        .where("email", isEqualTo: email)
        .get()
        .then((value) {
      setState(() {
        _userMap = value.docs[0].data();
      });
      print(_userMap);
    }).catchError((e) {
      print("errur" + e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Utilisateur non trouvé",
          style: TextStyle(color: Palette.blue),
        ),
        backgroundColor: Palette.yellow,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(Icons.arrow_back,
                  color: state.themeData == MyTheme.darkTheme
                      ? Palette.yellow
                      : Palette.blue),
              onPressed: () => Navigator.of(context).pop(),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return Text(
                        "Ajouter un membre au groupe:",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: state.themeData == MyTheme.darkTheme
                                ? Palette.yellow
                                : Palette.blue),
                      );
                    },
                  ),
                ),
                Text(
                  this.widget.groupeLibelle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.grey,
                keyboardType: TextInputType.text,
                controller: _email,
                decoration: InputDecoration(
                    hintText: "Entrer l'email du membre",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Palette.yellow,
                        ),
                        onPressed: () {
                          _onSearch(_email.text);
                        })),
              ),
            ),
            _userMap['first_name'] == ''
                ? Text("")
                : ListTile(
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
                          _onSearch(_email.text);
                          print(membres.length);
                          print(membres);
                        })),
                  ),
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
                                _onSearch(_email.text);
                                print(membres);
                              },
                            ),
                          );
                        }),
                  ),
            BlocConsumer<GoupeBloc, GoupeState>(
              builder: (context, state) {
                print(state);
                if (state is LoadedAddMembres) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Palette.yellow,
                  ));
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      _addMembers(context);
                    },
                    child: const Text(
                      'Confirmer',
                    ),
                  ),
                );
              },
              listener: (context, state) {
                print(state);
                if (state is LoadedAddMembres) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Membre Ajouté avec succes",
                      style: TextStyle(color: Palette.blue),
                    ),
                    backgroundColor: Palette.yellow,
                  ));

                  BlocProvider.of<ProblemBloc>(context)
                      .add(GroupProblemsRequested(problemId: widget.groupeId));
                  BlocProvider.of<GoupeBloc>(context)
                      .add(GroupMembresrquested(groupeId: widget.groupeId));
                  Navigator.canPop(context);
                }
                if (state is ErrorAddMembres) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errormessage)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
