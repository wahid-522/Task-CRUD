import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b23_firebase/models/priority.dart';
class PriorityServices {
  ///Create Priority
  Future createPriority(PriorityModel model) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc();
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///Update Priority
  Future updatePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(model.docId)
        .update({'name': model.name});
  }

  ///Delete Priority
  Future deletePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(model.docId)
        .delete();
  }

  ///Get All Priorities
  Stream<List<PriorityModel>> getAllPriorities() {
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .snapshots()
        .map((priorityList) {
      return priorityList.docs.map((doc) {
        final data = doc.data();
        data['docID'] = doc.id;
        return PriorityModel.fromJson(data);
      }).toList();
    });
  }
}