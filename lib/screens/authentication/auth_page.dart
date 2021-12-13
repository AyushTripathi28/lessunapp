// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
                    Navigator.of(context).pushNamed('/loginPage');
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
                    Navigator.of(context).pushNamed('/signupPage');
                  },
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.1,
              // ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/homePage');
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
