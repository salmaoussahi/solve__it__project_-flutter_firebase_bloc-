import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/commentaire/commentaire_bloc.dart';
import 'package:flutterfirebase/bloc/groupe/goupe_bloc.dart';
import 'package:flutterfirebase/bloc/language/language_bloc.dart';

import 'package:flutterfirebase/bloc/problem/problem_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_bloc.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/pages/firstpage.dart';
import 'package:flutterfirebase/repository/commentaire.repository.dart';
import 'package:flutterfirebase/repository/groupe.repository.dart';
import 'package:flutterfirebase/repository/problem.repository.dart';
import 'package:flutterfirebase/repository/user.repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthRepository(),
          ),
          RepositoryProvider(
            create: (context) => GroupeRepository(),
          ),
          RepositoryProvider(
            create: (context) => CommentaireRepository(),
          ),
          RepositoryProvider(
            create: (context) => ProblemRepository(),
          ),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: ((context) => ThemeBloc())),
              BlocProvider(create: ((context) => LanguageBloc())),
              BlocProvider(
                  create: (context) => GoupeBloc(
                        grouperepository:
                            RepositoryProvider.of<GroupeRepository>(context),
                      )),
              BlocProvider(
                  create: (context) => CommentaireBloc(
                        commentairerepository:
                            RepositoryProvider.of<CommentaireRepository>(
                                context),
                      )),
              BlocProvider(
                  create: (context) => ProblemBloc(
                        problemRepository:
                            RepositoryProvider.of<ProblemRepository>(context),
                      )),
              BlocProvider(
                create: (context) => AuthBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepository>(context)),
              ),
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return BlocBuilder<LanguageBloc, SelectedLangue>(
                  builder: (context, languestate) {
                    print(languestate.locale);
                    return MaterialApp(
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      locale: languestate.locale,
                      title: 'Solve it',
                      debugShowCheckedModeBanner: false,
                      theme: state.themeData,
                      home: FirstPage(),
                    );
                  },
                );
              },
            )));
  }
}
