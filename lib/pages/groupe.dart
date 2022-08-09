import 'package:flutter/material.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class Groupe extends StatefulWidget {
  Groupe({Key? key}) : super(key: key);

  @override
  State<Groupe> createState() => _GroupeState();
}

class _GroupeState extends State<Groupe> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Row(
              children: [
                SlovitLogo(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Mes groupes",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
      ],),
    );
  }
}