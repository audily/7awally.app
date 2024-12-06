

import 'package:flutter/material.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../utils/custom_color.dart';
import '../utils/dimsensions.dart';
import '../utils/size.dart';
import '../utils/strings.dart';

class DialogHelper{
  static show({
    required BuildContext context,
    required String title,
    required String subTitle,
    required String actionText,
    required VoidCallback action
}){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            insetPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * .3,
              vertical: Dimensions.paddingVerticalSize * .3,
            ),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Builder(
              builder: (context) {
                var width = MediaQuery.of(context).size.width;
                return Container(
                  width: width * 0.84,
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingHorizontalSize * .5,
                    vertical: Dimensions.paddingVerticalSize * .5,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingHorizontalSize * .9,
                    vertical: Dimensions.paddingVerticalSize * .9,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.whiteColor,
                    borderRadius:
                    BorderRadius.circular(Dimensions.radius * 1.4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: crossCenter,
                    children: [
                      SizedBox(height: Dimensions.paddingVerticalSize * 1),
                      PrimaryTextWidget(
                          text: title,
                          color: CustomColor.redColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.defaultTextSize,
                      ),
                      addVerticalSpace(Dimensions.paddingVerticalSize * 1),
                      PrimaryTextWidget(text: subTitle, color: CustomColor.textColor.withOpacity(.8)),
                      addVerticalSpace(Dimensions.paddingVerticalSize * 2),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .25,
                              child: PrimaryButtonWidget(
                                title: Strings.cancel,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                borderColor: CustomColor.primaryColor.withOpacity(.7),
                                backgroundColor: CustomColor.primaryColor.withOpacity(.7),
                                textColor: CustomColor.whiteColor,
                              ),
                            ),
                          ),
                          addHorizontalSpace(Dimensions.widthSize),
                          Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .25,
                              child: PrimaryButtonWidget(
                                title: actionText,
                                onPressed: action,
                                borderColor: CustomColor.redColor,
                                backgroundColor: CustomColor.redColor,
                                textColor: CustomColor.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(Dimensions.paddingVerticalSize * 1),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}