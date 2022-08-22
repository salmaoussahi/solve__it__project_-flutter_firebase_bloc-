import 'package:cloud_firestore/cloud_firestore.dart';

class CommentaireRepository {
  //Afficher les commentaire d'un probleme
  Stream<QuerySnapshot<Map<String, dynamic>>> problemComments(problemId) {
    return FirebaseFirestore.instance
        .collection('Commentaire')
        .where("problemId", isEqualTo: problemId)
        .snapshots();
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
}
