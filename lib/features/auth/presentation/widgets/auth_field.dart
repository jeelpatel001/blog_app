import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isObscureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is Missing!";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
