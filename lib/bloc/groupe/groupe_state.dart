part of 'groupe_bloc.dart';

abstract class GroupeState extends Equatable {}

// Lorsque l'utilisateur appuie sur le bouton de Créer un groupe, 
//l'état passe d'abord au chargement.
class Loading extends GroupeState {
  @override
  List<Object?> get props => [];
}

// Lorsque le groupe est ajouté, l'état passe à GroupeAdded.
class GroupeAdded extends GroupeState {
  @override
  List<Object?> get props => [];
}

// C'est l'état initial du bloc.
class GroupeInitial extends GroupeState {
  @override
  List<Object?> get props => [];
}

// Si une erreur se produit, l'état est changé en GroupError
class GroupError extends GroupeState {
  final String error;

  GroupError(this.error);
  @override
  List<Object?> get props => [error];
}