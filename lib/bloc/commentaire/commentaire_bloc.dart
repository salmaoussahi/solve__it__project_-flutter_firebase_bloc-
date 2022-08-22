// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutterfirebase/repository/commentaire.repository.dart';

part 'commentaire_event.dart';
part 'commentaire_state.dart';

class CommentaireBloc extends Bloc<CommentaireEvent, CommentaireState> {
  final CommentaireRepository commentairerepository;
  CommentaireBloc(
    {required this.commentairerepository}
  ) : super(CommentaireInitial()) {
    // Lorsque l'utilisateur se dirige vesr la page "Accueil",
// nous envoyons l'événement UserProblemsRequested à DatabaseBloc pour le gérer
    on<ProblemCommentsRequested>((event, emit) async {
      emit(LodingProblemComments());
      try {
        emit(LoadedProblemComments(
            comments:
                await commentairerepository.problemComments(event.problemId)));
      } catch (e) {
        emit(ErrorProblemComments(errormessage: e.toString()));
      }
    });

    // Lorsque l'utilisateur ajoute un commentaire,
// nous envoyons l'événement AddCommentRequested à DatabaseBloc pour le gérer
    on<AddCommentRequested>((event, emit) async {
      emit(LodingAddComment());
      try {
        await commentairerepository.addComment(
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
  }
}
