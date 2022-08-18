import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/database/database_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/pages/firstpage.dart';
import 'package:flutterfirebase/repository/database.repository.dart';
import 'package:flutterfirebase/repository/user.repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthRepository(),
          ),
          RepositoryProvider(
            create: (context) => Databaserepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => DatabaseBloc(
                  databaserepository:
                      RepositoryProvider.of<Databaserepository>(context)),
            ),
            BlocProvider(
              create: (context) => AuthBloc(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context)),
            ),
            
          ],
          child: MaterialApp(
            title: 'Solve it',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.grey,
            ),
            // home: RegisterPage(),
            home: FirstPage(),
          ),
        ));
    // return MultiRepositoryProvider(
    //   providers: [
    //     RepositoryProvider(
    //         create: (context) => AuthBloc(
    //             authRepository:
    //                 RepositoryProvider.of<AuthRepository>(context))),
    //   ],
    //   child: MaterialApp(
    //     title: 'Solve it',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       primarySwatch: Colors.grey,
    //     ),
    //     home: FirstPage(),
    //   ),
    // );
  }
}
