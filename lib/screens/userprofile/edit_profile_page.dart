// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lessunapp/widgets/profile_photo.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _userName;
  // String? _userEmail;
  // String? _userAbout;
  String? _userImage;
  TextEditingController? _aboutController = TextEditingController();
  TextEditingController? _nameController = TextEditingController();
  // TextEditingController? _emailController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  setUserData() async {
    print(_userName);
    // print(_userEmail);
    print(_aboutController!.text);
    print(_userImage);
    final DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    documentReference.update({
      'name': _nameController!.text,
      // 'email': _userEmail,
      'about': _aboutController!.text,
      'profilepic': _userImage,
    });
  }

  void getUserData() async {
    print("----------------Accesing DATA-----------------------------------");

    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      // _userName = result['name'];
      // _userEmail = result['email'];
      _aboutController = TextEditingController(text: result['about']);
      _nameController = TextEditingController(text: result['name']);
      _userImage = result['profilepic'];
    });
    print("----------------Accesing DATA-----------------------------------");
  }

  File? image;

  Future pickImage() async {
    try {
      print("object");
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      print("object1hkbfluiKHFnaslikfh");
      print(image!.path);
      // if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        uploadImagetFirebase(this.image);
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  uploadImagetFirebase(File? file) async {
    User? user = FirebaseAuth.instance.currentUser;
    var userId = user!.uid;
    await FirebaseStorage.instance
        .ref("user/profile/$userId")
        .putFile(file!)
        .then((taskSnapshot) {
      print("task done");

// download url when it is uploaded
      if (taskSnapshot.state == TaskState.success) {
        FirebaseStorage.instance
            .ref("user/profile/$userId")
            .getDownloadURL()
            .then((url) {
          print("Here is the URL of Image $url");
          setState(() {
            _userImage = url;
            print(_userImage);
          });
          return url;
        }).catchError((onError) {
          print("Got Error $onError");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xffEDF1F5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, "/profilePage"),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.black),
            onPressed: () async {
              await setUserData();
              // Navigator.popAndPushNamed(context, routeName)
              Navigator.pushReplacementNamed(context, "/profilePage");
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfilePhoto(
            imagePath: _userImage != null ? _userImage! : "",
            isEdit: true,
            onClicked: () {
              print("clicked");
              pickImage();
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Full Name',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 1,
          ),
          SizedBox(height: 24),
          Text(
            'About',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextField(
            controller: _aboutController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

     // TextFieldWidget(
          //   label: 'Full Name',
          //   text: _userName != "" ? _userName! : "",
          //   onChanged: (name) {},
          // ),


          // const SizedBox(height: 24),
          // TextFieldWidget(
          //   label: 'About',
          //   text: _userAbout != "" ? _userAbout! : "",
          //   maxLines: 5,
          //   onChanged: (about) {},
          // ),
