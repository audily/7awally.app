import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/profile/edit_profile_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/inputs/input_text_field.dart';
import 'package:walletium/widgets/labels/text_labels_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';
import 'package:walletium/widgets/others/input_picture_widget.dart';
import '../../../backend/services_and_models/profile_settings/models/profile_info_model.dart';
import '../../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final _controller = Get.find<EditProfileController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.editProfile,
          style: TextStyle(color: CustomColor.whiteColor),
        ),
        leading: const BackButtonWidget(
          
        ),
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
      ),
      body: Obx(() =>
          _controller.isLoading ? CustomLoadingAPI() : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        addVerticalSpace(20.h),
        _profilePictureWidget(context),
        addVerticalSpace(20.h),
        _inputWidgets(context),
        addVerticalSpace(20.h),
        _continueButtonWidget(context),
        addVerticalSpace(20.h),
      ],
    );
  }

  _profilePictureWidget(BuildContext context) {
    return InputImageWidget();
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
                      flex: 1,
                      child: Column(
                        children: [
                          TextLabelsWidget(
                            textLabels: Strings.firstName,
                            textColor: CustomColor.textColor,
                          ),
                          InputTextField(
                            controller: _controller.firstNameController,
                            hintText: Strings.enterFullName,
                            backgroundColor: Colors.transparent,
                            hintTextColor: CustomColor.textColor,
                            borderColor: CustomColor.gray,
                          ),
                        ],
                      )),
                  addHorizontalSpace(5.w),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          TextLabelsWidget(
                            textLabels: Strings.lastName,
                            textColor: CustomColor.textColor,
                          ),
                          InputTextField(
                            controller: _controller.lastNameController,
                            hintText: Strings.enterFullName,
                            backgroundColor: Colors.transparent,
                            hintTextColor: CustomColor.textColor,
                            borderColor: CustomColor.gray,
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.5),
                child: _selectCountryWidget(context)),
            addVerticalSpace(Dimensions.paddingVerticalSize * .7),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  Expanded(
                    child: _selectStateWidget(context),
                  ),
                  addHorizontalSpace(5.w),
                  Expanded(
                    child: _selectCityWidget(context),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  Expanded(
                    child: _addressWidget(context),
                  ),
                  addHorizontalSpace(5.w),
                  Expanded(
                    child: _zipCodeWidget(context),
                  ),
                ],
              ),
            ),
            TextLabelsWidget(
              textLabels: Strings.email,
              textColor: CustomColor.textColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: InputTextField(
                readOnly: true,
                controller: _controller.emailController,
                hintText: "",
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.textColor,
                borderColor: CustomColor.gray,
              ),
            ),
            TextLabelsWidget(
              textLabels: Strings.phoneNumber,
              textColor: CustomColor.textColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: InputTextField(
                controller: _controller.phoneNUmberController,
                hintText: "xxx xxxx xxx",
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.textColor,
                borderColor: CustomColor.gray,
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: mainStart,
                  crossAxisAlignment: crossCenter,
                  children: [
                    Obx(() => PrimaryTextWidget(
                        text: _controller.selectedCountry.value.mobileCode)),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingHorizontalSize * .5),
                      width: 1, // Divider width
                      height: 20, // Divider height
                      color: Colors.grey, // Divider color
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _continueButtonWidget(BuildContext context) {
    return Obx(() => _controller.isUpdateLoading
        ? CustomLoadingAPI()
        : PrimaryButtonWidget(
            title: Strings.conTinue,
            onPressed: () {
              if (_controller.selectedImagePath.value.isEmpty) {
                _controller.profileUpdateProcess();
              } else {
                _controller.profileUpdateProcessWithImage();
              }
            },
            borderColor: CustomColor.primaryColor,
            backgroundColor: CustomColor.primaryColor,
            textColor: CustomColor.whiteColor,
          ));
  }

  _selectCountryWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainStart,
      crossAxisAlignment: crossStart,
      children: [
        TextLabelsWidget(
          textLabels: Strings.selectCountry,
          textColor: CustomColor.textColor,
        ),
        Obx(
          () => CustomDropDown<Country>(
            items: _controller.profileInfoModel.data.countries,
            onChanged: (value) {
              _controller.selectedCountry.value = value!;
            },
            selectedValue: _controller.selectedCountry.value,
            hint: Strings.selectCountry,
            titleTextColor: CustomColor.primaryColor,
            selectedTextColor: CustomColor.whiteColor,
            hintTextColor: CustomColor.textColor,
            decorationColor: CustomColor.gray,
          ),
        ),
      ],
    );
  }

  _selectCityWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainStart,
      crossAxisAlignment: crossStart,
      children: [
        TextLabelsWidget(
          textLabels: Strings.city,
          textColor: CustomColor.textColor,
        ),
        InputTextField(
          controller: _controller.cityController,
          hintText: Strings.city,
          backgroundColor: Colors.transparent,
          hintTextColor: CustomColor.textColor,
          borderColor: CustomColor.gray,
        ),
      ],
    );
  }

  _selectStateWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainStart,
      crossAxisAlignment: crossStart,
      children: [
        TextLabelsWidget(
          textLabels: Strings.state,
          textColor: CustomColor.textColor,
        ),
        InputTextField(
          controller: _controller.stateController,
          hintText: Strings.state,
          backgroundColor: Colors.transparent,
          hintTextColor: CustomColor.textColor,
          borderColor: CustomColor.gray,
        ),
      ],
    );
  }

  _addressWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainStart,
      crossAxisAlignment: crossStart,
      children: [
        TextLabelsWidget(
          textLabels: Strings.address,
          textColor: CustomColor.textColor,
        ),
        InputTextField(
          controller: _controller.addressController,
          hintText: Strings.address,
          backgroundColor: Colors.transparent,
          hintTextColor: CustomColor.textColor,
          borderColor: CustomColor.gray,
        ),
      ],
    );
  }

  _zipCodeWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainStart,
      crossAxisAlignment: crossStart,
      children: [
        TextLabelsWidget(
          textLabels: Strings.zipCode,
          textColor: CustomColor.textColor,
        ),
        InputTextField(
          controller: _controller.zipCodeController,
          hintText: Strings.zipCode,
          backgroundColor: Colors.transparent,
          hintTextColor: CustomColor.text,
          borderColor: CustomColor.gray,
        ),
      ],
    );
  }
}
