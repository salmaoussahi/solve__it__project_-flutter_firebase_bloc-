import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfirebase/pages/groupe.addGroupe.dart';
import 'package:flutterfirebase/pages/groupe.othergroupe.dart';
import 'package:flutterfirebase/pages/groupe.usergroupe.dart';
import 'package:flutterfirebase/pages/config.palette.dart';

import '../bloc/database/database_bloc.dart';

class Groupe extends StatefulWidget {
  Groupe({Key? key}) : super(key: key);

  @override
  State<Groupe> createState() => _GroupeState();
}

class _GroupeState extends State<Groupe> {
  void _userProblem(context) {
    BlocProvider.of<DatabaseBloc>(context).add(UserGroupeRequested());
    BlocProvider.of<DatabaseBloc>(context).add(UserOtherGroupeRequested());
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
              style: ElevatedButton.styleFrom(primary: Palette.blue),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddGroupe())));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Ajouter un groupe',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
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
              Text(
                "Mes groupes",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SvgPicture.asset(
            "assets/group.svg",
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          ListTile(
            title: Text(
              "Admin",
              style: TextStyle(color: Palette.blue),
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
              style: TextStyle(color: Palette.blue),
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
