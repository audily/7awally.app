import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/auth/reset_password_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/inputs/password_input_text_field.dart';
import 'package:walletium/widgets/labels/text_labels_widget.dart';

import '../../../utils/assets.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  final _controller = Get.put(ResetPasswordController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        addVerticalSpace(0.h),
        _upperWidget(context),
        _imageWidget(context),
        addVerticalSpace(50.h),
        _resetButtonWidget(context),
      ],
    );
  }

  _upperWidget(BuildContext context) {
    return Container(
      color: CustomColor.whiteColor,
      child: Column(
        children: [
          _titleWidget(context),
          addVerticalSpace(20.h),
          _inputWidgets(context),
          addVerticalSpace(50.h),
        ],
      ),
    );
  }

  _titleWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(Dimensions.marginSize),
        child: Column(
          mainAxisAlignment: mainCenter,
          crossAxisAlignment: crossCenter,
          children: [
            PrimaryTextWidget(
              text: Strings.resetPassword,
              textAlign: TextAlign.center,
              style: CustomStyler.signInTitleStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            addVerticalSpace(5.h),
            PrimaryTextWidget(
              text: Strings.resetPasswordDescription,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * 2),
              textAlign: TextAlign.center,
              style: CustomStyler.textFieldLableStyle,
            ),
          ],
        ));
  }

  _inputWidgets(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextLabelsWidget(
            textLabels: Strings.newPassword,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: PasswordInputTextField(
              controller: _controller.newPasswordController,
              hintText: Strings.enterNewPassword,
              backgroundColor: Colors.transparent,
              hintTextColor: CustomColor.textColor,
              borderColor: CustomColor.gray,
            ),
          ),
          addVerticalSpace(10.h),
          TextLabelsWidget(
            textLabels: Strings.confirmPassword,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: PasswordInputTextField(
              controller: _controller.confirmPasswordController,
              hintText: Strings.enterConfirmPassword,
              backgroundColor: Colors.transparent,
              hintTextColor: CustomColor.textColor,
              borderColor: CustomColor.gray,
            ),
          )
        ],
      ),
    );
  }

  _imageWidget(BuildContext context) {
    return Container(
      color: CustomColor.primaryBackgroundColor,
      child: Column(
        children: [
          Image.asset(
            Assets.resetPasswordImage,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  _resetButtonWidget(BuildContext context) {
    return Obx(() => _controller.isResetPasswordLoading
        ? CustomLoadingAPI(color: CustomColor.whiteColor)
        : PrimaryButtonWidget(
            title: Strings.resetPassword,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _controller.resetPasswordProcess();
              }
            },
            borderColor: CustomColor.whiteColor,
            backgroundColor: CustomColor.whiteColor,
            textColor: CustomColor.textColor,
          ));
  }
}
