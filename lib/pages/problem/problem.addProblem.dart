import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/problem/problem_bloc.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';

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

    void _addProblem(BuildContext context) {
      BlocProvider.of<ProblemBloc>(context).add(
        AddProblemRequested(
            description: _description.text,
            groupeId: widget.groupeId,
            intitule: _intitule.text),
      );
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
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Ajouter un problème dans le groupe : ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      
                          this.widget.groupename,
                      style:
                          TextStyle(fontSize: 18, color: Palette.grey),
                    ),
                  ],
                ),
              ],
            ),
            BlocConsumer<ProblemBloc, ProblemState>(
              builder: (context, state) {
                if (state is LodingAddProblem) {
                  return  Center(child: CircularProgressIndicator(color: Palette.yellow,));
                }
                return Center(
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.grey,
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
                          cursorColor: Colors.grey,
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            
                            onPressed: () {
                              _addProblem(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Ajouter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              listener: (context, state) {
                if (state is LoadedAddProblem) {
                  BlocProvider.of<ProblemBloc>(context)
                      .add(GroupProblemsRequested(problemId: widget.groupeId));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Problème Ajouté avec succes",
                      style: TextStyle(color: Palette.blue),
                    ),
                    backgroundColor: Palette.yellow,
                  ));
                  Navigator.canPop(context);
                }
                if (state is ErrorAddProblem) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errormessage)));
                }
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
