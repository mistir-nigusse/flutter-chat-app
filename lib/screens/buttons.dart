import 'package:flutter/material.dart';



class buttons extends StatelessWidget {
  Color? buttonColor;
  String? buttonText;
  Function onPressed;

  //

  buttons(
      {required this.buttonColor,
      required this.buttonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onPressed();
            //Go to login screen.
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(buttonText!,
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
