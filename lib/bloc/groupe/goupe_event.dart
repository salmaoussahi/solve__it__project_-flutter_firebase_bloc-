// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'goupe_bloc.dart';

abstract class GoupeEvent extends Equatable {
  const GoupeEvent();

  @override
  List<Object> get props => [];
}

// Lorsque l'utilisateur se dirige vesr la page "Groupes" ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class UserGroupeRequested extends GoupeEvent {}

// Lorsque l'utilisateur se dirige vesr la page "Groupes" ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class UserOtherGroupeRequested extends GoupeEvent {}

// Lorsque l'utilisateur demande l'ajout d'un nouveau groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//peffectuer le taitement
class AddGroupeRequested extends GoupeEvent {
  String libelle;
  String domaine;
  AddGroupeRequested({
    required this.libelle,
    required this.domaine,
  });
}

// Lorsque l'utilisateur supprimme un groupe ,
//cet événement est appelé et [Databaserepository] est appelé
//peffectuer le taitement
class DeleteGroupe extends GoupeEvent {
  String groupeId;

  DeleteGroupe({required this.groupeId});
}

class AddMembres extends GoupeEvent {
  String groupeId;
  var membres;

  AddMembres({required this.groupeId, required this.membres});
}

// Lorsque l'utilisateur se dirige vesr la page "Groupes" ,
//cet événement est appelé et [Databaserepository] est appelé
//pour afficher les données récupérés
class GroupMembresrquested extends GoupeEvent {
  String groupeId;
  GroupMembresrquested({
    required this.groupeId,
  });

}
