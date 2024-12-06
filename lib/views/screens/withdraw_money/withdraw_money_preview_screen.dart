import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/withdraw_money/withdraw_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import '../../../backend/services_and_models/withdraw/withdraw_money_submit_model.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/others/back_button_widget.dart';

class WithdrawMoneyPreviewScreen extends StatelessWidget {
  const WithdrawMoneyPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.withdrawMoneyReview,
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

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        _detailsWidget(context),
        _depositButtonWidget(context),
      ],
    );
  }

  _detailsWidget(BuildContext context) {
    PaymentInformations preview = Get.find<WithdrawController>().withdrawMoneySubmitModel.data.paymentInformations;
    return Container(
      margin: EdgeInsets.all(Dimensions.marginSize * 0.5),
      child: Column(
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          PrimaryTextWidget(
            text: Strings.confirmDetails,
            style: CustomStyler.onboardTitleStyle,
          ),
          const Divider(),
          _rowWidget(context, Strings.trxNo, preview.trx),
          const Divider(),
          _rowWidget(context, Strings.enterAmount, preview.requestAmount),
          const Divider(),
          _rowWidget(context, Strings.exchangeRate, preview.exchangeRate),
          const Divider(),
          _rowWidget(context, Strings.conversationAmount, preview.conversionAmount),
          const Divider(),
          _rowWidget(context, Strings.totalCharge, preview.totalCharge),
          const Divider(),
          _rowWidget(context, Strings.willGet, preview.willGet),
          const Divider(),
          _rowWidget(context, Strings.totalPayableAmount, preview.payable),
        ],
      ),
    );
  }

  _depositButtonWidget(BuildContext context) {
    return Obx(() => Get.find<WithdrawController>().isConfirmLoading ? CustomLoadingAPI(): PrimaryButtonWidget(
      title: Strings.withdraw,
      onPressed: () {
        Get.find<WithdrawController>().withdrawMoneyConfirmProcess();
      },
      borderColor: CustomColor.primaryColor,
      backgroundColor: CustomColor.primaryColor,
      textColor: CustomColor.whiteColor,
    ));
  }

  _rowWidget(BuildContext context, String title, String amount) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        PrimaryTextWidget(
          text: title,
          style: CustomStyler.otpVerificationDescriptionStyle,
        ),
        Row(
          children: [
            PrimaryTextWidget(
              text: amount,
              style: CustomStyler.otpVerificationDescriptionStyle,
            ),
          ],
        )
      ],
    );
  }
}
