import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfirebase/bloc/language/language_bloc.dart';
import 'package:flutterfirebase/pages/authentication/authentication.signin.dart';
import 'package:flutterfirebase/pages/config/config.solvit.logo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/config.palette.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
        TextButton(onPressed: (() {
                          print('franc');
                          BlocProvider.of<LanguageBloc>(context)
                              .add(ToFrensh());
                        }), child: BlocBuilder<LanguageBloc, SelectedLangue>(
                          builder: (context, state) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Container(
                                height: 70.0,
                                width: 70.0,
                                color: state.locale == Locale("fr", "")
                                    ? Palette.grey
                                    : Colors.transparent,
                                child: Image.asset("assets/images/france.png"),
                              ),
                            );
                          },
                        )),
                        TextButton(
                          onPressed: (() {
                            print('eng');
                            BlocProvider.of<LanguageBloc>(context)
                                .add(ToEnglish());
                          }),
                          child: BlocBuilder<LanguageBloc, SelectedLangue>(
                              builder: (context, state) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Container(
                                height: 70.0,
                                width: 70.0,
                                color: state.locale == Locale("en", "")
                                    ? Palette.grey
                                    : Colors.transparent,
                                child: Image.asset(
                                    "assets/images/united-kingdom.png"),
                              ),
                            );
                          }),
                        ),
                        TextButton(
                          onPressed: (() {
                            print('arab');
                            BlocProvider.of<LanguageBloc>(context)
                                .add(ToArabic());
                          }),
                          child: BlocBuilder<LanguageBloc, SelectedLangue>(
                              builder: (context, state) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Container(
                                height: 70.0,
                                width: 70.0,
                                color: state.locale == Locale("ar", "")
                                    ? Palette.grey
                                    : Colors.transparent,
                                child: Image.asset("assets/images/arab.png"),
                              ),
                            );
                          }),
                        )
      ]),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SlovitLogo(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     SvgPicture.asset(
                //       "assets/lamp.svg",
                //       width: 50,
                //     )
                //   ],
                // ),
              ],
            ),
            SvgPicture.asset(
              "assets/images/image1.svg",
              width: 250,
            ),
            Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  minWidth: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    AppLocalizations.of(context)!.connecter_vous,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
