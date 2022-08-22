// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/repository/problem.repository.dart';

part 'problem_event.dart';
part 'problem_state.dart';

class ProblemBloc extends Bloc<ProblemEvent, ProblemState> {
  final ProblemRepository problemRepository;
  ProblemBloc({required this.problemRepository}) : super(ProblemInitial()) {
    // Lorsque l'utilisateur se dirige vesr la page "Accueil",
// nous envoyons l'événement UserProblemsRequested à DatabaseBloc pour le gérer
    on<UserProblemsRequested>((event, emit) async {
      emit(LodingUserProblems());
      try {
        emit(LoadedUserProblems(
            problems: await problemRepository.userProblems()));
      } catch (e) {
        emit(ErrorUserProblems(errormessage: e.toString()));
      }
    });

    // Lorsque l'utilisateur se dirige vesr la page "Accueil",
// nous envoyons l'événement UserProblemsRequested à DatabaseBloc pour le gérer
    on<GroupProblemsRequested>((event, emit) async {
      emit(LodingGroupProblems());
      try {
        emit(LoadedGroupProblems(
            problems: await problemRepository.groupProblems(event.problemId)));
      } catch (e) {
        emit(ErrorGroupProblems(errormessage: e.toString()));
      }
      emit(LoadedGroupProblems(
          problems: await problemRepository.groupProblems(event.problemId)));
    });
    // Lorsque l'utilisateur ajoute un problem,
// nous envoyons l'événement AddProblemRequested à DatabaseBloc pour le gérer
    on<AddProblemRequested>((event, emit) async {
      emit(LodingAddProblem());
      try {
        await problemRepository.addProblem(
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
  }
}
