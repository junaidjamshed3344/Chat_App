import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapptask/Screens/All_Contact_Screen.dart';
import 'package:chatapptask/Utils/Functions.dart';
import 'package:chatapptask/Components/Menu_items.dart';
import 'package:chatapptask/Components/Menu_item.dart';
import 'package:chatapptask/Screens/LoginScreen.dart';
import 'package:chatapptask/Screens/Chats_List.dart';

class AllChatScreen extends StatefulWidget {
  @override
  _AllChatScreenState createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  PopupMenuItem<Menu_item> buildItem(Menu_item item) {
    return PopupMenuItem(
        value: item,
        child: Row(
          children: [
            Icon(
              item.icon,
              color: Colors.black,
              size: 20.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(item.text)
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    Functions.all_contact_refresh = () {
      setState(() {});
    };
    Functions.messageStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Chat Screen'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => All_Contact_Screen(),
                  ),
                );
              },
              child: Icon(Icons.search_rounded),
            ),
          ),
          PopupMenuButton<Menu_item>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) =>
                  Menu_items.items.map(buildItem).toList())
        ],
      ),
      body: Chat_List(),
    );
  }

  onSelected(BuildContext context, Menu_item item) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
