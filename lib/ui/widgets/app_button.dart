import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final Color textColor;
  final Color bgColor;

  const AppButton(
      {Key key, @required this.onPressed, @required this.buttonText, this.bgColor, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: RaisedButton(
        onPressed: onPressed,
        color: bgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
