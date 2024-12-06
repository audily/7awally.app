import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../backend/services_and_models/api_endpoint.dart';
import '../backend/services_and_models/bottom_nav/models/dashboard_model.dart';
import '../utils/custom_color.dart';
import '../utils/custom_style.dart';
import '../utils/dimsensions.dart';
import '../utils/size.dart';
import '../utils/strings.dart';
import 'labels/primary_text_widget.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({super.key, required this.data, required this.index});
  final Wallet data;
  final int index;

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {



  late ScrollController _scrollController;
  RxDouble _scrollPosition = 0.0.obs;

  @override
  void initState() {
    super.initState();
    if(mounted){
      _scrollController = ScrollController();
      _startAutoScroll();
    }

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 2));
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (!mounted) {
        timer.cancel();
      } else {
        setState(() {
          _scrollPosition.value += 1.0;
          if (_scrollPosition.value > _scrollController.position.maxScrollExtent) {
            _scrollPosition.value = _scrollController.position.minScrollExtent;
          }
          _scrollController.jumpTo(_scrollPosition.value);
        });
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.marginSize * 0.1),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultPaddingSize * 0.5,
          vertical: Dimensions.defaultPaddingSize * 0.5),
      decoration: BoxDecoration(
          color: getColor(widget.index), borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossStart,
        children: [
          Row(
            mainAxisAlignment: mainEnd,
            children: [
              PrimaryTextWidget(
                text: Strings.currentBalance,
                style: CustomStyler.currentBalanceStyle
                    .copyWith(
                    fontWeight: FontWeight.normal, 
                    fontSize: Dimensions.mediumTextSize * .5,
                  color: CustomColor.whiteColor.withOpacity(.6)
                ),
              ),
            ],
          ),
          addVerticalSpace(5.h),
          Row(
            children: [
              Image.network(
                "${ApiEndpoint.mainDomain}/${widget.data.imagePath}/${widget.data.flag}",
                height: Dimensions.heightSize * 1.2,
                width: Dimensions.widthSize * 2,
              ),
              addHorizontalSpace(5.w),
              PrimaryTextWidget(
                text: widget.data.currencyCode,
                style: CustomStyler.currentBalanceUsdStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: CustomColor.whiteColor),
              ),
            ],
          ),
          addVerticalSpace(0.h),
          PrimaryTextWidget(
            text: widget.data.name,
            style: CustomStyler.currentBalanceStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: Dimensions.mediumTextSize * .65,
                color: CustomColor.whiteColor.withOpacity(.6)),
          ),
          addVerticalSpace(5.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: PrimaryTextWidget(
              text:
                  "${widget.data.currencySymbol} " + widget.data.balance.toStringAsFixed(2) + " ",
              style: CustomStyler.currentBalanceMoneyStyle
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 26),
            ),
          )
        ],
      ),
    );
  }

  getColor(int index) {
    final List<Color> colors = [
      Color(0xFF1289AF),
      Color(0xFF125BAF),
      Color(0xFFAF5112),
      Color(0xFF7612AF),
      Color(0xFFAF9012),
    ];

    return colors[(index%5)];
  }
}
