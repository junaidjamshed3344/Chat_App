import 'package:flutter/material.dart';
import 'package:chatapptask/Utils/Functions.dart';
import 'package:chatapptask/Screens/ChatScreen.dart';

class Users_List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Functions.chatsaddtolist(
                name: Functions.alluser[index].name,
                userid: Functions.alluser[index].userid,
                imageeurl: Functions.alluser[index].imageurl);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  userchatname: Functions.alluser[index].name,
                  userchatid: Functions.alluser[index].userid,
                  userimage: Functions.alluser[index].imageurl,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                    Functions.alluser[index].imageurl,
                  )),
                  title: Text(
                    Functions.alluser[index].name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: Functions.alluser.length,
    );
  }
}
