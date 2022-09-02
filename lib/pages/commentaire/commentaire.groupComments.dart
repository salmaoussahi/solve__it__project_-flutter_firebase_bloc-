import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/commentaire/commentaire_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutterfirebase/pages/commentaire/commentaire.addComment.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlusDetail extends StatefulWidget {
  String problemId;
  String libelle;
  String description;
  String userEmail;
  bool isSolved;
  PlusDetail({
    Key? key,
    required this.problemId,
    required this.libelle,
    required this.description,
    required this.userEmail,
    required this.isSolved,
  }) : super(key: key);

  @override
  State<PlusDetail> createState() => _PlusDetailState();
}

class _PlusDetailState extends State<PlusDetail> {
  void _problemComments(context) {
    BlocProvider.of<CommentaireBloc>(context)
        .add(ProblemCommentsRequested(problemId: widget.problemId));
  }

  @override
  void initState() {
    _problemComments(context);
  }

  @override
  Widget build(BuildContext context) {
    Color color = Palette.grey;
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.link)),
                          Text(
                            AppLocalizations.of(context)!.detail,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: state.themeData == MyTheme.darkTheme
                                    ? Palette.yellow
                                    : Palette.blue),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            // Text("https://solvitdomaine.page.link/start"),
            SizedBox(
              height: 10,
            ),
            Flexible(
                child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    
                    trailing: Icon(
                      Icons.check_circle,
                      color: this.widget.isSolved == true
                          ? Colors.green
                          : Palette.grey,
                    ),
                    title: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.par +" :" +
                              this.widget.userEmail,
                          style: TextStyle(fontSize: 18),
                        ),
                        BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) {
                            return Text(
                              this.widget.libelle,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: state.themeData == MyTheme.darkTheme
                                      ? Palette.yellow
                                      : Palette.blue),
                            );
                          },
                        ),
                      ],
                    ),
                    subtitle: Text(this.widget.description,
                        style: TextStyle(color: Palette.grey)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FirebaseAuth.instance.currentUser!.email ==
                              widget.userEmail
                          ? BlocBuilder<ThemeBloc, ThemeState>(
                              builder: (context, state) {
                                return MaterialButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Problem")
                                        .doc(widget.problemId)
                                        .update({"isSolved": true});
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .problem_resolu),
                                      backgroundColor:
                                          state.themeData == MyTheme.darkTheme
                                              ? Palette.yellow
                                              : Palette.blue,
                                    ));
                                    Navigator.pop(context);
                                  },
                                  color: Palette.yellow,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .problem_resolu,
                                    style: TextStyle(color: Palette.blue),
                                  ),
                                );
                              },
                            )
                          : Text(""),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: MaterialButton(
                          onPressed: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => Commenter(
                                      problemId: this.widget.problemId,
                                    ));
                          },
                          color: Palette.blue,
                          child: Text(
                            AppLocalizations.of(context)!.commenter,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
            Expanded(child: BlocBuilder<CommentaireBloc, CommentaireState>(
              builder: (context, state) {
                if (state is LodingProblemComments) {
                  return CircularProgressIndicator(
                    color: Palette.yellow,
                  );
                }
                if (state is ErrorProblemComments) {
                  return Text(
                      AppLocalizations.of(context)!.error + state.errormessage);
                }
                if (state is LoadedProblemComments) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: state.comments,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(AppLocalizations.of(context)!.error);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      final data = snapshot.requireData;
                      print(data.size);

                      return ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("${data.docs[index]['userEmail']}"),
                              subtitle: TextButton(
                                child: Text(
                                  "${data.docs[index]['commentaire']}",
                                  style: TextStyle(color: Palette.grey),
                                ),
                                onPressed: () {
                                  setState(() {
                                    data.docs[index]['valide'] == true;
                                  });
                                },
                              ),
                              
                            );
                          });
                    },
                  );
                }
                return Container();
              },
            ))
          ],
        ),
      ),
    );
  }
}
