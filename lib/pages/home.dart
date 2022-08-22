import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_event.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/pages/config/config.theme.dart';
import 'package:flutterfirebase/pages/groupe/groupe.page.dart';
import 'package:flutterfirebase/pages/problem/problem.userProblem.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';
import 'package:flutterfirebase/pages/setting/setting.page.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SlovitLogo(),
            Row(mainAxisSize: MainAxisSize.min, children: [
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
          color: Colors.white,
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
