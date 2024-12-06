import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/profile/change_password_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/inputs/password_input_text_field.dart';
import 'package:walletium/widgets/labels/text_labels_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../widgets/labels/primary_text_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final _controller = Get.put(ChangePasswordController());

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.changePassword,
          style: TextStyle(color: CustomColor.whiteColor),
        ),
        leading: const BackButtonWidget(
          
        ),
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        _inputWidgets(context),
        addVerticalSpace(30.h),
        _changePasswordButtonWidget(context),
      ],
    );
  }

  _inputWidgets(BuildContext context) {
    return Form(
      key: formKey,
      child: DelayedDisplay(
        delay: Duration(milliseconds: 300),
        child: Column(
          children: [
            addVerticalSpace(20.h),
            TextLabelsWidget(
              textLabels: Strings.oldPassword,
              textColor: CustomColor.textColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: PasswordInputTextField(
                controller: _controller.oldPasswordController,
                hintText: Strings.oldPassword,
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.textColor,
                borderColor: CustomColor.gray,
              ),
            ),
            TextLabelsWidget(
              textLabels: Strings.newPassword,
              textColor: CustomColor.textColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: PasswordInputTextField(
                controller: _controller.newPasswordController,
                hintText: Strings.newPassword,
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.textColor,
                borderColor: CustomColor.gray,
              ),
            ),
            TextLabelsWidget(
              textLabels: Strings.confirmPassword,
              textColor: CustomColor.textColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: PasswordInputTextField(
                controller: _controller.confirmPasswordController,
                hintText: Strings.confirmPassword,
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.textColor,
                borderColor: CustomColor.gray,
              ),
            )
          ],
        ),
      ),
    );
  }

  _changePasswordButtonWidget(BuildContext context) {
    return Obx(() => _controller.isLoading ? CustomLoadingAPI() : PrimaryButtonWidget(
      title: Strings.changePassword,
      onPressed: () {
        if(formKey.currentState!.validate()){
          _controller.passwordChangeProcess();
        }
      },
      borderColor: CustomColor.primaryColor,
      backgroundColor: CustomColor.primaryColor,
      textColor: CustomColor.whiteColor,
    ));
  }
}
