import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapptask/Utils/Functions.dart';
import 'package:chatapptask/Modal/Message.dart';
import 'package:chatapptask/Screens/Message_Box.dart';

class ChatScreen extends StatefulWidget {
  late String userchatname;
  late String userchatid;
  late String userimage;

  ChatScreen(
      {required this.userchatname,
      required this.userchatid,
      required this.userimage});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: size.width * 0.4,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.userimage,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(widget.userchatname),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('chats')
                  .doc(widget.userchatid)
                  .collection('messages')
                  .orderBy('date')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Functions.messagesdata.clear();
                  final messages = snapshot.data!.docs;
                  for (var message in messages) {
                    // Message_Model.fromSnapshot(message.data());

                    Functions.messagesdata
                        .add(Message_Model.fromSnapshot(message.data()));
                  }
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Message_Box(
                      messageText: Functions.messagesdata[index].messageText,
                      messageStatus:
                          Functions.messagesdata[index].messagestatus,
                      messagedate:
                          Functions.messagesdata[index].date.toString(),
                    );
                  },
                  itemCount: Functions.messagesdata.length,
                );
              },
            ),
          ),
          Container(
            //    height: size.height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                    child: TextField(
                      minLines: 1,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      controller: messageTextController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ))),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Functions.messageaddtofirebase(
                      widget.userchatid,
                      messageTextController.text.trim(),
                    );
                    messageTextController.clear();
                  },
                  child: Container(
                    //height: size.height*1,
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
