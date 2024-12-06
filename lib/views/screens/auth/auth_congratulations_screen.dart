import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';

import '../../../utils/assets.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/will_pop_widget.dart';

class AuthCongratulationsScreen extends StatelessWidget {
  const AuthCongratulationsScreen(
      {Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      canPop: false,
      onPopMethod: onTap,
      child: Scaffold(
        backgroundColor: CustomColor.primaryColor,
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        _upperWidget(context),
        addVerticalSpace(50.h),
        _okayButtonWidget(context)
      ],
    );
  }

  _upperWidget(BuildContext context) {
    return Container(
      color: CustomColor.whiteColor,
      child: Column(
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          addVerticalSpace(100.h),
          _titleWidget(context),
          addVerticalSpace(100.h),
          _imageWidget(context),
          addVerticalSpace(40.h),
        ],
      ),
    );
  }

  _titleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSize),
      child: Column(
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          Image.asset(
            Assets.splashLogo,
            width: 180.w,
          ),
          addVerticalSpace(20.h),
          PrimaryTextWidget(
            text: Strings.congratulations,
            style: CustomStyler.onboardTitleStyle,
          ),
          addVerticalSpace(5.h),
          PrimaryTextWidget(
            text: text,
            style: CustomStyler.onboardDesStyle,
          ),
        ],
      ),
    );
  }

  _imageWidget(BuildContext context) {
    return Container(
      color: CustomColor.primaryBackgroundColor,
      child: Column(
        children: [
          SvgPicture.asset(Assets.congratulationsSvg, color: CustomColor.primaryColor)
          // Image.asset(
          //   Assets.congratulationsImage,
          //   width: double.infinity,
          //   fit: BoxFit.fill,
          // ),
        ],
      ),
    );
  }

  _okayButtonWidget(BuildContext context) {
    return PrimaryButtonWidget(
      title: Strings.okay,
      onPressed: onTap,
      borderColor: CustomColor.whiteColor,
      backgroundColor: CustomColor.whiteColor,
      textColor: CustomColor.textColor,
    );
  }
}
