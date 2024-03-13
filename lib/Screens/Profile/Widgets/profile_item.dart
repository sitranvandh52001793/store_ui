import 'package:flutter/material.dart';
import 'package:store_ui/Styles/colors.dart';

Widget profileItem(
    {required IconData icon,
    required String text,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 25,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ],
    ),
  );
}
