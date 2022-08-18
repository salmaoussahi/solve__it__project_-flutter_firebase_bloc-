import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Lorsque l'utilisateur se connecte avec une adresse e-mail et un mot de passe, 
//cet événement est appelé et [AuthRepository] est appelé pour se connecter à l'utilisateur
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

// Lorsque l'utilisateur s'inscrit avec un e-mail et un mot de passe, cet événement est appelé et [AuthRepository] est appelé pour inscrire l'utilisateur
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String f_name;
  final String l_name;

  SignUpRequested(this.email, this.password,this.f_name,this.l_name);
}

// Lorsque l'utilisateur se connecte avec Google, cet événement est appelé et [AuthRepository] est appelé pour se connecter à l'utilisateur.
class GoogleSignInRequested extends AuthEvent {}

// Lorsque l'utilisateur se déconnecte, cet événement est appelé et [AuthRepository] est appelé pour déconnecter l'utilisateur
class SignOutRequested extends AuthEvent {}
