part of 'problem_bloc.dart';

abstract class ProblemEvent extends Equatable {
  const ProblemEvent();

  @override
  List<Object> get props => [];
}

// Lorsque l'utilisateur se dirige vesr la page "Accueil" ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class UserProblemsRequested extends ProblemEvent {}

// Lorsque l'utilisateur clique sur un groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class GroupProblemsRequested extends ProblemEvent {
  String problemId;
  GroupProblemsRequested({
    required this.problemId,
  });
}

// Lorsque l'utilisateur ajoute un groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//peffectuer le taitement
class AddProblemRequested extends ProblemEvent {
  String intitule;
  String description;
  String groupeId;

  AddProblemRequested({
    required this.intitule,
    required this.description,
    required this.groupeId,
  });
}
