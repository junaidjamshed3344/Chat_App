import 'package:chatapptask/Utils/Functions.dart';
import 'package:chatapptask/Screens/ChatScreen.dart';
import 'package:flutter/material.dart';

class Chat_List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  userchatname: Functions.chatsdata[index].name,
                  userchatid: Functions.chatsdata[index].userid,
                  userimage: Functions.chatsdata[index].userimage,
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
                      Functions.chatsdata[index].userimage,
                    ),
                  ),
                  title: Text(
                    Functions.chatsdata[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: Functions.chatsdata.length,
    );
  }
}
