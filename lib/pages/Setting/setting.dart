import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/Setting/reset_password.dart';
import 'package:flutterfirebase/pages/Setting/Profil.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var isSelected;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
         
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Parametre",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              ListTile(
                onTap: (() {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => Profil())));
                }),
                title: Text("Profil"),
                trailing: Icon(Icons.person,color: Palette.yellow,),
              ),
              
              ListTile(
                title: Text("Thème"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.sunny,color: Palette.yellow,), Icon(Icons.dark_mode_rounded)],
                ),
              ),
              ListTile(
                title: Text("Modifier mot de passe"),
                trailing: Icon(Icons.password,color: Palette.grey,),
                onTap: (() {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => ResetPassword())));
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
