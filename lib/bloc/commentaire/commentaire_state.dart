part of 'commentaire_bloc.dart';

abstract class CommentaireState extends Equatable {
  const CommentaireState();
  
  @override
  List<Object> get props => [];
}

class CommentaireInitial extends CommentaireState {}


/******************************************************************************/
/***************************l'état ProblemComments*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingProblemComments extends CommentaireState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedProblemComments extends CommentaireState {
  Stream<QuerySnapshot> comments;
  LoadedProblemComments({
    required this.comments,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorProblemComments extends CommentaireState {
  String errormessage;
  ErrorProblemComments({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état AddComment*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingAddComment extends CommentaireState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedAddComment extends CommentaireState {}

class InitialAddComment extends CommentaireState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorAddComment extends CommentaireState {
  String errormessage;
  ErrorAddComment({
    required this.errormessage,
  });
}
