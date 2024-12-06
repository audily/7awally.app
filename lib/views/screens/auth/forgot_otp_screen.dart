import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/backend/utils/custom_snackbar.dart';
import 'package:walletium/controller/auth/sign_in_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/inputs/otp_input_text_field.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../controller/auth/forgot_password_otp_controller.dart';
import '../../../utils/assets.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);
  final controller = Get.put(ForgetPasswordOtpController());
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.otpVerification,
          style: TextStyle(color: CustomColor.textColor),
        ),
        leading: const BackButtonWidget(
        ),
        backgroundColor: CustomColor.whiteColor,
        elevation: 0,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        _upperWidget(context),
        _imageWidget(context),
        addVerticalSpace(60.h),
        _submitButtonWidget(context),
      ],
    );
  }

  _upperWidget(BuildContext context) {
    return Container(
      color: CustomColor.whiteColor,
      child: Column(
        children: [
          addVerticalSpace(50.h),
          _timeWidget(context),
          addVerticalSpace(30.h),
          _otpMiddleSection(context),
          _titleWidget(context),
        ],
      ),
    );
  }

  _timeWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * 2.5),
      child: Row(
        mainAxisAlignment: mainStart,
        children: [
          Icon(
            Icons.access_time_filled,
            color: CustomColor.primaryColor,
          ),
          addHorizontalSpace(5.w),
          Obx(() => PrimaryTextWidget(
                text: controller.formatTime(controller.timer.value).value,
                style: TextStyle(
                    color: CustomColor.textColor, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  _otpMiddleSection(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSize),
        child: Form(
          key:  formKey,
          child: TextFieldOtp(
            controller: controller.otpController,
          ),
        ));
  }

  _titleWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize * 2,
            vertical: Dimensions.paddingHorizontalSize * 2),
        child: Row(
          mainAxisAlignment: mainStart,
          children: [
            PrimaryTextWidget(
              text: Strings.enterTheCodeSentTo,
              textAlign: TextAlign.center,
              style: CustomStyler.otpVerificationDescriptionStyle,
            ),
            addHorizontalSpace(10.w),
            PrimaryTextWidget(
              text: Get.find<SignInController>().emailController.text,
              textAlign: TextAlign.center,
              style: CustomStyler.otpVerificationDescriptionStyle,
            ),
          ],
        ));
  }

  _imageWidget(BuildContext context) {
    return Container(
      color: CustomColor.primaryBackgroundColor,
      child: Column(
        children: [
          Image.asset(
            Assets.otpImage,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  _submitButtonWidget(BuildContext context) {
    return Obx(() => Column(
          children: [
            controller.isOTPSVerifyLoading
                ? CustomLoadingAPI(color: CustomColor.whiteColor,)
                : PrimaryButtonWidget(
                    title: Strings.submit,
                    onPressed: () {
                      if(controller.otpController.text.length == 6){
                        controller.forgotVerifyOtpProcess();
                      }else{
                        CustomSnackBar.error(Strings.pleaseFillOutTheField);
                      }

                    },
                    borderColor: CustomColor.whiteColor,
                    backgroundColor: CustomColor.whiteColor,
                    textColor: CustomColor.textColor,
                  ),
            addVerticalSpace(20.h),
            controller.resendVisible.value
                ? TextButton(
                    onPressed: () {
                      controller.forgotReSendOtpProcess();
                    },
                    child: PrimaryTextWidget(
                      text: Strings.resend,
                      color: CustomColor.whiteColor,
                      fontWeight: FontWeight.w600,
                    ))
                : SizedBox.shrink()
          ],
        ));
  }
}
