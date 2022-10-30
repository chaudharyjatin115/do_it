// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:do_it/repositoires/base_todo_repository.dart';

import 'package:do_it/src/models/to_do_category_model.dart';
import 'package:do_it/src/services/auth_services/auth_error.dart';

class ToDoRepository extends BaseToDoRepository {
  final FirebaseFirestore _firebaseFirestore;
  ToDoRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> addToDoCategory(ToDoCategory toDoCategory, User user) async {
    try {
      _firebaseFirestore
          // .collection('users')
          // .doc(user.uid)
          .collection("todos")
          .doc()
          .set(toDoCategory.toDocument());
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Iterable<ToDoCategory>>> retrieveUserData(User user) {
    return _firebaseFirestore
        .collection("todos")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((e) => ToDoCategory.fromEntity(ToDoCategory.fromSnapShot(e))))
        .toList();
    // .doc(user.uid)
    // .collection('todos')
    // .get();

    // return snapshot.docs
    //     .map((docSnapshot) => ToDoCategory.fromSnapShot(docSnapshot))
    //     .toList();
  }

  // Stream<List<ToDoCategory>> retrieveToDos(User user) {
  //   final snapsho = _firebaseFirestore
  //       .collection("Users")
  //       .doc(user.uid)
  //       .collection('todos')
  //       .snapshots()
  //       .asyncMap((event) async {
  //     List<ToDoCategory> todos = [];
  //     for (var document in event.docs) {
  //       var todoCat = ToDoCategory.fromJson(document.data());

  //       todos.add(ToDoCategory(
  //           name: todoCat.name ?? 'hello',
  //           length: todoCat.length,
  //           toDoList: todoCat.toDoList,
  //           color: todoCat.color));
  //     }
  //     print(todos);
  //     return todos;
  //   });
  //   return snapsho;
  // }
}
