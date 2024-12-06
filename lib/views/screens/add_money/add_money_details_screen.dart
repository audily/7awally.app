import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';
import 'package:walletium/backend/utils/custom_snackbar.dart';
import 'package:walletium/controller/add_money/add_money_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/views/screens/success_screen.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../backend/model/common/error_message_model.dart';
import '../../../routes/routes.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../dynamic_web_screen/dynamic_web_screen.dart';

class AddMoneyDetailsScreen extends StatelessWidget {
  AddMoneyDetailsScreen({Key? key}) : super(key: key);
  final _controller = Get.find<AddMoneyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.addMoneyDetails,
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
        addVerticalSpace(10.h),
        _detailsWidget(context),
        _continueButtonWidget(context),
      ],
    );
  }

  _detailsWidget(BuildContext context) {
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
          _rowWidget(
              context,
              Strings.enteredAmount,
              _controller.enteredAmount.toStringAsFixed(2) +
                  " " +
                  _controller.selectedWallet.value.currencyCode),
          const Divider(),
          _rowWidget(
            context,
            Strings.exchangeRate,
            "1 ${_controller.selectedWallet.value.currencyCode} = ${_controller.exchangeRate.value.toStringAsFixed(4)} ${_controller.selectedGateway.value.currencyCode}",
          ),
          const Divider(),
          _rowWidget(
              context,
              Strings.conversationAmount,
              _controller.conversionAmount.toStringAsFixed(2) +
                  " " +
                  _controller.selectedGateway.value.currencyCode),
          const Divider(),
          _rowWidget(
              context,
              Strings.feesJust,
              _controller.totalCharge.toStringAsFixed(2) +
                  " " +
                  _controller.selectedGateway.value.currencyCode),
          const Divider(),
          _rowWidget(
              context,
              Strings.totalPayableAmount,
              _controller.totalConversionAmount.toStringAsFixed(2) +
                  " " +
                  _controller.selectedGateway.value.currencyCode),
        ],
      ),
    );
  }

  _continueButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.5),
      child: PrimaryButtonWidget(
        title: Strings.conTinue,
        onPressed: () {
          debugPrint('''
                1. >>>  ${_controller.selectedWallet.value.currencyCode},
                2. >>>  ${_controller.selectedGateway.value.alias},
                3. >>>  ${_controller.selectedGateway.value.name}
                ''');

          if (_controller.selectedGateway.value.alias.contains("automatic")) {
            if (_controller.selectedGateway.value.alias.contains("tatum")) {
              debugPrint(" >>> 1");
              Get.toNamed(Routes.addMoneyTatumScreen);
            }
            else {
              debugPrint(" >>> 2");
              Get.to(WebViewScreen(
                link: _controller.addMoneyAutomaticSubmitModel.data.redirectUrl,
                appTitle: _controller.selectedGateway.value.name,
                onFinished: (Map<String, dynamic> jsonData) {
                  if (jsonData['type'].contains("success")) {
                    CommonSuccessModel data = CommonSuccessModel.fromJson(jsonData);
                    Get.to(SuccessScreen(
                        title: Strings.addMoney,
                        msg: data.message.success.first,
                        onTap: () {
                          Get.offAllNamed(Routes.bottomNavigationScreen);
                        }));
                  }
                  else {
                    ErrorResponse data = ErrorResponse.fromJson(jsonData);
                    CustomSnackBar.error(data.message.error.first);
                    Get.offAllNamed(Routes.bottomNavigationScreen);
                  }
                },
              ));
            }
          } else {
            debugPrint(" >>> 3");
            Get.toNamed(Routes.addMoneyManualScreen);
          }
        },
        borderColor: CustomColor.primaryColor,
        backgroundColor: CustomColor.primaryColor,
        textColor: CustomColor.whiteColor,
      ),
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
        )
      ],
    );
  }
}
