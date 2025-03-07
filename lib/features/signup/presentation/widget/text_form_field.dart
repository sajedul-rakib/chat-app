import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  const InputFormField(
      {super.key,
      this.obscureText = false,
      this.textEditionController,
      required this.hintText,
      this.suffix,
      this.validation,
      this.textInputType = TextInputType.text,
      this.prefix,
      this.onChange,
      this.autoCorrect = false});

  final bool obscureText;
  final TextEditingController? textEditionController;
  final String hintText;
  final Widget? suffix;
  final Widget? prefix;
  final Function(String?)? validation;
  final Function(String)? onChange;
  final TextInputType textInputType;
  final bool autoCorrect;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: autoCorrect,
      validator: (value) {
        if (validation != null) {
          return validation!(value);
        }
        return null;
      },
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        } else {
          return;
        }
      },
      keyboardType: textInputType,
      obscureText: obscureText,
      controller: textEditionController,
      decoration: InputDecoration(
          hintText: hintText, prefixIcon: prefix, suffixIcon: suffix),
    );
  }
}
