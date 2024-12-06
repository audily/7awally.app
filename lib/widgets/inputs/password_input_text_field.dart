import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/strings.dart';

class PasswordInputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color hintTextColor;
  final Color borderColor;
  final Color backgroundColor;

  const PasswordInputTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly,
    required this.hintTextColor,
    required this.borderColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _PasswordInputTextFieldState createState() => _PasswordInputTextFieldState();
}

class _PasswordInputTextFieldState extends State<PasswordInputTextField> {
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: widget.hintTextColor,
      readOnly: false,
      style: CustomStyler.textFieldLableStyle.copyWith(
        color: widget.hintTextColor
      ),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: (String? value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.pleaseFillOutTheField);
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1),
          borderSide: BorderSide(color: widget.borderColor.withOpacity(.2), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1),
          borderSide: BorderSide(color: widget.borderColor.withOpacity(.4), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1),
          borderSide: BorderSide(color: widget.borderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        filled: true,
        fillColor: widget.backgroundColor,
        hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(widget.hintText),
        contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize * 2.2,
            vertical: Dimensions.paddingVerticalSize * 1
        ),
        hintStyle: TextStyle(
            color: widget.hintTextColor.withOpacity(.6),
            fontSize: 14,
            fontWeight: FontWeight.w600),
        suffixIcon: IconButton(
          icon: Icon(
            isVisibility ? Icons.visibility_off : Icons.visibility,
          ),
          color: widget.hintTextColor.withOpacity(.7),
          onPressed: () {
            setState(() {
              isVisibility = !isVisibility;
            });
          },
        ),
      ),
      obscureText: isVisibility,
    );
  }
}
