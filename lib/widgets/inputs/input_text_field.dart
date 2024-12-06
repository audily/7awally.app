import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/strings.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color backgroundColor;
  final Color hintTextColor;
  final Color borderColor;
  final int? maxLine;
  final IconData? iconData;
  final Widget? prefix;
  final Widget? suffix;
  final ValueChanged? onChanged;
  final VoidCallback? onEditingComplete;
  final bool haveValidation;
  final List<TextInputFormatter>? inputFormatters;

  const InputTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.keyboardType,
      this.readOnly = false,
      required this.backgroundColor,
      required this.hintTextColor,
      this.maxLine,
      this.iconData,
      required this.borderColor,
      this.prefix,
      this.suffix,
      this.onChanged,
      this.onEditingComplete,
      this.haveValidation = true,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 50.h,
        maxHeight: 100.h,
      ),
      child: TextFormField(
        inputFormatters: inputFormatters,
        cursorColor: hintTextColor,
        maxLines: maxLine ?? 1,
        readOnly: readOnly!,
        style: CustomStyler.textFieldLableStyle.copyWith(color: hintTextColor),
        controller: controller,
        keyboardType: keyboardType,
        validator: (String? value) {
          if (value!.isNotEmpty) {
            return null;
          } else {
            return haveValidation ? DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.pleaseFillOutTheField) : null;
          }
        },
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius * 1),
            borderSide:
                BorderSide(color: borderColor.withOpacity(.2), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius * 1),
            borderSide:
                BorderSide(color: borderColor.withOpacity(.4), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius * 1),
            borderSide: BorderSide(color: borderColor, width: 2),
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
          fillColor: backgroundColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * 2.2,
              vertical: Dimensions.paddingVerticalSize * 1),
          hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(hintText),
          hintStyle: TextStyle(
              color: hintTextColor.withOpacity(.6),
              fontSize: 14,
              fontWeight: FontWeight.w600),
          prefix: prefix,
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
