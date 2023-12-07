// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;

  InputTextFieldWidget(this.textEditingController, this.keyboardType,this.obscureText, this.hintText, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          controller: textEditingController,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20,
          ),
          decoration: InputDecoration(
              alignLabelWithHint: true,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              fillColor: Colors.white54,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black54),
              contentPadding: EdgeInsets.only(bottom: 15),
              focusColor: Colors.white60),
        ),
      ),
    );
  }
}