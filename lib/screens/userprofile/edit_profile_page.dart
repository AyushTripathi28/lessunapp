// ignore_for_file: prefer_const_constructors

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
  @override
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
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfilePhoto(
            imagePath: "assets/images/profilepic.png",
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: "Ayush Tripathi",
            onChanged: (name) {},
          ),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: "ayushtripathi445@gmail.com",
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: "I am in Chandigarh University",
            maxLines: 5,
            onChanged: (about) {},
          ),
        ],
      ),
    );
  }
}
