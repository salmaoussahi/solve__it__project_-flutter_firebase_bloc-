part of 'commentaire_bloc.dart';

abstract class CommentaireEvent extends Equatable {
  const CommentaireEvent();

  @override
  List<Object> get props => [];
}

// Lorsque l'utilisateur clique sur un groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class ProblemCommentsRequested extends CommentaireEvent {
  String problemId;
  ProblemCommentsRequested({
    required this.problemId,
  });
}

// Lorsque l'utilisateur ajoute un commentaire à un problème ,
//cet événement est appelé et [Databaserepository] est appelé
//peffectuer le taitement
class AddCommentRequested extends CommentaireEvent {
  String commentaire;
  String problemId;

  AddCommentRequested({required this.commentaire, required this.problemId});
}
