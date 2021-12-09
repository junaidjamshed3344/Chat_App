import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message_Box extends StatelessWidget {
  late String messageText;
  late bool messageStatus;
  late String messagedate;

  Message_Box(
      {required this.messageText,
      required this.messageStatus,
      required this.messagedate});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: messageStatus == false
          ? MessageSend(
              messText: messageText,
              date: messagedate,
            )
          : Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(15.0),
                    elevation: 5.0,
                    color: Colors.lightGreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 10.0),
                          child: Text(
                            messageText,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          //padding: EdgeInsets.symmetric(horizontal: 10.0),
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                          child: Text(
                            messagedate,
                            style: TextStyle(fontSize: 8.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// THis box is for receiving messages

class MessageSend extends StatelessWidget {
  late String messText;
  late String date;

  MessageSend({required this.messText, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
            borderRadius: BorderRadius.circular(15.0),
            elevation: 8.0,
            color: Colors.lightBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: Text(
                    messText,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 5.0),
                  child: Text(
                    date,
                    style: TextStyle(fontSize: 8.0),
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
