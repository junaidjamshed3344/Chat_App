import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:chatapptask/Components/CustomizeButton.dart';
import 'package:chatapptask/Components/CustomizeEmailTextFromField.dart';
import 'package:chatapptask/Components/CustomizePasswordField.dart';
import 'package:chatapptask/Utils/Functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapptask/Screens/AllChatScreen.dart';
import 'package:chatapptask/Screens/LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController regUsernameController = TextEditingController();
  final GlobalKey<FormState> _forkey = GlobalKey<FormState>();

  FirebaseStorage _storage = FirebaseStorage.instance;

  var image;
  var imagePicker = new ImagePicker();
  String userimageURL = '';

  pickimage() async {
    XFile? imagess = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(imagess!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _forkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  pickimage();
                },
                child: Container(
                  child: CircleAvatar(
                    maxRadius: size.width * 0.2,
                    child: image == null
                        ? Icon(
                            Icons.person,
                            size: 70.0,
                          )
                        : CircleAvatar(
                            maxRadius: size.width * 0.2,
                            backgroundImage: FileImage(image),
                          ),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              CustomizeEmailTextFormField(
                  controlerr: regUsernameController,
                  textfieldhint: 'Enter Your Name'),
              CustomizeEmailTextFormField(
                controlerr: regEmailController,
                textfieldhint: 'Enter Your Email Address',
              ),
              CustomizePasswordField(controllerr: regPasswordController),
              CustomizeButton(
                  buttontitle: 'Sign Up',
                  onpress: () async {
                    if (!_forkey.currentState!.validate()) {
                      return;
                    }
                    if (regPasswordController.text.length < 6) {
                      Functions.showSnackBar(
                          'Password length should be greater than 5 ', context);
                    } else {
                      String registrationStatus = await Functions.signUp(context,
                          email: regEmailController.text.trim(),
                          password: regPasswordController.text.trim(),
                          username: regUsernameController.text.trim());

                      var firebaseUser = FirebaseAuth.instance.currentUser;
                      if (registrationStatus == "Verify") {
                        Reference reference = _storage
                            .ref()
                            .child("images/")
                            .child(firebaseUser!.uid);
                        UploadTask uploadtask = reference.putFile(image);
                        var imageurl =
                            await (await uploadtask).ref.getDownloadURL();

                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(firebaseUser.uid)
                            .set({
                          'name': regUsernameController.text.trim(),
                          'email': regEmailController.text.trim(),
                          'userid': firebaseUser.uid,
                          'image': imageurl,
                        });
                        regUsernameController.clear();
                        regPasswordController.clear();
                        regEmailController.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllChatScreen()),
                        );
                      } else {
                        Functions.showSnackBar(registrationStatus, context);
                      }
                    }
                  }),
              CustomizeButton(
                  buttontitle: 'Log In',
                  onpress: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
