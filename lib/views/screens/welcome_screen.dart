import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/routes/routes.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../../utils/assets.dart';
import '../../utils/dimsensions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: CustomColor.primaryBackgroundColor,
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _upperBackgroundImage(context),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.26,
              left: 40,
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
                    text: Strings.welcomeTitle,
                    style: CustomStyler.onboardTitleStyle
                  ),
                  addVerticalSpace(5.h),
                  PrimaryTextWidget(
                    text: Strings.welcomeDescription,
                    style: CustomStyler.onboardDesStyle,
                  ),
                ],
              )),
          Positioned(
            top: 100,
            bottom: 0,
            child: _buttonWidget(context),
          )
        ],
      ),
    );
  }

  _upperBackgroundImage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.36,
          alignment: Alignment.topCenter,
          child: Image.asset(
            Assets.welcomeUpBg,
            color: CustomColor.primaryColor,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        _downBackgroundImage(context),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButtonWidget(
            backgroundColor: CustomColor.primaryColor,
            borderColor: CustomColor.primaryColor,
            textColor: CustomColor.whiteColor,
            onPressed: () {
              Get.toNamed(Routes.signInScreen);
            },
            title: Strings.signIn,
          ),
          addVerticalSpace(Dimensions.paddingVerticalSize * 1.2),
          PrimaryButtonWidget(
            backgroundColor: CustomColor.textColor,
            borderColor: CustomColor.textColor,
            textColor: CustomColor.whiteColor,
            onPressed: () {
              Get.toNamed(Routes.signUpScreen);
            },
            title: Strings.signUp,
          )
        ],
      ),
    );
  }

  _downBackgroundImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        Assets.welcomeDownBg,
        color: CustomColor.primaryColor,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
