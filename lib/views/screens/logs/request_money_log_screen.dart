import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../backend/services_and_models/logs/request_money_log_model.dart';
import '../../../backend/utils/no_data_widget.dart';
import '../../../controller/logs/request_money_log_controller.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/size.dart';
import '../../../widgets/date_shower.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/status_indicator_widget.dart';

class RequestMoneyLogScreen extends StatelessWidget {
  RequestMoneyLogScreen({Key? key}) : super(key: key);
  final _controller = Get.put(RequestMoneyLogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.requestMoney,
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

  // body widget
  _bodyWidget(BuildContext context) {
    return Stack(
      children: [
        ListView(
          physics: const BouncingScrollPhysics(),
          controller: _controller.scrollController,
          shrinkWrap: true,
          children: [
            _controller.historyList.isEmpty
                ? NoDataWidget()
                : ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingHorizontalSize * .6,
                    vertical: Dimensions.paddingVerticalSize * .6),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Datum data = _controller.historyList[index];

                  return _logWidget(context, data, index);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    addVerticalSpace(Dimensions.paddingVerticalSize * .6),
                itemCount: _controller.historyList.length),
          ],
        ),
        Obx(() => _controller.isMoreLoading
            ? const CustomLoadingAPI(
                color: Colors.amber,
              )
            : const SizedBox()),
      ],
    );
  }

  _logWidget(BuildContext context, Datum data, int index) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Obx(() => Column(
            crossAxisAlignment: crossStart,
            children: [
              GestureDetector(
                onTap: () {
                  if (_controller.selectedIndex.value == index) {
                    _controller.selectedIndex.value = -1;
                  } else {
                    _controller.selectedIndex.value = index;
                  }
                },
                child: Container(
                  height: Dimensions.buttonHeight * 1.3,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingHorizontalSize,
                      vertical: Dimensions.paddingVerticalSize),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    color: CustomColor.whiteColor.withOpacity(1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: Offset(0, 3), // Offset from the container
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: CustomColor.primaryColor,
                        radius: 28,
                        child: DateShower(
                          dateTime: data.createdAt,
                        ),
                      ),
                      addHorizontalSpace(5),
                      Column(
                        crossAxisAlignment: crossStart,
                        mainAxisAlignment: mainCenter,
                        children: [
                          PrimaryTextWidget(
                            text: Strings.redeemVoucher,
                          ),
                          addVerticalSpace(5),
                          StatusIndicatorWidget(
                            status: data.status,
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: crossStart,
                        mainAxisAlignment: mainCenter,
                        children: [
                          PrimaryTextWidget(
                            text: data.requestAmount.toStringAsFixed(2) +
                                " " +
                                data.requestCurrency,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration:
                    Duration(milliseconds: 500), // Duration for the animation
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingHorizontalSize,
                    vertical: Dimensions.paddingVerticalSize),
                height: _controller.selectedIndex.value == index
                    ? null
                    : 0, // Set height based on visibility
                child: Visibility(
                  visible: _controller.selectedIndex.value == index,
                  child: DelayedDisplay(
                    delay: Duration(milliseconds: 450),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Divider(),
                        _rowWidget(Strings.link, data.link),
                        const Divider(),
                        _rowWidget(Strings.createdBy, data.createdBy),
                        const Divider(),
                        data.paidBy.isEmpty
                            ? SizedBox.shrink()
                            : Column(
                                children: [
                                  _rowWidget(Strings.paidBy, data.paidBy),
                                  const Divider(),
                                ],
                              ),
                        _rowWidget(Strings.amount,
                            "${data.requestAmount.toStringAsFixed(2)} ${data.requestCurrency}"),
                        const Divider(),
                        _rowWidget(Strings.totalCharge,
                            "${data.totalCharge.toStringAsFixed(2)} ${data.requestCurrency}"),
                        const Divider(),
                        _rowWidget(Strings.totalPayable,
                            "${data.totalPayable.toStringAsFixed(2)} ${data.requestCurrency}")
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  _rowWidget(String title, String amount) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      crossAxisAlignment: crossStart,
      children: [
        PrimaryTextWidget(
          text: title,
          style: CustomStyler.otpVerificationDescriptionStyle,
        ),
        addHorizontalSpace(10.w),
        Expanded(
          child: GestureDetector(
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: amount));
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text('Text copied to clipboard'),
              //   ),
              // );
            },
            child: PrimaryTextWidget(
              text: amount,
              textAlign: TextAlign.end,
              style: CustomStyler.otpVerificationDescriptionStyle,
            ),
          ),
        )
      ],
    );
  }
}
