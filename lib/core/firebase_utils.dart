import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app_c11/core/utils.dart';
import 'package:todo_app_c11/model/task_model.dart';

import '../services/snack_bar_service.dart';

class FirebaseUtils {
  static CollectionReference<TaskModel> getCollectionRef() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.firestore(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toFirestore(),
        );
  }

  static Future<void> addTaskToFirestore(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;

    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> getOnTimeReadFromFirestore(
      DateTime selectedDate) async {
    var collectionRef = getCollectionRef().where(
      "selectedDate",
      isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch,
    );
    QuerySnapshot<TaskModel> docs = await collectionRef.get();
    List<TaskModel> tasksList = docs.docs.map((e) => e.data()).toList();
    print(tasksList.length);
    return tasksList;
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFirestore(
      DateTime selectedDate) {
    var collectionRef = getCollectionRef().where(
      "selectedDate",
      isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch,
    );
    return collectionRef.snapshots();
  }

  static Future<void> deleteTask(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    taskModel.isDone = true;
    return docRef.update(
      taskModel.toFirestore(),
    );
  }

  static Future<bool> createAccount(
      String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        EasyLoading.dismiss();

        SnackBarService.showErrorMessage("The password provided is too weak");

        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        EasyLoading.dismiss();

        SnackBarService.showErrorMessage(
            "The account already exists for that email.");
        return Future.value(false);
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();

      return Future.value(false);
    }
    return Future.value(false);
  }

  static Future<bool> signIn(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No User found for that email');
        EasyLoading.dismiss();

        SnackBarService.showErrorMessage("The password provided is too weak");

        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        print('wrong password provided for that user');
        EasyLoading.dismiss();

        SnackBarService.showErrorMessage(
            "The account already exists for that user.");

        return Future.value(false);
      }
    } catch (e) {
      print(e);
    }
    return Future.value(false);
  }
}
