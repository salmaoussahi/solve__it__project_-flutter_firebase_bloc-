import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/Authentication/Logout/logout.dart';
import 'package:flutterfirebase/pages/Accueil/accueil.dart';
import 'package:flutterfirebase/pages/Groupe/groupe.dart';
import 'package:flutterfirebase/pages/Setting/setting.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';
import 'package:flutterfirebase/pages/widget/solvit.logo.dart';

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
          Icons.add,
          color: Palette.blue,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          color: Palette.blue,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = Accueil();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.home,
                            color: currentTab == 0
                                ? Palette.yellow
                                : Colors.white),
                        Text(
                          "Accueil",
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Palette.yellow
                                  : Colors.white),
                        )
                      ],
                    ),
                  ),
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
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                        currentScreen = Logout();
                    });},
                    child: Column(
                      children: [
                        Icon(
                          Icons.logout,
                          color:
                              currentTab == 3 ? Palette.yellow : Colors.white,
                          size: 20,
                        ),
                        Text(
                          "Sortir",
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Palette.yellow
                                  : Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
