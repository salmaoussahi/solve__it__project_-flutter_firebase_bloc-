import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfirebase/pages/setting.profil.dart';
import 'package:flutterfirebase/pages/authentication.logout.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/setting.reset_password.dart';
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
          SvgPicture.asset("assets/setting.svg",width: MediaQuery.of(context).size.width*0.8,),
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
                trailing: Icon(Icons.password,color: Palette.yellow,),
                onTap: (() {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => ResetPassword())));
                }),
              ),
               ListTile(
                title: Text("Se déconnecter"),
                trailing: Icon(Icons.logout_rounded,color: Palette.yellow,),
                onTap: (() {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => Logout())));
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
