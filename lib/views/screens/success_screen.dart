import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';

import '../../utils/assets.dart';
import '../../widgets/labels/primary_text_widget.dart';
import '../../widgets/will_pop_widget.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {Key? key, required this.title, required this.msg, required this.onTap})
      : super(key: key);

  final String title, msg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      canPop: false,
      onPopMethod: () {
        onTap();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: PrimaryTextWidget(
            text: title,
            style: TextStyle(
              color: CustomColor.whiteColor,
            ),
          ),
          backgroundColor: CustomColor.primaryColor,
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        addVerticalSpace(100.h),
        _imageWidget(context),
        addVerticalSpace(20.h),
        _titleWidget(context),
        addVerticalSpace(40.h),
        _okayButtonWidget(context)
      ],
    );
  }

  _imageWidget(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        // child: Image.asset(Assets.confirmImage),
        child: SvgPicture.asset(Assets.confirmImageSvg,
            color: CustomColor.primaryColor));
  }

  _titleWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      crossAxisAlignment: crossCenter,
      children: [
        PrimaryTextWidget(
          text: Strings.success,
          style: CustomStyler.onboardTitleStyle,
        ),
        PrimaryTextWidget(
          text: msg,
          textAlign: TextAlign.center,
          style: CustomStyler.otpVerificationDescriptionStyle,
        ),
      ],
    );
  }

  _okayButtonWidget(BuildContext context) {
    return PrimaryButtonWidget(
      title: Strings.okay,
      onPressed: onTap,
      borderColor: CustomColor.primaryColor,
      backgroundColor: CustomColor.primaryColor,
      textColor: CustomColor.whiteColor,
    );
  }
}
