import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';

import '../labels/primary_text_widget.dart';

class OnboardButton extends StatelessWidget {
  const OnboardButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 1,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: Dimensions.buttonHeight * .9,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: CustomColor.whiteColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          margin: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * 2),
          padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.5),
          child: Row(
            mainAxisAlignment: mainSpaceBet,
            children: const [
              PrimaryTextWidget(
                text: Strings.letsGetStarted,
                style: TextStyle(
                  color: CustomColor.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: CustomColor.textColor,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
