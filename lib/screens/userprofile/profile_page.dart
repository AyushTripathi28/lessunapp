// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lessunapp/services/user_service.dart';
import 'package:lessunapp/sharedPref/sharedPref.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _userName;
  String? _userEmail;
  String? _userAbout;
  String? _userImage;
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  void getUserData() async {
    print("----------------Accesing DATA-----------------------------------");
    User? user = FirebaseAuth.instance.currentUser;
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      _userName = result['name'];
      _userEmail = result['email'];
      _userAbout = result['about'];
      _userImage = result['profilepic'];
    });
    print("----------------Accesing DATA-----------------------------------");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Profile',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
            ),
          ],
        ),
        backgroundColor: Color(0xffEDF1FE),
        body: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              CircleAvatar(
                radius: 73,
                backgroundColor: Colors.orangeAccent,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(_userImage != ""
                      ? _userImage!
                      : "assets/images/profilepic.png"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(_userName != "" ? _userName! : "Anonymous User",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(_userEmail != "" ? _userEmail! : "No Email",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.black)),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("About Me:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SizedBox(
                        height: 10,
                      ),
                      LimitedBox(
                        maxWidth: size.width * 0.9,
                        child: Text(
                            _userAbout != "" ? _userAbout! : "No About Me",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
