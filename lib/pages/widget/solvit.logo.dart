import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';

class SlovitLogo extends StatelessWidget {
  const SlovitLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
         Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Solve",
                    style: TextStyle(color: Palette.blue, fontSize: 30,fontWeight: FontWeight.bold)),
                Text("-",
                style: TextStyle(color: Colors.grey, fontSize: 30,fontWeight: FontWeight.bold)),
                Text("It",
                style: TextStyle(color: Palette.yellow, fontSize: 30,fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Palette.blue,
                  height: 3,
                  width: MediaQuery.of(context).size.width*0.14,
                ),
                Container(
                  color: Palette.yellow,
                  height: 3,
                  width: MediaQuery.of(context).size.width*0.14,
                ),
              ],
            )
      ],
    );
  }
}