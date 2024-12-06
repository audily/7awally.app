import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimsensions.dart';
import '../../widgets/labels/primary_text_widget.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({super.key, this.isOnboard = false});
  final bool isOnboard;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !isOnboard
          ? _dropDown(context)
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingVerticalSize * 0,
                horizontal: Dimensions.paddingHorizontalSize * 0.05,
              ),
              decoration: BoxDecoration(
                color: CustomColor.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.6),
              ),
              child: _dropDown(context),
            ),
    );
  }

  _dropDown(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * .8
        ),
        decoration: BoxDecoration(
          color: CustomColor.primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.radius)
        ),
        width: Dimensions.widthSize * 12,
        child: DropdownButton2<String>(
          isDense: false,
          isExpanded: true,
          iconStyleData: const IconStyleData(
            icon: Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(
                Icons.arrow_drop_down_rounded,
                color: CustomColor.whiteColor,
              ),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: MediaQuery.sizeOf(context).height * .26,
            decoration: BoxDecoration(
              color: CustomColor.primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
          ),
          value: DynamicLanguage.selectedLanguage.value,
          underline: Container(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              DynamicLanguage.changeLanguage(newValue);
              Get.offAllNamed(Routes.bottomNavigationScreen);
            }
          },
          items: DynamicLanguage.languages.map<DropdownMenuItem<String>>(
            (language) {
              return DropdownMenuItem<String>(
                value: language.code,
                child: PrimaryTextWidget(
                  text: isOnboard ? language.code.toUpperCase() : language.name,
                  color: CustomColor.whiteColor,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}