import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lessunapp/screens/authentication/auth_page.dart';
import 'package:lessunapp/screens/authentication/login_page.dart';
import 'package:lessunapp/screens/authentication/signup_page.dart';

import 'package:lessunapp/screens/home/home_page.dart';
import 'package:lessunapp/screens/userprofile/other_user_profile_page.dart';

import 'package:lessunapp/screens/userprofile/profile_page.dart';
import 'package:lessunapp/services/auth_service.dart';

import 'screens/home/createPost.dart';
import 'screens/home/filterpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lessun',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/authPage': (BuildContext context) => const AuthPage(),
        '/loginPage': (BuildContext context) => const LoginPage(),
        '/signupPage': (BuildContext context) => const SignupPage(),
        '/homePage': (BuildContext context) => const HomePage(),
        '/profilePage': (BuildContext context) => const ProfilePage(),
        '/otherUserProfilePage': (BuildContext context) =>
            const OtherUserProfilePage(),
        '/filterPage': (BuildContext context) => const FilterPage(),
        '/makePostPage': (BuildContext context) => const CreatePostPage(),
      },
      //

      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
