import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b23_firebase/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(Welcome model) async {
    DocumentReference documentReference = FirebaseFirestore.instance
    .collection("taskCollection")
    .doc();
    return await FirebaseFirestore.instance
        .collection('taskCollection')
    .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  ///Update Task
  Future updateTask(Welcome model) async{
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'title': model.title, 'decription': model.decripation});

  }
  ///Delete Task
   Future deleteTask (String taskID) async{
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();

   }
  ///Mark task as Complete
  Future markTaskAsComplete({
    required String taskID,
    required bool isCompleted,
  }) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': isCompleted});
  }

  ///Get All Task
  Stream<List<Welcome>> getAllTask(String userID) {

    return FirebaseFirestore.instance
        .collection('taskCollection')
    .where('UserID', isEqualTo: userID)
        .snapshots()
        .map(
          (taskList) => taskList.docs
          .map((taskJson) => Welcome.fromJson(taskJson.data()))
          .toList(),
    );
  }

  ///Get Completed Task
  Stream<List<Welcome>> getCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map(
          (taskList) => taskList.docs
          .map((taskJson) => Welcome.fromJson(taskJson.data()))
          .toList(),
    );
  }

  ///Get InCompleted Task
  Stream<List<Welcome>> getInCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map(
          (taskList) => taskList.docs
          .map((taskJson) => Welcome .fromJson(taskJson.data()))
          .toList(),
    );
  }
  /// Get Priority Task
   Stream<List<Welcome>> getPriorityTask(String priorityID) {
     return FirebaseFirestore.instance
         .collection('taskCollection')
         .where('priorityID', isEqualTo: priorityID)
         .snapshots().map((taskList) =>
         taskList.docs
             .map((taskjson) => Welcome.fromJson(taskjson.data()))
             .toList(),
     );
   }
}