import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/groupe.dart';
import 'package:flutterfirebase/pages/authentication.logout.dart';
import 'package:flutterfirebase/pages/accueil.user_problem.dart';
import 'package:flutterfirebase/pages/config.palette.dart';
import 'package:flutterfirebase/pages/setting.dart';
import 'package:flutterfirebase/pages/config.solvit.logo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final List screens = [Accueil(), Groupe(), Setting()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Accueil();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SlovitLogo(),
          ],
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.yellow,
        child: Icon(
          Icons.home,
          color: Palette.blue,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => HomePage())));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          color: Palette.blue,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = Groupe();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.people,
                            color: currentTab == 1
                                ? Palette.yellow
                                : Colors.white),
                        Text(
                          "Groupes",
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Palette.yellow
                                  : Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = Setting();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.settings,
                            size: 20,
                            color: currentTab == 2
                                ? Palette.yellow
                                : Colors.white),
                        Text(
                          "Parametre",
                          style: TextStyle(
                              color: currentTab == 2
                                  ? Palette.yellow
                                  : Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
