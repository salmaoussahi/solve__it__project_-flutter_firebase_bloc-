// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

// Lorsque l'utilisateur se dirige vesr la page "Groupes" ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class UserGroupeRequested extends DatabaseEvent {}

// Lorsque l'utilisateur se dirige vesr la page "Groupes" ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class UserOtherGroupeRequested extends DatabaseEvent {}

// Lorsque l'utilisateur se dirige vesr la page "Accueil" ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class UserProblemsRequested extends DatabaseEvent {}

// Lorsque l'utilisateur clique sur un groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class GroupProblemsRequested extends DatabaseEvent {
  String problemId;
  GroupProblemsRequested({
    required this.problemId,
  });
}

// Lorsque l'utilisateur clique sur un groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class ProblemCommentsRequested extends DatabaseEvent {
  String problemId;
  ProblemCommentsRequested({
    required this.problemId,
  });
}

// Lorsque l'utilisateur demande l'ajout d'un nouveau groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//peffectuer le taitement
class AddGroupeRequested extends DatabaseEvent {
  String libelle;
  String domaine;
  AddGroupeRequested({
    required this.libelle,
    required this.domaine,
  });
}

// Lorsque l'utilisateur ajoute un commentaire à un problème ,
//cet événement est appelé et [Databaserepository] est appelé
//peffectuer le taitement
class AddCommentRequested extends DatabaseEvent {
  String commentaire;
  String problemId;

  AddCommentRequested({required this.commentaire, required this.problemId});
}

// Lorsque l'utilisateur ajoute un groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//peffectuer le taitement
class AddProblemRequested extends DatabaseEvent {
  String intitule;
  String description;
  String groupeId;

  AddProblemRequested({
    required this.intitule,
    required this.description,
    required this.groupeId,
  });
}
