// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtherUserProfilePage extends StatefulWidget {
  const OtherUserProfilePage({Key? key, this.uid}) : super(key: key);
  final String? uid;

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  String _userName = "";
  String _userEmail = "";
  String _userAbout = "";
  String _userImage = "";
  List _userFollowers = [];
  List _userFollowing = [];
  List _userPosts = [];
  // List _userBlock = [];
  bool _isUserBlock = false;

  User? user = FirebaseAuth.instance.currentUser;
  // print(widget.uid);
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  // checkIfFollowing()  {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   print(widget.uid);

  //   return _u;
  // }

  void getUserData() async {
    print("----------------Accesing DATA-----------------------------------");

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      List blkList = value["blockUser"];
      print(blkList);
      if (blkList.contains(widget.uid)) {
        setState(() {
          _isUserBlock = true;
        });
      }

      print(blkList.contains(widget.uid));
    });
    // if (value["blockUser"].map != null) {
    //   if (value["block"].contains(widget.uid)) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
    //   return false;
    // }
    // });

    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    setState(() {
      _userName = result["name"].toString();
      _userEmail = result["email"].toString();
      _userAbout = result["about"].toString();
      _userImage = result["profilepic"].toString();
      _userFollowers = result["followers"];
      _userFollowing = result["followings"];
      _userPosts = result["postMade"];
    });
    print({_userPosts, _userFollowing, _userFollowers});
    print("---------------- DATA Access-----------------------------------");
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
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (item) => onSelected(context, item as int),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    _isUserBlock ? "Unblock User" : "Block User",
                    style: TextStyle(fontSize: 13),
                  ),
                  value: 0,
                ),
              ],
            ),
            // IconButton(
            //   icon: Icon(Icons.more_vert, color: Colors.black),
            //   onPressed: () {},
            // ),
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
                  backgroundImage: _userImage.isNotEmpty
                      ? NetworkImage(
                          _userImage,
                        )
                      : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(_userName,
                  // != "" ? _userName! : "Anonymous User",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(_userEmail,
                  //  != "" ? _userEmail! : "No Email",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.black)),
              // if (user)
              _isUserBlock
                  ? Text("First unblock user")
                  : _userFollowers.contains(user!.uid)
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _userFollowers.remove(user!.uid);
                            });
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.uid)
                                .update({
                              'followers': FieldValue.arrayRemove([user!.uid])
                            });
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .update({
                              'followings': FieldValue.arrayRemove([user!.uid])
                            });
                          },
                          child: Text("Unfollow"),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _userFollowers.add(user!.uid);
                            });

                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.uid)
                                .update({
                              'followers': FieldValue.arrayUnion([user!.uid])
                            });
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .update({
                              'followings': FieldValue.arrayUnion([user!.uid])
                            });
                          },
                          child: Text("Follow"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Chip(
                    label: Row(
                      children: [
                        Text(_userPosts.length.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.green)),
                        Text(' Posts',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  Chip(
                    label: Row(
                      children: [
                        Text(_userFollowers.length.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.green)),
                        Text(' Followers',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  Chip(
                    label: Row(
                      children: [
                        Text(_userFollowing.length.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.green)),
                        Text(' followings',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                      ],
                    ),
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
                        child: Text(_userAbout,
                            //  != "" ? _userAbout! : "No About Me",
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

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        if (!_isUserBlock) {
          FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
            'blockUser': FieldValue.arrayUnion([widget.uid])
          });
          setState(() {
            _userFollowers.remove(user!.uid);
            _isUserBlock = true;
          });
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .update({
            'followers': FieldValue.arrayRemove([user!.uid])
          });
          FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
            'followings': FieldValue.arrayRemove([user!.uid])
          });
//        Navigator.push(
        } else {
          FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
            'blockUser': FieldValue.arrayRemove([widget.uid])
          });
          setState(() {
            _isUserBlock = false;
          });
        }
        break;
    }
  }
}
