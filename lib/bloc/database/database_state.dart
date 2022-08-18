// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object> get props => [];
}

/******************************************************************************/
/*******************************l'état initiale********************************/
class DatabaseInitial extends DatabaseState {}

/******************************************************************************/
/******************************l'état UserGroupe*******************************/

// Lorsque l'utilisateur se dirige vesr la page "Groupes",
//l'état passe d'abord au chargement Loading.
class LodingUserGroupe extends DatabaseState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedUserGroupe extends DatabaseState {
  Stream<QuerySnapshot> groupes;
  LoadedUserGroupe({
    required this.groupes,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorUserGroupe extends DatabaseState {
  String errormessage;
  ErrorUserGroupe({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état UserOtherGroupe*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Groupes",
//l'état passe d'abord au chargement Loading.
class LodingUserOtherGroupe extends DatabaseState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedUserOtherGroupe extends DatabaseState {
  Stream<QuerySnapshot> othergroupes;
  LoadedUserOtherGroupe({
    required this.othergroupes,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorUserOtherGroupe extends DatabaseState {
  String errormessage;
  ErrorUserOtherGroupe({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état UserProblems*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingUserProblems extends DatabaseState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedUserProblems extends DatabaseState {
  Stream<QuerySnapshot> problems;
  LoadedUserProblems({
    required this.problems,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorUserProblems extends DatabaseState {
  String errormessage;
  ErrorUserProblems({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état UserProblems*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingGroupProblems extends DatabaseState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedGroupProblems extends DatabaseState {
  Stream<QuerySnapshot> problems;
  LoadedGroupProblems({
    required this.problems,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorGroupProblems extends DatabaseState {
  String errormessage;
  ErrorGroupProblems({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état ProblemComments*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingProblemComments extends DatabaseState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedProblemComments extends DatabaseState {
  Stream<QuerySnapshot> comments;
  LoadedProblemComments({
    required this.comments,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorProblemComments extends DatabaseState {
  String errormessage;
  ErrorProblemComments({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état AddGroup*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingAddGroup extends DatabaseState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedAddGroup extends DatabaseState {}

class InitialAddGroup extends DatabaseState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorAddGroup extends DatabaseState {
  String errormessage;
  ErrorAddGroup({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état AddComment*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingAddComment extends DatabaseState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedAddComment extends DatabaseState {}

class InitialAddComment extends DatabaseState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorAddComment extends DatabaseState {
  String errormessage;
  ErrorAddComment({
    required this.errormessage,
  });
}


/******************************************************************************/
/***************************l'état AddProblems*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingAddProblem extends DatabaseState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedAddProblem extends DatabaseState {}

class InitialAddProblem extends DatabaseState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorAddProblem extends DatabaseState {
  String errormessage;
  ErrorAddProblem({
    required this.errormessage,
  });
}