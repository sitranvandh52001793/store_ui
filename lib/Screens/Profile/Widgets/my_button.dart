import 'package:flutter/material.dart';

Widget myButton({
  required String text,
  required Color backgroundColor,
  required Color textColor,
  required VoidCallback onTap,
  double? width,
  double? height,
  EdgeInsets? padding,
}) {
  return Container(
    width: width,
    height: height,
    padding: padding,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        // shaw dow
        elevation: 1,
        shadowColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    ),
  );
}
