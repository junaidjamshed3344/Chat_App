import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapptask/Modal/User.dart';
import 'package:chatapptask/Modal/Message.dart';
import 'package:chatapptask/Modal/Chat.dart';

class Functions {
  static Function? all_contact_refresh;
  static List<User_Model> alluser = [
    User_Model(
        name: 'zain', email: 'zain@gmail.com', userid: 'zain1234',imageurl: 'http'),
  ];


  static List<Chat_Model> chatsdata = [
    Chat_Model(name: 'junaid', userid: 'jun123',userimage: '')
  ];

  static messageStream() async {
    chatsdata.clear();
    await for (var snapshots in FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('allchats')
        .snapshots()) {
      for (var chats in snapshots.docs) {
        chatsdata.add(Chat_Model.fromMapObject(chats.data()));
        all_contact_refresh!();
      }
    }
  }
  static Future<String> signUp(context,
      {required String email,
      required String password,
      required String username}) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "Verify";
      //return "User Registered";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "weak-password";
      } else if (e.code == 'email-already-in-use') {
        return "email-already-in-use";
      } else {
        return "registrationFailed";
      }
    } catch (e) {
      print(e);
      return "unknownerror";
    }
  }

  static Future<String> signIn(context,
      {required String email, required String password}) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "signInSuccessful";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "user-not-found";
      } else if (e.code == 'wrong-password') {
        return "wrong-password";
      } else {
        return "signIn-failed";
      }
    } catch (e) {
      print(e);
      return "unknownerror";
    }
  }

  static void showSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      duration: Duration(seconds: 3),
    ));
  }

  static List<Message_Model> messagesdata = [
    Message_Model(
      messageText: 'Muneeb',
      messagestatus: false,
      date: '',

    ),
  ];


  static chatsaddtolist({required String name, required String userid,required String imageeurl}) async {

    // This check whether the user has already chat with the user or not

    String currentusername = 'junaid';
    String currentuserimage = '';

    await FirebaseFirestore.instance.collection('users').get().then((users) {
      users.docs.forEach((singleuser) {
        if(singleuser.data()["userid"]== FirebaseAuth.instance.currentUser!.uid)
        {
          currentusername= singleuser.data()["name"];
          currentuserimage=singleuser.data()["image"];
        }
      });
    });



    bool checkchat = false;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('allchats')
        .get()
        .then((allchats) {
      allchats.docs.forEach((singlechatuser) {
        if(singlechatuser.data()["userid"]==userid)
        {
          checkchat = true;
        }
      });
    });

    if (checkchat == false)
    {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('allchats')
          .add({
        'name': name,
        'userid': userid,
        'image':imageeurl,
      });
    }

    bool checkreceiverchat = false ;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('allchats')
        .get()
        .then((allchats) {
      allchats.docs.forEach((singlechatuser) {
        if(singlechatuser.data()["userid"]==FirebaseAuth.instance.currentUser!.uid)
        {
          checkreceiverchat = true;
        }
      });
    });

    if(checkreceiverchat == false)
    {

      FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('allchats')
          .add({
        'name': currentusername,
        'userid': FirebaseAuth.instance.currentUser!.uid,
        'image':currentuserimage,
      });

    }
  }

  static messageaddtofirebase (String receiverid, String messagetext)
  {

    // This add message to the sender database
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(receiverid)
        .collection('messages')
        .add({
      'messagetext': messagetext,
      'status': false,
      'date': DateTime.now(),
    });

    //This add messages  to the receiver database

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverid)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add({
      'messagetext': messagetext,
      'status': true,
      'date': DateTime.now(),
    });
  }

  static userStream() async {
    alluser.clear();
    await for (var snapshots
        in FirebaseFirestore.instance.collection('users').snapshots()) {
      for (var user in snapshots.docs) {
        if (user.data()["userid"] != FirebaseAuth.instance.currentUser!.uid)
          {
            alluser.add(User_Model.fromMapObject(user.data()));
            all_contact_refresh!();
          }
      }
    }
  }
}
