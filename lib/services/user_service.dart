// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  Future getUserData(String? uid) async {
    await firestoreInstance.collection("users").doc(uid).get().then((value) {
      print(
          "\n---------------------------------------------------------------\n");
      print(value.data());
      return value.data();
      print(
          "\n---------------------------------------------------------------\n");
    });
  }
}
