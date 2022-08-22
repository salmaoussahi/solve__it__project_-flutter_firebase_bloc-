part of 'problem_bloc.dart';

abstract class ProblemState extends Equatable {
  const ProblemState();

  @override
  List<Object> get props => [];
}

class ProblemInitial extends ProblemState {}

/******************************************************************************/
/***************************l'état UserProblems*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingUserProblems extends ProblemState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedUserProblems extends ProblemState {
  Stream<QuerySnapshot> problems;
  LoadedUserProblems({
    required this.problems,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorUserProblems extends ProblemState {
  String errormessage;
  ErrorUserProblems({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état UserProblems*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingGroupProblems extends ProblemState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedGroupProblems extends ProblemState {
  Stream<QuerySnapshot> problems;
  LoadedGroupProblems({
    required this.problems,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorGroupProblems extends ProblemState {
  String errormessage;
  ErrorGroupProblems({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état AddProblems*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingAddProblem extends ProblemState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedAddProblem extends ProblemState {}

class InitialAddProblem extends ProblemState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorAddProblem extends ProblemState {
  String errormessage;
  ErrorAddProblem({
    required this.errormessage,
  });
}
