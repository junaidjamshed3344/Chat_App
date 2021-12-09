import 'package:flutter/material.dart';
import 'package:chatapptask/Modal/Constant.dart';

class CustomizeTextField extends StatefulWidget {

  late String textfieldhint;
  late TextEditingController controlerr;

  CustomizeTextField({required this.textfieldhint,required this.controlerr});

  @override
  _CustomizeTextFieldState createState() => _CustomizeTextFieldState();
}

class _CustomizeTextFieldState extends State<CustomizeTextField> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: TextField(
        controller: widget.controlerr,
        decoration: kTextField(widget.textfieldhint),
      ),
    );
  }
}
