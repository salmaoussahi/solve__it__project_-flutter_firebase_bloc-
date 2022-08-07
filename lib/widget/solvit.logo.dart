import 'package:flutter/material.dart';
import 'package:flutterfirebase/palette.dart';

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
                    style: TextStyle(color: Palette.blue, fontSize: 42,fontWeight: FontWeight.bold)),
                Text("-",
                style: TextStyle(color: Colors.grey, fontSize: 42,fontWeight: FontWeight.bold)),
                Text("It",
                style: TextStyle(color: Palette.yellow, fontSize: 42,fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Palette.blue,
                  height: 5,
                  width: MediaQuery.of(context).size.width*0.2,
                ),
                Container(
                  color: Palette.yellow,
                  height: 5,
                  width: MediaQuery.of(context).size.width*0.2,
                ),
              ],
            )
      ],
    );
  }
}