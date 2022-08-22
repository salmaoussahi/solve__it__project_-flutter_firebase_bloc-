import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';

class SlovitLogo extends StatelessWidget {
  const SlovitLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Text("Solve",
                    style: TextStyle(
                        color: state.themeData == MyTheme.darkTheme
                            ? Colors.white
                            : Palette.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold));
              },
            ),
            Text("-",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text("It",
                style: TextStyle(
                    color: Palette.yellow,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Container(
                  color: state.themeData == MyTheme.darkTheme
                      ? Colors.white
                      : Palette.blue,
                  height: 3,
                  width: MediaQuery.of(context).size.width * 0.14,
                );
              },
            ),
            Container(
              color: Palette.yellow,
              height: 3,
              width: MediaQuery.of(context).size.width * 0.14,
            ),
          ],
        )
      ],
    );
  }
}
