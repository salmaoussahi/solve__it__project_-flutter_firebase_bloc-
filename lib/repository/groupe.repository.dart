import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupeRepository {
  var groupe = FirebaseFirestore.instance.collection('Groupe');

  //Afficher les groupes d'un user
  Stream<QuerySnapshot<Map<String, dynamic>>> userGroupes() {
    return groupe
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  //Afficher les autres groupes dont il appartient
  Stream<QuerySnapshot<Map<String, dynamic>>> userOtherGroupes() {
    return groupe
        .where("userId", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  //Ajouter un groupe
  Future<void> addGroupe(
      {required String libelle,
      required String domaine,
      required var membres,
      required String userId}) async {
    try {
      await groupe.add({
        'libelle': libelle,
        'domaine': domaine,
        "userId": userId,
        "membres": membres
      }).catchError((error) => print("Error: $error"));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Supprimer un groupe avec ses problème et commentaire

  Future<void> deleteGroupe(String groupeId) async {
    FirebaseFirestore.instance.collection("Groupe").doc(groupeId).delete();
    FirebaseFirestore.instance
        .collection("Problem")
        .where("groupeId", isEqualTo: groupeId)
        .get()
        .then((value) {
      for (DocumentSnapshot ds in value.docs) {
        FirebaseFirestore.instance
            .collection("Commentaire")
            .where("problemId", isEqualTo: ds.reference.id)
            .get()
            .then((value) {
          for (DocumentSnapshot ds in value.docs) {
            ds.reference.delete();
          }
        });
        ds.reference.delete();
      }
    });
  }

  Future<void> addMembre(String groupeId, var membreslist) {
    return FirebaseFirestore.instance
        .collection('Groupe')
        .doc(groupeId)
        .update({'membres': FieldValue.arrayUnion(membreslist)})
        .then((value) => print("Users Added to Group"))
        .catchError((error) => print("Failed to add users: $error"));
  }

  //Afficher les membres d'un groupe
  Stream<QuerySnapshot<Map<String, dynamic>>> groupeMembres(String groupeId) {
    return groupe.where('id', isEqualTo: groupeId).snapshots();
  }
}
