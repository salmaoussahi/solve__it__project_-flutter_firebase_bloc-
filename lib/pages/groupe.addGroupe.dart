import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/database/database_bloc.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/config.solvit.logo.dart';

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
    void _addGroupe(BuildContext context) {
      BlocProvider.of<DatabaseBloc>(context).add(
        AddGroupeRequested(
          domaine: _domaine.text,
          libelle: _libelle.text,
        ),
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
        child: BlocConsumer<DatabaseBloc, DatabaseState>(
          builder: (context, state) {
            if (state is LodingAddGroup) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Ajouter un groupe",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                      _addGroupe(context);
                      print(_domaine.text);
                    },
                    child: const Text(
                      'Créer le groupe',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            );
          },
          listener: (context, state) {
            if (state is LoadedAddGroup) {
              Navigator.of(context).pop();
            }
            if (state is ErrorAddGroup) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errormessage)));
            }
          },
        ),
      ),
    );
  }
}
