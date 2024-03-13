import 'package:flutter/material.dart';
import 'package:store_ui/Styles/colors.dart';

Widget updateItem({
  BuildContext? context,
  required String title,
  required String value,
  bool? disable = false,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: white,
        // border bottom
        border: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 233, 229, 229),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
          const Spacer(),
          if (!disable!)
            Row(
              children: [
                Text(
                  (value.isEmpty) ? 'Cập nhật' : value,
                  style: TextStyle(fontSize: 15, color: primaryColor),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )
              ],
            ),
          if (disable)
            Text(
              value,
              style: TextStyle(fontSize: 15, color: grey),
            ),
        ],
      ),
    ),
  );
}
