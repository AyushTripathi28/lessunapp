// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:lessunapp/services/auth_service.dart';
import 'package:lessunapp/sharedPref/sharedPref.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool? acceptTerms = false;
  bool? loading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content:
          Text("Please accept terms and conditions to continue signing up."),
      contentPadding: EdgeInsets.only(left: 20, top: 20, right: 20),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sign Up to Lessun",
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
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Center(
                    child: SizedBox(
                        width: 250,
                        height: 150,
                        child: Image.asset('assets/images/logo.png')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                  ),
                  child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                          hintText: ''),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                      ])),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                  ),
                  child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter valid email id as abc@gmail.com'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        EmailValidator(errorText: "Enter valid email id"),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        MinLengthValidator(6,
                            errorText:
                                "Password should be atleast 6 characters"),
                        MaxLengthValidator(15,
                            errorText:
                                "Password should not be greater than 15 characters")
                      ])
                      //validatePassword,        //Function to check validation
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Password should be same as above'),
                    validator: (val) =>
                        MatchValidator(errorText: 'passwords do not match')
                            .validateMatch(confirmPasswordController.text,
                                passwordController.text),
                    //validatePassword,        //Function to check validation
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Checkbox(
                          value: acceptTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              acceptTerms = value;
                            });
                          }),
                      Text("I accept the terms and conditions"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
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
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            if (formkey.currentState!.validate()) {
                              if (acceptTerms == true) {
                                User? result = await AuthService().registerUser(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                    context);
                                if (result != null) {
                                  print("Sign Up successful");
                                  LocalStore.setUid(result.uid);
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(result.uid)
                                      .set({
                                    'username': "",
                                    'name': nameController.text,
                                    'email': emailController.text,
                                    'about': "",
                                    "profilepic": "",
                                  }).then((_) => print("Success"));
                                  Navigator.popAndPushNamed(
                                      context, '/loginPage');
                                } else {
                                  print("not able to make acount");
                                  // showAlertDialog(context);
                                }
                              } else if (acceptTerms == false) {
                                print("Dialoge");
                                showAlertDialog(context);
                              } else {
                                print("Not Validated");
                              }
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/loginPage');
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
