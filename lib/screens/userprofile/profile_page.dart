// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
                  backgroundImage: AssetImage('assets/images/profilepic.png'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Ayush Tripathi",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text("ayushtripathi445@gmail.com",
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
                            "I am in Chandigarh University of Engineering and Technology. I am pursuing my B.Tech in Computer Science and Engineering. I am a self taught programmer and I am always looking for new challenges.",
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
