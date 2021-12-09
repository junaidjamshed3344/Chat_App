import 'package:flutter/material.dart';

class CustomizeButton extends StatelessWidget {
  final String buttontitle;
  final VoidCallback onpress;

  CustomizeButton({required this.buttontitle,required this.onpress});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: Container(
            //width: size.width * 0.7,
            child: ClipRRect(
              child: TextButton(
                onPressed: onpress,
                child: Text(
                  buttontitle,
                  style: TextStyle(
                    color: Colors.white,

                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightBlue),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
