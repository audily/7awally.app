import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletium/backend/services_and_models/api_endpoint.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';

import '../../backend/services_and_models/bottom_nav/models/dashboard_model.dart';
import '../../utils/assets.dart';
import '../labels/primary_text_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Wallet data;

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return Column(
      children: [
        _cardSectionWidget(context),
      ],
    );
  }

  _cardSectionWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.paddingHorizontalSize * 1.2,
        right: Dimensions.paddingHorizontalSize * 1.2,
        top: Dimensions.paddingVerticalSize * .7,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * 3,
          vertical: Dimensions.paddingVerticalSize * 1),
      decoration: BoxDecoration(
          color: const Color(0xFF40B8A9),
          borderRadius: BorderRadius.circular(15.r)),
      child: DelayedDisplay(
        delay: Duration(milliseconds: 100),
        child: Column(
          crossAxisAlignment: crossEnd,
          children: [
            Column(
              mainAxisAlignment: mainEnd,
              crossAxisAlignment: crossEnd,
              children: [
                Row(
                  mainAxisAlignment: mainEnd,
                  children: [
                    PrimaryTextWidget(
                      text: Strings.currentBalance,
                      style: CustomStyler.currentBalanceStyle.copyWith(
                        fontSize: Dimensions.smallestTextSize
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(20.h),
              ],
            ),
            Column(
              // Column(
              crossAxisAlignment: crossStart,
              children: [
                Row(
                  children: [
                    data.flag.isEmpty
                        ? SizedBox.shrink()
                        : FadeInImage.assetNetwork(
                            image: "${ApiEndpoint.mainDomain}/${data.imagePath}/${data.flag}",
                            height: Dimensions.heightSize * 1.5,
                            width: Dimensions.widthSize * 2.5,
                            fit: BoxFit.fill,
                            placeholder: Assets.drawerBG,
                          ),
                    addHorizontalSpace(5.w),
                    PrimaryTextWidget(
                      text: data.currencyCode,
                      style: CustomStyler.currentBalanceUsdStyle,
                    ),
                  ],
                ),
                addVerticalSpace(5.h),
                PrimaryTextWidget(
                  text: data.name,
                  style: CustomStyler.currentBalanceStyle,
                ),
                addVerticalSpace(5.h),
                Row(
                  mainAxisAlignment: mainStart,
                  children: [
                    PrimaryTextWidget(
                      text: data.currencySymbol,
                      style: CustomStyler.currentBalanceMoneyStyle,
                    ),
                    addHorizontalSpace(5.w),
                    PrimaryTextWidget(
                      text: data.balance.toStringAsFixed(2),
                      style: CustomStyler.currentBalanceMoneyStyle,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
