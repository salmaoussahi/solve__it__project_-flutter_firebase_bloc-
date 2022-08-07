import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfirebase/pages/login.dart';
import 'package:flutterfirebase/pages/register.dart';
import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Column(children: [
             SlovitLogo(),
           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            SvgPicture.asset("assets/lamp.svg",width: 50,)
           ],),
          ],),
           SvgPicture.asset("assets/image1.svg",width: 250,),
           Column(
            children: [
              MaterialButton(
                onPressed: () {},
                color: Palette.grey,
                minWidth: MediaQuery.of(context).size.width * 0.9,
                child: Text("Créer un  groupe",
                    style: TextStyle(color: Colors.white)),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                color: Palette.blue,
                minWidth: MediaQuery.of(context).size.width * 0.9,
                child: Text("Connecter vous !",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          )
          ],
        ),
      ),
    );
  }
}
