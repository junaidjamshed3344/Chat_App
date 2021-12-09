import 'package:flutter/material.dart';
import 'package:chatapptask/Modal/Constant.dart';
import 'package:chatapptask/Components/CustomizeButton.dart';
import 'package:chatapptask/Components/CustomizeEmailTextFromField.dart';
import 'package:chatapptask/Screens/SignUpScreen.dart';
import 'package:chatapptask/Utils/Functions.dart';
import 'package:chatapptask/Screens/AllChatScreen.dart';
import 'package:chatapptask/Components/CustomizePasswordField.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _forkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _forkey,
        child:Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chat App',
                style: kChatApptitle,
              ),
              CustomizeEmailTextFormField(
                controlerr: emailController,
                textfieldhint: 'Enter Your Email Address',
              ),
              CustomizePasswordField(controllerr: passwordController),
              CustomizeButton(
                  buttontitle: 'Log In',
                  onpress: () async {
                    if (!_forkey.currentState!.validate()) {
                      return;
                    }
                    if (passwordController.text.length > 5) {
                      String signInStatus = await Functions.signIn(context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                      Functions.showSnackBar(signInStatus, context);

                      if (signInStatus == 'signInSuccessful') {
                        passwordController.clear();
                        emailController.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllChatScreen(),
                          ),
                        );
                      } else {
                        Functions.showSnackBar(
                            'Please Enter Valid Information', context);
                      }
                    } else {
                      Functions.showSnackBar(
                          'Please Enter Details for Login', context);
                    }
                  }),
              CustomizeButton(
                  buttontitle: 'Sign Up',
                  onpress: () {
                    emailController.clear();
                    passwordController.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
