import 'package:chatapptask/Screens/AllChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:chatapptask/Screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  User? currentuser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: currentuser!=null ? AllChatScreen() : LoginScreen(),
    );
  }
}

