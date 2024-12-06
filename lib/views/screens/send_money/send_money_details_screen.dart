import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../controller/send_money/send_money_controller.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class SendMoneyDetailsScreen extends StatelessWidget {
  SendMoneyDetailsScreen({Key? key}) : super(key: key);
  final _controller = Get.find<SendMoneyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.sendMoneyDetails,
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
        _sendMoneyButtonWidget(context),
      ],
    );
  }

  _detailsWidget(BuildContext context) {
    var data = _controller.sendMoneySubmitModel.data.confirmDetails;
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
          _rowWidget(context, Strings.sendingAmount,
              "${data.senderAmount.toStringAsFixed(2)} ${data.senderCurrency}"),

          const Divider(),
          _rowWidget(context, Strings.recipient, _controller.selectRecipientController.name.value),

          const Divider(),
          _rowWidget(context, Strings.recipientEmail, _controller.selectRecipientController.email.value),

          const Divider(),
          _rowWidget(context, Strings.yourRecipientWillGet,
              "${data.receiverAmount.toStringAsFixed(2)} ${data.receiverCurrency}"),

          const Divider(),
          _rowWidget(context, Strings.exchangeRate,
              "1 ${data.senderCurrency} = ${data.exchangeRate.toStringAsFixed(4)} ${data.receiverCurrency}"),

          const Divider(),
          _rowWidget(context, Strings.feesJust,
              "${data.totalCharge.toStringAsFixed(2)} ${data.senderCurrency}"),

          const Divider(),
          _rowWidget(context, Strings.totalPayable,
              "${data.totalPayable.toStringAsFixed(2)} ${data.senderCurrency}"),
        ],
      ),
    );
  }

  _sendMoneyButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.5),
      child: Obx(() => _controller.isConfirmLoading
          ? CustomLoadingAPI()
          : PrimaryButtonWidget(
              title: Strings.sendMoney,
              onPressed: () {
                _controller.sendMoneyConfirmProcess();
              },
              borderColor: CustomColor.primaryColor,
              backgroundColor: CustomColor.primaryColor,
              textColor: CustomColor.whiteColor,
            )),
    );
  }

  _rowWidget(BuildContext context, String title, String amount) {
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
        ),
      ],
    );
  }
}
