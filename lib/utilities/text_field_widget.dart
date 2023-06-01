import 'package:flutter/material.dart';

Widget textFieldWidget(
    bool autocorrect,
    bool obscureText,
    bool enableSuggestions,
    TextInputType? textInputType,
    TextEditingController controller,
    String labelText,
    IconData? iconData,
    Widget? suffixIcon) {
  return TextField(
    autocorrect: autocorrect,
    obscureText: obscureText,
    enableSuggestions: enableSuggestions,
    keyboardType: textInputType,
    controller: controller,
    decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: labelText,
        prefixIcon: Icon(iconData),
        suffixIcon: suffixIcon),
  );
}
