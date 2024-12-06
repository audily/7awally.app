import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/auth/sign_in_controller.dart';
import 'package:walletium/routes/routes.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/inputs/input_text_field.dart';
import 'package:walletium/widgets/inputs/password_input_text_field.dart';
import 'package:walletium/widgets/labels/text_labels_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../utils/assets.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final _controller = Get.find<SignInController>();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
            Assets.signInBgSvg,
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(CustomColor.primaryColor, BlendMode.color),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              addVerticalSpace(30.h),
              _backButton(context),
              addVerticalSpace(40.h),
              _titleAndDesWidget(context),
              addVerticalSpace(60.h),
              _inputWidgets(context),
              addVerticalSpace(40.h),
              _signInButtonWidget(context),
              _forgotPasswordWidget(context),
              addVerticalSpace(20.h),
              _signUpWidget(context),
            ],
          ),
        ),
      ],
    );
  }

  _backButton(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(Dimensions.marginSize * 0.5),
      child: Row(
        children: [
          const BackButtonWidget(
          ),
          addHorizontalSpace(10.w),
          PrimaryTextWidget(
            text: Strings.signIn,
            style: CustomStyler.signInStyle,
          )
        ],
      ),
    );
  }

  _titleAndDesWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.marginSize),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          PrimaryTextWidget(
            text: Strings.signInTitle,
            style: CustomStyler.signInTitleStyle
                .copyWith(fontWeight: FontWeight.w900),
          ),
          addVerticalSpace(5.h),
          PrimaryTextWidget(
            text: Strings.signInDescription,
            style: CustomStyler.onboardDesStyle,
          ),
        ],
      ),
    );
  }

  _inputWidgets(BuildContext context) {
    return Form(
      key: formKey,
      child: DelayedDisplay(
        delay: Duration(milliseconds: 300),
        child: Column(
          children: [
            TextLabelsWidget(
              textLabels: Strings.emailOrUsername,
              textColor: CustomColor.whiteColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: InputTextField(
                controller: _controller.emailOrUserNameController,
                hintText: Strings.emailOrUsername,
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.whiteColor,
                borderColor: CustomColor.whiteColor,
              ),
            ),
            TextLabelsWidget(
              textLabels: Strings.password,
              textColor: CustomColor.whiteColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: PasswordInputTextField(
                controller: _controller.passwordController,
                hintText: Strings.enterPassword,
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.whiteColor,
                borderColor: CustomColor.whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  _signInButtonWidget(BuildContext context) {
    return Obx(() => _controller.isLoading
        ? CustomLoadingAPI(
            color: CustomColor.whiteColor,
          )
        : PrimaryButtonWidget(
            title: Strings.signIn,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _controller.loginProcess();
              }
            },
            borderColor: CustomColor.textColor,
            backgroundColor: CustomColor.textColor,
            textColor: CustomColor.whiteColor,
          ));
  }

  _forgotPasswordWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(Dimensions.marginSize),
      child: GestureDetector(
        onTap: () {
          _forgotPasswordScreen(context);
        },
        child: const PrimaryTextWidget(
          text: Strings.forgotPassword,
          style: TextStyle(color: CustomColor.whiteColor),
        ),
      ),
    );
  }

  _signUpWidget(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.all(Dimensions.marginSize),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            const PrimaryTextWidget(
              text: Strings.newToRemesa,
              style: TextStyle(
                color: CustomColor.whiteColor,
              ),
            ),
            const PrimaryTextWidget(
              text: " ",
              style: TextStyle(
                color: CustomColor.whiteColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.signUpScreen);
              },
              child: const PrimaryTextWidget(
                text: Strings.signUp,
                style: TextStyle(
                    color: CustomColor.whiteColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  //Forgot Password Screen
  _forgotPasswordScreen(BuildContext context) {
    final forgotFormKey = GlobalKey<FormState>();
    var width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
            backgroundColor: CustomColor.whiteColor,
            alignment: Alignment.center,
            insetPadding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.2),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Builder(
              builder: (context) {
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColor.primaryBackgroundColor,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingHorizontalSize,
                        vertical: Dimensions.paddingVerticalSize * 2),
                    width: width * 0.9,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            addVerticalSpace(20.h),
                            Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                color: CustomColor.primaryBackgroundColor,
                              ),
                              child: SvgPicture.asset(
                                Assets.forgotPassSvg,
                                color: CustomColor.primaryColor,
                              ),
                            ),
                            addVerticalSpace(20.h),
                            PrimaryTextWidget(
                              text: Strings.forgotPasswordTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: CustomColor.textColor,
                                  fontSize: Dimensions.largeTextSize + 5,
                                  fontWeight: FontWeight.w900),
                            ),
                            addVerticalSpace(10.h),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.marginSize),
                              width: double.infinity,
                              child: PrimaryTextWidget(
                                text: Strings.forgotPasswordDescription,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: CustomColor.textColor.withOpacity(0.6),
                                ),
                              ),
                            ),
                            TextLabelsWidget(
                              margin: 0.5,
                              textLabels: Strings.email,
                              textColor: CustomColor.textColor,
                            ),
                            DelayedDisplay(
                              delay: Duration(milliseconds: 300),
                              child: Form(
                                key: forgotFormKey,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Dimensions.marginSize * 0.5),
                                  child: InputTextField(
                                    hintText: Strings.enterEmail,
                                    hintTextColor: CustomColor.textColor,
                                    backgroundColor: CustomColor.whiteColor,
                                    controller: _controller.emailController,
                                    borderColor: CustomColor.gray,
                                  ),
                                ),
                              ),
                            ),
                            addVerticalSpace(Dimensions.paddingVerticalSize),
                            Obx(() => _controller.isOTPSendLoading
                                ? CustomLoadingAPI()
                                : PrimaryButtonWidget(
                                    title: Strings.conTinue,
                                    onPressed: () {
                                      if (forgotFormKey.currentState!
                                          .validate()) {
                                        _controller.forgotSendOtpProcess();
                                      }
                                    },
                                    textColor: CustomColor.whiteColor,
                                    backgroundColor: CustomColor.textColor,
                                    borderColor: CustomColor.textColor,
                                  )),
                          ],
                        ),
                        Positioned(
                            top: -5,
                            right: 5,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: CustomColor.gray,
                                weight: 2,
                              ),
                            ))
                      ],
                    ));
              },
            )));
  }
}
