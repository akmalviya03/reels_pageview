import 'package:flutter/material.dart';
class AlertButton extends StatelessWidget {
  const AlertButton({
    Key key,@required this.onTap,@required this.buttonText,@required this.buttonColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final String buttonText;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white),
        ),
        color: buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      ),
    );
  }
}