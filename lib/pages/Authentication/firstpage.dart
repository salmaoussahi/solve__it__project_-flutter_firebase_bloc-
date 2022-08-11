import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfirebase/pages/Authentication/SignIn/signin.dart';

import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/repository/user.repository.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SlovitLogo(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/lamp.svg",
                      width: 50,
                    )
                  ],
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/image1.svg",
              width: 250,
            ),
            Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
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
