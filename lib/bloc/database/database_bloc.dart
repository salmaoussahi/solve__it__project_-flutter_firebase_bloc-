import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/repository/database.repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final Databaserepository databaserepository;
  DatabaseBloc({required this.databaserepository}) : super(DatabaseInitial()) {
    // Lorsque l'utilisateur se dirige vesr la page "Groupes",
// nous envoyons l'événement UserGroupeRequested à DatabaseBloc pour le gérer
    on<UserGroupeRequested>((event, emit) async {
      emit(LodingUserGroupe());
      try {
        emit(LoadedUserGroupe(groupes: await databaserepository.userGroupes()));
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
            othergroupes: await databaserepository.userOtherGroupes()));
      } catch (e) {
        emit(ErrorUserOtherGroupe(errormessage: e.toString()));
      }
    });

    // Lorsque l'utilisateur se dirige vesr la page "Accueil",
// nous envoyons l'événement UserProblemsRequested à DatabaseBloc pour le gérer
    on<UserProblemsRequested>((event, emit) async {
      emit(LodingUserProblems());
      try {
        emit(LoadedUserProblems(
            problems: await databaserepository.userProblems()));
      } catch (e) {
        emit(ErrorUserOtherGroupe(errormessage: e.toString()));
      }
    });

    // Lorsque l'utilisateur se dirige vesr la page "Accueil",
// nous envoyons l'événement UserProblemsRequested à DatabaseBloc pour le gérer
    on<GroupProblemsRequested>((event, emit) async {
      emit(LodingGroupProblems());
      try {
        emit(LoadedGroupProblems(
            problems: await databaserepository.groupProblems(event.problemId)));
      } catch (e) {
        emit(ErrorGroupProblems(errormessage: e.toString()));
      }
    });

    // Lorsque l'utilisateur se dirige vesr la page "Accueil",
// nous envoyons l'événement UserProblemsRequested à DatabaseBloc pour le gérer
    on<ProblemCommentsRequested>((event, emit) async {
      emit(LodingProblemComments());
      try {
        emit(LoadedProblemComments(
            comments:
                await databaserepository.problemComments(event.problemId)));
      } catch (e) {
        emit(ErrorProblemComments(errormessage: e.toString()));
      }
    });

    // Lorsque l'utilisateur créé un groupe,
// nous envoyons l'événement AddGroupeRequested à DatabaseBloc pour le gérer
    on<AddGroupeRequested>((event, emit) async {
      emit(LodingAddGroup());
      try {
        await databaserepository.addGroupe(
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

    // Lorsque l'utilisateur ajoute un commentaire,
// nous envoyons l'événement AddCommentRequested à DatabaseBloc pour le gérer
    on<AddCommentRequested>((event, emit) async {
      emit(LodingAddComment());
      try {
        await databaserepository.addComment(
            commentaire: event.commentaire,
            problemId: event.problemId,
            userEmail: FirebaseAuth.instance.currentUser!.email.toString(),
            valide: false,
            vote: 0);
        emit(LoadedAddComment());
      } catch (e) {
        emit(ErrorAddComment(errormessage: e.toString()));
        emit(InitialAddComment());
      }
    });

    // Lorsque l'utilisateur ajoute un problem,
// nous envoyons l'événement AddProblemRequested à DatabaseBloc pour le gérer
    on<AddProblemRequested>((event, emit) async {
      emit(LodingAddProblem());
      try {
        await databaserepository.addProblem(
            description: event.description,
            libelle: event.intitule,
            groupeId: event.groupeId,
            userEmail: FirebaseAuth.instance.currentUser!.email.toString(),
            userId: FirebaseAuth.instance.currentUser!.uid.toString(),
            isSolved: false);
        emit(LoadedAddProblem());
      } catch (e) {
        emit(ErrorAddProblem(errormessage: e.toString()));
        emit(InitialAddProblem());
      }
    });
    // Lorsque l'utilisateur ajoute un problem,
// nous envoyons l'événement DeleteGroupe à DatabaseBloc pour le gérer
    on<DeleteGroupe>((event, emit) async {
      emit(LodingDeleteGroupe());
      try {
        await databaserepository.deleteGroupe(event.groupeId);
        emit(GroupeDeleted());
      } catch (e) {
        emit(ErrorDeleteGroupe(errormessage: e.toString()));
        emit(InitialDeleteGroupe());
      }
    });
  }
}
