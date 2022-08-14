import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_bloc.dart';
import 'package:flutterfirebase/bloc/user/user_event.dart';
import 'package:flutterfirebase/bloc/user/user_state.dart';
import 'package:flutterfirebase/pages/Authentication/SignIn/signin.dart';
import 'package:flutterfirebase/pages/home.dart';
import 'package:flutterfirebase/pages/widget/palette.dart';
import 'package:flutterfirebase/pages/widget/solvit.logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _lnameController.dispose();
    _fnameController.dispose();
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
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  // Navigating to the dashboard screen if the user is authenticated
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }
                if (state is AuthError) {
                  // Displaying the error message if the user is not authenticated
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is Loading) {
                  // Displaying the loading indicator while the user is signing up
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is UnAuthenticated) {
                  // Displaying the sign up form if the user is not authenticated
                  return Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Créer un compte",
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                        controller: _fnameController,
                                        decoration: const InputDecoration(
                                          hintText: "Entrer votre prénom",
                                          border: OutlineInputBorder(),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _lnameController,
                                        decoration: const InputDecoration(
                                          hintText: "Entrer votre nom",
                                          border: OutlineInputBorder(),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _emailController,
                                        decoration: const InputDecoration(
                                          hintText: "Entrer votre email",
                                          border: OutlineInputBorder(),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return value != null &&
                                                  !EmailValidator.validate(value)
                                              ? 'Entrer un email valid'
                                              : null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        controller: _passwordController,
                                        decoration: const InputDecoration(
                                          hintText: "Entrer votre mot de passe",
                                          border: OutlineInputBorder(),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return value != null && value.length < 6
                                              ? "Enteer min. 6 caractères"
                                              : null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width * 0.7,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Palette.blue),
                                          onPressed: () {
                                            _createAccountWithEmailAndPassword(
                                                context);
                                          },
                                          child: const Text(
                                            'Créer un compte',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Text("Avez-vous déjà un compte"),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignIn()),
                                  );
                                },
                                child: const Text("Connecter-Vous"),
                              ),
                              const Text("Connectez-vous avec Google"),
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
          ],
        ),
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _emailController.text,
          _passwordController.text,
          _fnameController.text,
          _lnameController.text
        ),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
