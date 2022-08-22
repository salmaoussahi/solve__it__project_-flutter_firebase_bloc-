import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProblemRepository {
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
