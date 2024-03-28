import 'package:flutter/material.dart';
import 'package:store_ui/Styles/colors.dart';

Widget customTextField(
    {String? title,
    String? hint,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
    // readOnly = false,
    bool? readOnly = false,
    int? maxLines = 1}) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          readOnly: readOnly!,
          decoration: InputDecoration(
            hintText: hint,
            filled: true, // Enable filled background
            fillColor: lightGrey, // Set background color
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      )
    ],
  );
}
