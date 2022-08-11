import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_event.dart';
import 'package:flutterfirebase/bloc/user/user_state.dart';
import 'package:flutterfirebase/pages/Authentication/SignUp/signup.dart';
import 'package:flutterfirebase/pages/Authentication/forgot_password.dart';
import 'package:flutterfirebase/pages/home.dart';
import 'package:flutterfirebase/palette.dart';
import 'package:flutterfirebase/widget/solvit.logo.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SlovitLogo(),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is UnAuthenticated) {
                    return Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SingleChildScrollView(
                            reverse: true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Page de Connexion",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Center(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            hintText: "Entrer votre email",
                                            border: OutlineInputBorder(),
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            return value != null &&
                                                    !EmailValidator.validate(
                                                        value)
                                                ? 'Enter a valid email'
                                                : null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          keyboardType: TextInputType.text,
                                          controller: _passwordController,
                                          decoration: const InputDecoration(
                                            hintText:
                                                "Entrer votre mot de passe",
                                            border: OutlineInputBorder(),
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            return value != null &&
                                                    value.length < 6
                                                ? "Enter min. 6 characters"
                                                : null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Palette.blue),
                                            onPressed: () {
                                              _authenticateWithEmailAndPassword(
                                                  context);
                                            },
                                            child: const Text(
                                              'Connecter-Vous',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          ForgotPassword())));
                                            },
                                            child: Text(
                                              'Vous avez oublier votre mot de passe',
                                              style: TextStyle(
                                                  color: Palette.yellow),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _authenticateWithGoogle(context);
                                  },
                                  icon: Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            Column(
              children: [
                const Text("Vous n'avez pas de compte?"),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text("Créer un compte"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
