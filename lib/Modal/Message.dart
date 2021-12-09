import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class Message_Model {
  String messageText = 'Hello World';
  bool messagestatus = false; // true for receive and false for send
  late String date;



  Message_Model(
      {required this.messageText,
        required this.messagestatus,
        required this.date
      });

  Message_Model.fromSnapshot(Map<dynamic, dynamic> map)
  {
    this.messageText = map['messagetext'];
    this.messagestatus = map['status'];
   // this.date=map['date'];
    Timestamp timestamp = map['date'] as Timestamp;
    DateTime datetime= timestamp.toDate();

   // this.date=DateFormat('yyyy-MM-dd – kk:mm').format(datetime);
    this.date=DateFormat('kk:mm').format(datetime);
   // final dateString = DateFormat('K:mm:ss').format(dateTime)
  }
}
