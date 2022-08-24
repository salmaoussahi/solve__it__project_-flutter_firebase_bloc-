import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/bloc/groupe/goupe_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';

import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutterfirebase/pages/groupe/groupe.addGroupe.dart';
import 'package:flutterfirebase/pages/groupe/groupe.otherGroupe.dart';
import 'package:flutterfirebase/pages/groupe/groupe.userGroupe.dart';

class Groupe extends StatefulWidget {
  Groupe({Key? key}) : super(key: key);

  @override
  State<Groupe> createState() => _GroupeState();
}

class _GroupeState extends State<Groupe> {
  void _userProblem(context) {
    BlocProvider.of<GoupeBloc>(context).add(UserGroupeRequested());
    BlocProvider.of<GoupeBloc>(context).add(UserOtherGroupeRequested());
  }

  @override
  void initState() {
    _userProblem(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddGroupe())));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Ajouter un groupe',
                  ),
                  Icon(
                    Icons.add,
                  ),
                ],
              ),
            ),
          ),
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
                        "Mes groupes",
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
            height: 20,
          ),
          SvgPicture.asset(
            "assets/images/group.svg",
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          ListTile(
            title: Text(
              "Admin",
            ),
            subtitle: Text(
              "Les groupes que j\'ai crée",
              style: TextStyle(color: Palette.grey),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => UserGroupe())));
            },
            trailing: Icon(
              Icons.arrow_right_outlined,
              color: Palette.grey,
            ),
          ),
          ListTile(
            title: Text(
              "Membre",
            ),
            subtitle: Text(
              "Les groupes dont je suis membre",
              style: TextStyle(color: Palette.grey),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => OtherGroup())));
            },
            trailing: Icon(
              Icons.arrow_right_outlined,
              color: Palette.grey,
            ),
          ),
        ],
      ),
    );
  }
}
