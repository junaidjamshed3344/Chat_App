import 'package:flutter/material.dart';
import 'package:chatapptask/Modal/Constant.dart';

class CustomizeEmailTextFormField extends StatefulWidget {

  late TextEditingController controlerr;
  late String textfieldhint;
  CustomizeEmailTextFormField({required this.controlerr, required this.textfieldhint});

  @override
  _CustomizeEmailTextFormFieldState createState() => _CustomizeEmailTextFormFieldState();
}

class _CustomizeEmailTextFormFieldState extends State<CustomizeEmailTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: TextFormField(
        controller: widget.controlerr,
        decoration: kTextField(widget.textfieldhint),
        validator: (value) {
          if (value!.isNotEmpty)
          {
            return null;
          }
          else
          {
            return 'Please Enter Detail';
          }
        },
      ),
    );
  }
}
