part of 'goupe_bloc.dart';

abstract class GoupeState extends Equatable {
  const GoupeState();

  @override
  List<Object> get props => [];
}

class GoupeInitial extends GoupeState {}

/******************************************************************************/
/******************************l'état UserGroupe*******************************/

// Lorsque l'utilisateur se dirige vesr la page "Groupes",
//l'état passe d'abord au chargement Loading.
class LodingUserGroupe extends GoupeState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedUserGroupe extends GoupeState {
  Stream<QuerySnapshot> groupes;
  LoadedUserGroupe({
    required this.groupes,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorUserGroupe extends GoupeState {
  String errormessage;
  ErrorUserGroupe({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état UserOtherGroupe*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Groupes",
//l'état passe d'abord au chargement Loading.
class LodingUserOtherGroupe extends GoupeState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedUserOtherGroupe extends GoupeState {
  Stream<QuerySnapshot> othergroupes;
  LoadedUserOtherGroupe({
    required this.othergroupes,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorUserOtherGroupe extends GoupeState {
  String errormessage;
  ErrorUserOtherGroupe({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état AddGroup*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingAddGroup extends GoupeState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedAddGroup extends GoupeState {}

class InitialAddGroup extends GoupeState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorAddGroup extends GoupeState {
  String errormessage;
  ErrorAddGroup({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état AddMembres*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingAddMembres extends GoupeState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedAddMembres extends GoupeState {}

class InitialAddMembres extends GoupeState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorAddMembres extends GoupeState {
  String errormessage;
  ErrorAddMembres({
    required this.errormessage,
  });
}

/******************************************************************************/
/***************************l'état DeleteGroupe*****************************/

// Lorsque l'utilisateur se dirige vesr la page "Accueil",
//l'état passe d'abord au chargement Loading.
class LodingDeleteGroupe extends GoupeState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class GroupeDeleted extends GoupeState {}

class InitialDeleteGroupe extends GoupeState {}

// Si une erreur se produit, l'état est changé en Error
class ErrorDeleteGroupe extends GoupeState {
  String errormessage;
  ErrorDeleteGroupe({
    required this.errormessage,
  });
}

/******************************************************************************/
/******************************l'état GroupeMembres*******************************/

// Lorsque l'utilisateur se dirige vesr la page "Groupes",
//l'état passe d'abord au chargement Loading.
class LodingGroupeMembres extends GoupeState {}

// Lorsque les données sont chargées, l'état passe à Loaded.
class LoadedGroupeMembres extends GoupeState {
  Stream<QuerySnapshot> membres;
  LoadedGroupeMembres({
    required this.membres,
  });
}

// Si une erreur se produit, l'état est changé en Error
class ErrorGroupeMembres extends GoupeState {
  String errormessage;
  ErrorGroupeMembres({
    required this.errormessage,
  });
}