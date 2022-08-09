import 'package:flutter/material.dart';
import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class PlusDetail extends StatelessWidget {
  const PlusDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SlovitLogo(),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Libellé problème",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Palette.blue),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    trailing: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    subtitle: Text('Description du problème'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlusDetail()));
                        },
                        color: Palette.yellow,
                        child: Text(
                          "Commenter",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Commentaire"),
                      subtitle: Text(
                        "Ajouter une étoile",
                        style: TextStyle(color: Palette.yellow),
                      ),
                      trailing: Icon(Icons.star),
                      // leading: Icon(
                      //   Icons.check_circle,
                      //   color: Colors.green,
                      // )
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
