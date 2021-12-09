import 'package:flutter/material.dart';
import 'package:chatapptask/Modal/Constant.dart';
class CustomizePasswordField extends StatefulWidget {

  late TextEditingController controllerr;
  CustomizePasswordField({required this.controllerr});

  @override
  _CustomizePasswordFieldState createState() => _CustomizePasswordFieldState();
}

class _CustomizePasswordFieldState extends State<CustomizePasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: TextFormField(
        controller: widget.controllerr,
        decoration: passwordfield,
        validator: (value) {
          if (value!.length>5)
          {
            return null;
          }
          else
          {
            return 'Password Length Should be Greater than 5';
          }
        },
      ),
    );
  }
}
