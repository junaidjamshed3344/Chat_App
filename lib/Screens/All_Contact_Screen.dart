import 'package:flutter/material.dart';
import 'package:chatapptask/Utils/Functions.dart';
import 'package:chatapptask/Screens/Users_List.dart';

class All_Contact_Screen extends StatefulWidget {
  @override
  _All_Contact_ScreenState createState() => _All_Contact_ScreenState();
}

class _All_Contact_ScreenState extends State<All_Contact_Screen> {
  @override
  void initState() {
    super.initState();
    Functions.all_contact_refresh = () {
      setState(() {});
    };
    Functions.userStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Users_List(),
    );
  }
}
