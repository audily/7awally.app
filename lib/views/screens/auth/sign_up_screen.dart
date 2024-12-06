import 'package:delayed_display/delayed_display.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:walletium/backend/services_and_models/settings/models/basic_settings_model.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/auth/sign_up_controller.dart';
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

import '../../../controller/settings_controller.dart';
import '../../../utils/assets.dart';
import '../../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../dynamic_web_screen/dynamic_web_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _controller = Get.find<SignUpController>();
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
          colorFilter:
              ColorFilter.mode(CustomColor.primaryColor, BlendMode.color),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              addVerticalSpace(Dimensions.heightSize * 1.2),
              _backButton(context),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      addVerticalSpace(30.h),
                      _titleAndDesWidget(context),
                      addVerticalSpace(25.h),
                      _toggleButton(context),
                      addVerticalSpace(10.h),
                      _inputWidgets(context),
                      addVerticalSpace(30.h),
                      _signUpButtonWidget(context),
                      addVerticalSpace(10.h),
                      _policyWidget(context),
                      addVerticalSpace(20.h),
                      _alreadyHaveAccWidget(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _backButton(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(Dimensions.marginSize),
      child: Row(
        children: [
          BackButtonWidget(
            onBack: () {
              Get.offAllNamed(Routes.welcomeScreen);
            },
          ),
          addHorizontalSpace(10.w),
          PrimaryTextWidget(
            text: Strings.signUp,
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
            text: Strings.signUpTitle,
            style: CustomStyler.signInTitleStyle,
          ),
          addVerticalSpace(10.h),
          PrimaryTextWidget(
            text: Strings.signUpDescription,
            style: CustomStyler.onboardDesStyle,
          ),
        ],
      ),
    );
  }

  _inputWidgets(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: 300),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextLabelsWidget(
                          textLabels: Strings.firstName,
                          textColor: CustomColor.whiteColor,
                        ),
                        InputTextField(
                          controller: _controller.firstNameController,
                          hintText: Strings.enterFullName,
                          backgroundColor: Colors.transparent,
                          hintTextColor: CustomColor.whiteColor,
                          borderColor: CustomColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                  addHorizontalSpace(5.w),
                  Expanded(
                    child: Column(
                      children: [
                        TextLabelsWidget(
                          textLabels: Strings.lastName,
                          textColor: CustomColor.whiteColor,
                        ),
                        InputTextField(
                          controller: _controller.lastNameController,
                          hintText: Strings.enterFullName,
                          backgroundColor: Colors.transparent,
                          hintTextColor: CustomColor.whiteColor,
                          borderColor: CustomColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TextLabelsWidget(
              textLabels: Strings.email,
              textColor: CustomColor.whiteColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: InputTextField(
                controller: _controller.emailController,
                hintText: Strings.enterEmail,
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.whiteColor,
                borderColor: CustomColor.whiteColor,
              ),
            ),
            TextLabelsWidget(
              textLabels: Strings.selectCountry,
              textColor: CustomColor.whiteColor,
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.5),
                child: Obx(
                  () => CustomDropDown<Country>(
                    items: Get.find<SettingController>()
                        .basicSettingModel
                        .data
                        .countries,
                    onChanged: (value) {
                      _controller.selectedCountry.value = value!;
                    },
                    selectedValue: _controller.selectedCountry.value,
                    hint: Strings.selectCountry,
                    titleTextColor: CustomColor.primaryColor,
                    selectedTextColor: CustomColor.whiteColor,
                    decorationColor: CustomColor.whiteColor,
                  ),
                )),
            addVerticalSpace(Dimensions.paddingVerticalSize * .4),
            Obx(() => AnimatedContainer(
                  height: _controller.selectIndex.value == 1
                      ? Dimensions.buttonHeight * 1.6
                      : 0.0,
                  duration: Duration(
                      milliseconds: 500), // Adjust the duration as needed
                  curve: Curves.easeInOut,
                  child: Visibility(
                    visible: _controller.selectIndex.value == 1,
                    child: DelayedDisplay(
                      delay: Duration(milliseconds: 450),
                      child: Column(
                        children: [
                          TextLabelsWidget(
                            textLabels: Strings.companyName,
                            textColor: CustomColor.whiteColor,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.marginSize * 0.5),
                            child: InputTextField(
                              controller: _controller.companyNameController,
                              hintText: Strings.enterCompanyName,
                              backgroundColor: Colors.transparent,
                              hintTextColor: CustomColor.whiteColor,
                              borderColor: CustomColor.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
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

  _signUpButtonWidget(BuildContext context) {
    return Obx(() => _controller.isLoading
        ? CustomLoadingAPI(color: CustomColor.whiteColor)
        : PrimaryButtonWidget(
            title: Strings.signUp,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _controller.registerProcess();
              }
            },
            borderColor: CustomColor.textColor,
            backgroundColor: CustomColor.textColor,
            textColor: CustomColor.whiteColor,
          ));
  }

  _policyWidget(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(Dimensions.marginSize * 0.5),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: DynamicLanguage.isLoading
                ? ""
                : DynamicLanguage.key(Strings.terms) + " ",
            style: TextStyle(color: CustomColor.whiteColor),
            children: <TextSpan>[
              TextSpan(
                text: DynamicLanguage.isLoading
                    ? ""
                    : DynamicLanguage.key(Strings.policy),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(WebViewScreen(
                      link: Get.find<SettingController>()
                          .basicSettingModel
                          .data
                          .webLinks
                          .privacyPolicy,
                      appTitle: Strings.privacyPolicy,
                    ));
                  },
                style: TextStyle(
                    color: CustomColor.whiteColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  _alreadyHaveAccWidget(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.all(Dimensions.marginSize),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            const PrimaryTextWidget(
              text: Strings.alreadyHaveAcc,
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
                Get.back();
              },
              child: const PrimaryTextWidget(
                text: Strings.signIn,
                style: TextStyle(
                    color: CustomColor.whiteColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  _toggleButton(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ToggleSwitch(
          initialLabelIndex: _controller.selectIndex.value,
          totalSwitches: 2,
          minWidth: MediaQuery.of(context).size.width * .33,
          minHeight: MediaQuery.of(context).size.height * .045,
          activeBgColor: [CustomColor.whiteColor],
          customTextStyles: [
            TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.defaultTextSize * .7)
          ],
          inactiveBgColor: CustomColor.gray.withOpacity(.8),
          activeFgColor: CustomColor.primaryColor,
          inactiveFgColor: CustomColor.whiteColor.withOpacity(.6),
          labels: [
            DynamicLanguage.isLoading
                ? ""
                : DynamicLanguage.key(Strings.personal),
            DynamicLanguage.isLoading
                ? ""
                : DynamicLanguage.key(Strings.business)
          ],
          onToggle: (index) {
            _controller.selectIndex.value = index!;
            if (index == 0) {
              _controller.containerHeight.value = 0;
            } else {
              _controller.containerHeight.value = Dimensions.buttonHeight * .9;
            }
          },
        ),
      ),
    );
  }
}
