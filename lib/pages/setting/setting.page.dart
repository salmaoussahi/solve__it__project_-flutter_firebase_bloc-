import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_event.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutterfirebase/pages/setting/setting.profil.dart';
import 'package:flutterfirebase/pages/authentication/authentication.logout.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/setting/setting.reset_password.dart';

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
              Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return Text(
                        "Paramètre",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: state.themeData == MyTheme.darkTheme
                                ? Palette.yellow
                                : Palette.blue),
                      );
                    },
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SvgPicture.asset(
            "assets/setting.svg",
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          ListTile(
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Profil())));
            }),
            title: Text("Profil"),
            trailing: Icon(
              Icons.person,
              color: Palette.yellow,
            ),
          ),
          ListTile(
            title: Text("Thème"),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              //Dark Theme Button
              IconButton(onPressed: () {
                BlocProvider.of<ThemeBloc>(context)
                    .add(ThemeEvent(theme: MyTheme.darkTheme));
              }, icon: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return Icon(
                    Icons.dark_mode,
                    color: state.themeData == MyTheme.darkTheme
                        ? Palette.yellow
                        : Palette.grey,
                  );
                },
              )),

              //Light Theme Button

              IconButton(onPressed: () {
                BlocProvider.of<ThemeBloc>(context)
                    .add(ThemeEvent(theme: MyTheme.lightTheme));
              }, icon: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return Icon(
                    Icons.light_mode,
                    color: state.themeData == MyTheme.lightTheme
                        ? Palette.yellow
                        : Palette.grey,
                  );
                },
              )),
            ]),
          ),
          
          ListTile(
            title: Text("Modifier mot de passe"),
            trailing: Icon(
              Icons.password,
              color: Palette.yellow,
            ),
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ResetPassword())));
            }),
          ),
          ListTile(
            title: Text("Se déconnecter"),
            trailing: Icon(
              Icons.logout_rounded,
              color: Palette.yellow,
            ),
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Logout())));
            }),
          )
        ],
      ),
    );
  }
}
