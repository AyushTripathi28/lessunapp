// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

class UserService {
  Future getUserData(String? uid) async {
    // var userList = [];

    DocumentSnapshot data = await users.doc(uid).get();
    print(data.data());

    // var userData = await users.doc(uid).get();
    // return User.fromMap(userData.data());
    // await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Document data: ${documentSnapshot.data()}');
    //     print(documentSnapshot.data().runtimeType);
    //     // Map<String, dynamic>.from(documentSnapshot.data());
    //     // User? u;
    //     // documentSnapshot.data()?.foreach((k, v) => user_list.add(User(
    //     //     username: '', name: '', profilepic: '', about: '', email: '')));
    //     print(user_list);

    //     // return User.fromMap(documentSnapshot.data());
    //     // return documentSnapshot.data();
    //   } else {
    //     print('Document does not exist on the database');
    //   }
    // });
    // await users.doc(uid).get().then(
    //   (value) {
    //     Map<String, dynamic> data = value.data() as Map<String, dynamic>;
    //     print(
    //         "\n---------------------------------------------------------------\n");
    //     print(data);
    //     return data;
    //   },
    // );
  }
}

class GetUserData extends StatelessWidget {
  final String documentId;

  const GetUserData(this.documentId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}
