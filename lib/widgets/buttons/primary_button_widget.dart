import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletium/utils/dimsensions.dart';

import '../labels/primary_text_widget.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const PrimaryButtonWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Dimensions.buttonHeight * .9,
      margin: EdgeInsets.only(
          left: Dimensions.marginSize * 0.5,
          right: Dimensions.marginSize * 0.5),
      width: double.infinity,
      // alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed,
        child: PrimaryTextWidget(
          text: DynamicLanguage.isLoading ? "": DynamicLanguage.key(title).toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor,
              fontSize: Dimensions.largeTextSize * .8,
              fontWeight: FontWeight.w600),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
              // horizontal: Dimensions.paddingHorizontalSize * 3,
              vertical: Dimensions.paddingVerticalSize * .8),
          elevation: 0,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
              side: BorderSide(width: 1, color: borderColor)),
        ),
      ),
    );
  }
}
