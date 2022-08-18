import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

// Lorsque l'utilisateur appuie sur le bouton de connexion ou d'inscription,
//l'état passe d'abord au chargement, puis à Authentifié.
class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

// Lorsque l'utilisateur est authentifié, l'état passe à Authentifié.
class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// C'est l'état initial du bloc. Lorsque l'utilisateur n'est pas authentifié,
//l'état passe à Non authentifié.
class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// Si une erreur se produit, l'état est changé en AuthError
class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
