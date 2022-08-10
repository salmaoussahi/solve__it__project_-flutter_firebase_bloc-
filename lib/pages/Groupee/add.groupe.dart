import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/Groupee/multiselect.dart';
import 'package:flutterfirebase/palette.dart';

import '../../widget/solvit.logo.dart';

class AddGroupe extends StatefulWidget {
  AddGroupe({Key? key}) : super(key: key);

  @override
  State<AddGroupe> createState() => _AddGroupeState();
}

class _AddGroupeState extends State<AddGroupe> {
  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> _items = [
      'User 1',
      'User 2',
      'User 3',
      'User 4',
      'User 5',
      'User 6'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SlovitLogo(),
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
            Center(
              child: Form(
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
                    Text(
                      "Membre(s) du groupe",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Palette.yellow
                            ),
                            child: const Text('Selectionner des membres',style: TextStyle(color: Colors.white),),
                            onPressed: _showMultiSelect,
                          ),
                         
                          Wrap(
                            children: _selectedItems
                                .map((e) => Chip(
                                  backgroundColor: Palette.blue,
                                      label: Text(e,style: TextStyle(color: Colors.white),),
                                    ))
                                .toList(),
                          )
                        ],
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
