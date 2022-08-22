// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutterfirebase/repository/groupe.repository.dart';

part 'goupe_event.dart';
part 'goupe_state.dart';

class GoupeBloc extends Bloc<GoupeEvent, GoupeState> {
  final GroupeRepository grouperepository;
  GoupeBloc({
    required this.grouperepository,
  }) : super(GoupeInitial()) {
    // Lorsque l'utilisateur se dirige vesr la page "Groupes",
// nous envoyons l'événement UserGroupeRequested à DatabaseBloc pour le gérer
    on<UserGroupeRequested>((event, emit) async {
      emit(LodingUserGroupe());
      try {
        emit(LoadedUserGroupe(groupes: await grouperepository.userGroupes()));
      } catch (e) {
        emit(ErrorUserGroupe(errormessage: e.toString()));
      }
    });

    // Lorsque l'utilisateur se dirige vesr la page "Groupes",
// nous envoyons l'événement UserOtherGroupeRequested à DatabaseBloc pour le gérer
    on<UserOtherGroupeRequested>((event, emit) async {
      emit(LodingUserOtherGroupe());
      try {
        emit(LoadedUserOtherGroupe(
            othergroupes: await grouperepository.userOtherGroupes()));
      } catch (e) {
        emit(ErrorUserOtherGroupe(errormessage: e.toString()));
      }
    });
    // Lorsque l'utilisateur créé un groupe,
// nous envoyons l'événement AddGroupeRequested à DatabaseBloc pour le gérer
    on<AddGroupeRequested>((event, emit) async {
      emit(LodingAddGroup());
      try {
        await grouperepository.addGroupe(
            libelle: event.libelle,
            domaine: event.domaine,
            userId: FirebaseAuth.instance.currentUser!.uid.toString(),
            membres: [FirebaseAuth.instance.currentUser!.email].toList());
        emit(LoadedAddGroup());
      } catch (e) {
        emit(ErrorAddGroup(errormessage: e.toString()));
        emit(InitialAddGroup());
      }
    });
    // Lorsque l'utilisateur créé un groupe,
// nous envoyons l'événement AddMembersRequested à DatabaseBloc pour le gérer
    on<AddMembres>((event, emit) async {
      emit(LoadedAddMembres());
      try {
        await grouperepository.addMembre(event.groupeId, event.membres);
        emit(LoadedAddMembres());
        emit(InitialAddMembres());
      } catch (e) {
        emit(ErrorAddMembres(errormessage: e.toString()));
      }
    });
    // Lorsque l'utilisateur ajoute un problem,
// nous envoyons l'événement DeleteGroupe à DatabaseBloc pour le gérer
    on<DeleteGroupe>((event, emit) async {
      emit(LodingDeleteGroupe());
      try {
        await grouperepository.deleteGroupe(event.groupeId);
        emit(GroupeDeleted());
      } catch (e) {
        emit(ErrorDeleteGroupe(errormessage: e.toString()));
        emit(InitialDeleteGroupe());
      }
    });

    // Lorsque l'utilisateur se dirige vesr la page "Groupes",
// nous envoyons l'événement UserGroupeRequested à DatabaseBloc pour le gérer
    on<GroupMembresrquested>((event, emit) async {
      emit(LodingGroupeMembres());
      try {
        emit(LoadedGroupeMembres(
            membres: await grouperepository.groupeMembres(event.groupeId)));
        
      } catch (e) {
        emit(ErrorGroupeMembres(errormessage: e.toString()));
      }
    });
  }
}
