import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:walletium/routes/routes.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import '../../../controller/request_money/request_money_controller.dart';
import '../../../widgets/inputs/input_text_field.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/labels/text_labels_widget.dart';
import '../../../widgets/others/back_button_widget.dart';

class RequestMoneyReviewScreen extends StatelessWidget {
  const RequestMoneyReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.requestMoneyPreview,
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
        _requestMoneyButtonWidget(context),
      ],
    );
  }

  _detailsWidget(BuildContext context) {
    var preview = Get.find<RequestMoneyController>().requestMoneySubmitModel.data;
    return Container(
      // margin: EdgeInsets.all(Dimensions.marginSize * 0.5),
      child: Column(
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          addVerticalSpace(Dimensions.paddingVerticalSize),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: PrimaryTextWidget(
              text: Strings.description,
              style: CustomStyler.onboardTitleStyle,
            ),
          ),
          addVerticalSpace(Dimensions.paddingVerticalSize),
          _rowWidget(context, Strings.requestMoney, preview.requestAmount.toStringAsFixed(2) + " ${preview.requestCurrency}"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: const Divider(),
          ),
          _rowWidget(context, Strings.totalCharge, preview.totalCharge.toStringAsFixed(2) + " ${preview.requestCurrency}"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: const Divider(),
          ),
          _rowWidget(context, Strings.totalPayable, preview.totalPayable.toStringAsFixed(2) + " ${preview.requestCurrency}"),

          preview.remark.isEmpty ? SizedBox.shrink(): Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
                child: const Divider(),
              ),
              _rowWidget(context, Strings.remarks, preview.remark),
            ],
          ),

          addVerticalSpace(Dimensions.paddingVerticalSize * 2),


          TextLabelsWidget(
            textLabels: Strings.copyYourReqLink,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
            EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: InputTextField(
              readOnly: true,
              controller: TextEditingController(text: preview.link),
              hintText: "",
              backgroundColor: Colors.transparent,
              hintTextColor: CustomColor.textColor,
              borderColor: CustomColor.gray,
              suffix: IconButton(
                icon: Icon(Icons.copy,color: CustomColor.primaryColor),
                onPressed: ()async{
                  await Clipboard.setData(
                      ClipboardData(text: preview.link));
                },
              ),
            ),
          ),

          addVerticalSpace(Dimensions.paddingVerticalSize * 2),
        ],
      ),
    );
  }

  _requestMoneyButtonWidget(BuildContext context) {
    return PrimaryButtonWidget(
      title: Strings.done,
      onPressed: () {
        Get.offAllNamed(Routes.bottomNavigationScreen);
      },
      borderColor: CustomColor.primaryColor,
      backgroundColor: CustomColor.primaryColor,
      textColor: CustomColor.whiteColor,
    );
  }

  _rowWidget(BuildContext context, String title, String amount) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          PrimaryTextWidget(
            text: title,
            textAlign: TextAlign.justify,
            style: CustomStyler.otpVerificationDescriptionStyle,
          ),
          Row(
            children: [
              PrimaryTextWidget(
                text: amount,
                textAlign: TextAlign.right,
                style: CustomStyler.otpVerificationDescriptionStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

}
