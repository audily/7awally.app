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
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../backend/services_and_models/profile_settings/models/profile_info_model.dart';
import '../../../controller/recipient/add_recipient_controller.dart';
import '../../../widgets/buttons/primary_button_widget.dart';
import '../../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../../widgets/inputs/input_text_field.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/labels/text_labels_widget.dart';

class AddRecipientScreen extends StatelessWidget {
  AddRecipientScreen({Key? key}) : super(key: key);
  final _controller = Get.put(AddRecipientController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.addRecipient,
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

  _continueButtonWidget(BuildContext context) {
    return Obx(() => _controller.isStoreLoading
        ? CustomLoadingAPI()
        : Container(
            margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.5),
            child: PrimaryButtonWidget(
              title: Strings.addRecipient,
              onPressed: () {
                if(formKey.currentState!.validate()){
                  _controller.storeRecipientProcess();
                }
              },
              borderColor: CustomColor.primaryColor,
              backgroundColor: CustomColor.primaryColor,
              textColor: CustomColor.whiteColor,
            ),
          ));
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        _inputWidgets(context),
        _continueButtonWidget(context),
      ],
    );
  }

  _inputWidgets(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: 300),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            addVerticalSpace(Dimensions.paddingVerticalSize * .7),

            TextLabelsWidget(
              textLabels: Strings.searchUserLabel,
              textColor: CustomColor.textColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: InputTextField(
                controller: _controller.emailController,
                hintText: Strings.searchUserHint,
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.textColor,
                borderColor: CustomColor.gray,
                onEditingComplete: () {
                  if (_controller.emailController.text.length
                      .isGreaterThan(4)) {
                    FocusScope.of(context).unfocus();
                    _controller.searchRecipientProcess(
                        _controller.emailController.text);
                  }
                },
              ),
            ),

            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: Obx(() => _controller.isSearchLoading
                  ? PrimaryTextWidget(
                      text: "Searching...", color: CustomColor.primaryColor)
                  : SizedBox.shrink()),
            ),

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
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  Expanded(
                    child: _selectCityWidget(context),
                  ),
                  addHorizontalSpace(5.w),
                  Expanded(
                    child: _selectStateWidget(context),
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
                    child: _zipCodeWidget(context),
                  ),
                  addHorizontalSpace(5.w),
                  Expanded(
                    child: _countryWidget(context),
                  ),
                ],
              ),
            ),

            TextLabelsWidget(
              textLabels: Strings.address,
              textColor: CustomColor.textColor,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: InputTextField(
                maxLine: 3,
                controller: _controller.addressController,
                hintText: Strings.address,
                backgroundColor: Colors.transparent,
                hintTextColor: CustomColor.textColor,
                borderColor: CustomColor.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectCountryWidget(BuildContext context) {
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
            items: Get.find<EditProfileController>()
                .profileInfoModel
                .data
                .countries,
            onChanged: (value) {
              _controller.selectedCountry.value = value!;
            },
            selectedValue: _controller.selectedCountry.value,
            hint: Strings.selectCountry,
            titleTextColor: CustomColor.primaryColor,
            selectedTextColor: CustomColor.textColor,
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

  _countryWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainStart,
      crossAxisAlignment: crossStart,
      children: [
        TextLabelsWidget(
          textLabels: Strings.country,
          textColor: CustomColor.textColor,
        ),
        InputTextField(
          // readOnly: true,
          controller: _controller.countryController,
          hintText: Strings.country,
          backgroundColor: Colors.transparent,
          hintTextColor: CustomColor.text,
          borderColor: CustomColor.gray,
        ),
      ],
    );
  }
}
