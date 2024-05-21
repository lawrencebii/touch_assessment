import 'package:flutter/material.dart';
import 'package:touch_assessment/features/Home/Components/text_field.dart';

List<Widget> titleAndField(name, hint, controller, int? lines) {
  return [
    Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: name,
            ),
          ],
        ),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    TextFormFieldCustom1(
      obscureText: false,
      maxLines: lines,
      validator: (value) => value!.isEmpty ? "Please enter $name" : null,
      hintText: hint,
      controller: controller,
      onChanged: (text) {},
    ),
    SizedBox(
      height: 20,
    ),
  ];
}
