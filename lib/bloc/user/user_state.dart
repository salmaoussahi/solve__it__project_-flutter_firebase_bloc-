import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

// Lorsque l'utilisateur appuie sur le bouton de connexion ou d'inscription,
//l'état passe d'abord au chargement, puis à Authentifié.
class Loading extends AuthState {}

// Lorsque l'utilisateur est authentifié, l'état passe à Authentifié.
class Authenticated extends AuthState {}

// C'est l'état initial du bloc. Lorsque l'utilisateur n'est pas authentifié,
//l'état passe à Non authentifié.
class UnAuthenticated extends AuthState {}

// Si une erreur se produit, l'état est changé en AuthError
class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

/******************************************************************************/
/***************************l'état UserProfil*****************************/

// Lorsque l'utilisateur se dirige vers son profil,
//l'état passe d'abord au chargement Loading.
class LodingUserProfil extends AuthState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedUserProfil extends AuthState {
  Future<DocumentSnapshot> profil;
  LoadedUserProfil({required this.profil});
}

// Si une erreur se produit, l'état est changé en Error
class ErrorUserProfil extends AuthState {
  String errormessage;
  ErrorUserProfil({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état UserProfilUpdate*****************************/

// Lorsque l'utilisateur se dirige vers son profil,
//l'état passe d'abord au chargement Loading.
class LodingUserProfilUpdate extends AuthState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedUserProfilUpdate extends AuthState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorUserProfilUpdate extends AuthState {
  String errormessage;
  ErrorUserProfilUpdate({
    required this.errormessage,
  });
  
}
