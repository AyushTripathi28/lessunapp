// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool? loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    }
    return "";
  }

  checkDatabaseForEmail() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: emailController.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        resetPassword();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Reset Email Sent"),
              content: Text(
                  "This email is sent to your email address. Please check your email and follow the instructions to reset your password"),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        print("object not available;");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Account not found"),
              content: Text(
                  "This email is not registered with Lessun, If you have not registered yet, please sign up!"),
              actions: <Widget>[
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Create a new account"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    Navigator.of(context).pushReplacementNamed('/signupPage');
                  },
                )
              ],
            );
          },
        );
      }
    });
  }

  resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Forget Password",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Form(
            // autovalidate: true, //check for validation while typing
            key: formkey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: SizedBox(
                        width: 300,
                        height: 200,
                        child: Image.asset('assets/images/logo.png')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                    left: 15,
                    right: 15,
                  ),
                  child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter your email id'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        EmailValidator(errorText: "Enter valid email id"),
                      ])),
                ),
                SizedBox(
                  height: 30,
                ),
                loading == true
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF5970FF),
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              checkDatabaseForEmail();
                            }
                          },
                          child: Text(
                            'Reset Password',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
