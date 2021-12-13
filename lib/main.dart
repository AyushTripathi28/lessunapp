import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lessunapp/screens/authentication/auth_page.dart';
import 'package:lessunapp/screens/authentication/login_page.dart';
import 'package:lessunapp/screens/authentication/signup_page.dart';
import 'package:lessunapp/screens/home/home_page.dart';
import 'package:lessunapp/services/auth_service.dart';

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
        '/homePage': (BuildContext context) => const HomePage()
      },
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


// import 'complete.dart';
// import 'progressar.dart';
// import 'screens/authentication/auth_page.dart';

//ExerciseDate