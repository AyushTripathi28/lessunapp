// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lessunapp/screens/userprofile/profile_page.dart';
import 'package:lessunapp/services/auth_service.dart';
import 'package:lessunapp/sharedPref/sharedPref.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('LESSUN',
            style: TextStyle(
                color: Colors.indigo[900], fontWeight: FontWeight.w900)),
        centerTitle: false,
        backgroundColor: Color(0xffEDF1F5),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              await AuthService().logoutUser();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/authPage", (route) => false);
              setState(() {
                loading = false;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () async {
              String? uid = await LocalStore.getUid("uid");
              print(uid);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffEDF1FE),
      body: loading == true
          ? CircularProgressIndicator()
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.07,
                        // width: size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Start typing',
                            // hintText: 'Start typing',
                            suffixIcon: Icon(Icons.search),
                            suffixIconConstraints: BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            //border
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
