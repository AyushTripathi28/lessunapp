// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lessunapp/screens/home/home_page.dart';

import 'login_page.dart';
import 'signup_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size.height * 0.08,
              ),
              Image(image: AssetImage('assets/images/logo.png')),
              SizedBox(
                height: size.height * 0.13,
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.9,
                child: ElevatedButton(
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF5970FF),
                    textStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.9,
                child: ElevatedButton(
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF5970FF),
                    textStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.1,
              // ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('Login as Guest')),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextButton(onPressed: () {}, child: Text('Terms of Service')),
            ],
          ),
        ),
      ),
    );
  }
}
