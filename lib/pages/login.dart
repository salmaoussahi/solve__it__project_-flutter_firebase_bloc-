import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/home.dart';
import 'package:flutterfirebase/pages/register.dart';
import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SlovitLogo(),
          Text(
            "Page de connexion",
            style: TextStyle(
                color: Palette.yellow,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: email,
                  decoration: new InputDecoration(
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      filled: true,
                      label: Text("Entrer votre email")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: new InputDecoration(
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      filled: true,
                      label: Text("Entrer votre email")),
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: Text("Connectez-vous", style: TextStyle(fontSize: 14)),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Palette.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ))),
            onPressed: () {
              print("object pressed ...");
              print(email.text);
              print(password.text);
              login();
            },
          ),
          Column(
            children: [
              Text("Vous n'avez pas de compte"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "Créer un compte",
                    style: TextStyle(
                      color: Palette.yellow,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  void login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
          print(user.email);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
