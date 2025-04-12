import 'package:chat_app/core/constants/colors/app_colors.dart';
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
      this.autoCorrect = false,
      this.filledInput = false,
      this.focusNode,
      this.filledColor});

  final bool obscureText;
  final TextEditingController? textEditionController;
  final String hintText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? filledInput;
  final Function(String?)? validation;
  final Function(String)? onChange;
  final TextInputType textInputType;
  final bool autoCorrect;
  final FocusNode? focusNode;
  final Color? filledColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: AppColors.lightButtonBackground,
        focusNode: focusNode,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
          fillColor: filledColor,
          hintText: hintText,
          prefixIcon: prefix,
          suffixIcon: suffix,
        ));
  }
}
