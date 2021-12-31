// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lessunapp/screens/userprofile/profile_page.dart';
import 'package:lessunapp/widgets/profile_photo.dart';
import 'package:lessunapp/widgets/textfield.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _userName;
  String? _userEmail;
  String? _userAbout;
  String? _userImage;
  TextEditingController? _aboutController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  setUserData() async {
    print(_userName);
    print(_userEmail);
    print(_aboutController!.text);
    print(_userImage);
    final DocumentReference documentReference =
        await FirebaseFirestore.instance.collection('users').doc(user!.uid);
    documentReference.update({
      'name': _userName,
      'email': _userEmail,
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
      _userName = result['name'];
      _userEmail = result['email'];
      _aboutController = TextEditingController(text: result['about']);
      _userImage = result['profilepic'];
    });
    print("----------------Accesing DATA-----------------------------------");
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
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.black),
            onPressed: () async {
              await setUserData();
              // Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfilePhoto(
            imagePath:
                _userImage != "" ? _userImage! : "assets/images/profilepic.png",
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: _userName != "" ? _userName! : "",
            onChanged: (name) {},
          ),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: _userEmail != "" ? _userEmail! : "",
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          // TextFieldWidget(
          //   label: 'About',
          //   text: _userAbout != "" ? _userAbout! : "",
          //   maxLines: 5,
          //   onChanged: (about) {},
          // ),
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
