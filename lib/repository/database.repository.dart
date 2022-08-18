import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Databaserepository {
  //Afficher les groupes d'un user
  Stream<QuerySnapshot<Map<String, dynamic>>> userGroupes() {
    return FirebaseFirestore.instance
        .collection('Groupe')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  //Afficher les autres groupes dont il appartient
  Stream<QuerySnapshot<Map<String, dynamic>>> userOtherGroupes() {
    return FirebaseFirestore.instance
        .collection('Groupe')
        .where("userId", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  //Afficher les problème d'un user
  Stream<QuerySnapshot<Map<String, dynamic>>> userProblems() {
    return FirebaseFirestore.instance
        .collection('Problem')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  //Afficher les problème d'un Group
  Stream<QuerySnapshot<Map<String, dynamic>>> groupProblems(groupeId) {
    return FirebaseFirestore.instance
        .collection('Problem')
        .where("groupeId", isEqualTo: groupeId)
        .snapshots();
  }

  //Afficher les commentaire d'un probleme
  Stream<QuerySnapshot<Map<String, dynamic>>> problemComments(problemId) {
    return FirebaseFirestore.instance
        .collection('Commentaire')
        .where("problemId", isEqualTo: problemId)
        .snapshots();
  }

  //Ajouter un groupe
  Future<void> addGroupe(
      {required String libelle,
      required String domaine,
      required var membres,
      required String userId}) async {
    try {
      await FirebaseFirestore.instance.collection('Groupe').add({
        'libelle': libelle,
        'domaine': domaine,
        "userId": userId,
        "membres": membres
      }).catchError((error) => print("Error: $error"));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//Ajouter un commentaire
  Future<void> addComment({
    required String commentaire,
    required String problemId,
    required String userEmail,
    required bool valide,
    required int vote,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('Commentaire').add({
        "commentaire": commentaire,
        "valide": valide,
        "vote": vote,
        "problemId": problemId,
        "userEmail": userEmail
      }).catchError((error) => print("Error: $error"));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//Ajouter un problem
  Future<void> addProblem({
    required String description,
    required String libelle,
    required String groupeId,
    required String userEmail,
    required String userId,
    required bool isSolved,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('Problem').add({
        "description": description,
        "libelle": libelle,
        "isSolved": isSolved,
        "groupeId": groupeId,
        "userId": userId,
        "userEmail": userEmail
      }).catchError((error) => print("Error: $error"));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
