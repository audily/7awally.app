import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/services_and_models/voucher/voucher_log_model.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../backend/utils/no_data_widget.dart';
import '../../../controller/voucher/voucher_log_controller.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/size.dart';
import '../../../widgets/dialog_helper.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/status_indicator_widget.dart';

class VoucherLogScreen extends StatelessWidget {
  VoucherLogScreen({Key? key}) : super(key: key);
  final _controller = Get.put(VoucherLogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.log,
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
    return Obx(() => Column(
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
                height: Dimensions.buttonHeight * 1.2,
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
                      radius: 25,
                      child: Icon(
                        Icons.attach_money,
                        color: CustomColor.whiteColor,
                      ),
                    ),
                    addHorizontalSpace(5),
                    Column(
                      crossAxisAlignment: crossStart,
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
                    data.status == 2
                        ? Obx(() => (_controller.isCancelLoading &&
                                _controller.voucherCode.value == data.code)
                            ? CustomLoadingAPI()
                            : GestureDetector(
                                onTap: () {
                                  DialogHelper.show(
                                      context: context,
                                      title: Strings.cancelRedeem,
                                      subTitle: Strings.cancelRedeemDesc,
                                      actionText: Strings.okay,
                                      action: () {
                                        Navigator.of(context).pop();

                                        _controller.voucherCode.value =
                                            data.code;
                                        _controller.voucherCancelProcess();
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingHorizontalSize * 1,
                                      vertical:
                                          Dimensions.paddingVerticalSize * .5),
                                  decoration: BoxDecoration(
                                      color: CustomColor.primaryColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius * .5)),
                                  child: PrimaryTextWidget(
                                    text: Strings.cancel,
                                    color: CustomColor.whiteColor,
                                  ),
                                ),
                              ))
                        : SizedBox.shrink()
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
                      _rowWidget(Strings.code, data.code),
                      const Divider(),
                      _rowWidget(Strings.createdBy, data.code),
                      const Divider(),
                      _rowWidget(Strings.amount,
                          "${data.requestAmount.toStringAsFixed(2)} ${data.requestCurrency}"),
                      const Divider(),
                      _rowWidget(Strings.charge,
                          "${data.totalCharge.toStringAsFixed(2)} ${data.requestCurrency}"),
                      const Divider(),
                      _rowWidget(Strings.totalPayable,
                          "${data.totalPayable.toStringAsFixed(2)} ${data.requestCurrency}"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  _rowWidget(String title, String amount) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        PrimaryTextWidget(
          text: title,
          style: CustomStyler.otpVerificationDescriptionStyle,
        ),
        PrimaryTextWidget(
          text: amount,
          style: CustomStyler.otpVerificationDescriptionStyle,
        )
      ],
    );
  }
}
