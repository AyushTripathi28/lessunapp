// // ignore_for_file: avoid_print

// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class StorageRepo {
//   FirebaseStorage _storage =
//       FirebaseStorage(storageBucket: "gs://profiletutorial-c5ed1.appspot.com");

//   Future<String> uploadFile(File file) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     var userId = user!.uid;

//     var storageRef = _storage.ref().child("user/profile/$userId");
//     var uploadTask = storageRef.putFile(file);
//     var completedTask = await uploadTask.onComplete;

//     String downloadUrl = await (completedTask).ref.getDownloadURL();
//     // var completedTask = await uploadTask.;

//     return downloadUrl;
//   }

//   Future<String> getUserProfileImage(String uid) async {
//     return await _storage.ref().child("user/profile/$uid").getDownloadURL();
//   }

//   uploadImagetFirebase(File file) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     var userId = user!.uid;
//     await FirebaseStorage.instance
//         .ref("user/profile/$userId")
//         .putFile(file)
//         .then((taskSnapshot) {
//       print("task done");

// // download url when it is uploaded
//       if (taskSnapshot.state == TaskState.success) {
//         FirebaseStorage.instance
//             .ref("user/profile/$userId")
//             .getDownloadURL()
//             .then((url) {
//           print("Here is the URL of Image $url");
//           return url;
//         }).catchError((onError) {
//           print("Got Error $onError");
//         });
//       }
//     });
//   }
// }
