import 'package:flutter/material.dart';
import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
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
                "Accueil",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                  trailing: Icon(Icons.check_circle,color: Colors.green,),
                  title: Text(
                    'Libellé',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  subtitle: Text('Description du problème'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [Icon(Icons.star), Text("vote")],
                    ),
                    MaterialButton(onPressed: (){},color: Palette.blue,child: Text("Plus de détail",style: TextStyle(color:Colors.white),),)
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  trailing: Icon(Icons.check_circle,color: Colors.green,),
                  title: Text(
                    'Libellé',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  subtitle: Text('Description du problème'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [Icon(Icons.star), Text("vote")],
                    ),
                    MaterialButton(onPressed: (){},color: Palette.blue,child: Text("Plus de détail",style: TextStyle(color:Colors.white),),)
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  trailing: Icon(Icons.check_circle,color: Colors.green,),
                  title: Text(
                    'Libellé',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  subtitle: Text('Description du problème'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [Icon(Icons.star), Text("vote")],
                    ),
                    MaterialButton(onPressed: (){},color: Palette.blue,child: Text("Plus de détail",style: TextStyle(color:Colors.white),),)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
