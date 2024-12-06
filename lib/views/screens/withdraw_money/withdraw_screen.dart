import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/withdraw_money/withdraw_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/labels/text_labels_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../../widgets/inputs/input_text_field.dart';
import '../../../widgets/labels/limit_info_widget.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../backend/services_and_models/withdraw/withdraw_money_index_model.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final _controller = Get.find<WithdrawController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBackgroundColor,
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.withdrawMoney,
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
        _backWithBalanceWidget(context),
        _inputWidget(context),
        _infoWidget(context),
        addVerticalSpace(Dimensions.paddingVerticalSize),
        _continueButtonWidget(context),
      ],
    );
  }

  _backWithBalanceWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.paddingHorizontalSize * 0.5,
          right: Dimensions.paddingHorizontalSize * 0.5,
          bottom: Dimensions.paddingVerticalSize),
      decoration: BoxDecoration(
          color: CustomColor.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r))),
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.defaultPaddingSize * 0.7),
        child: Column(
          mainAxisAlignment: mainCenter,
          crossAxisAlignment: crossCenter,
          children: [
            Obx(() => Row(
              mainAxisAlignment: mainCenter,
              children: [
                PrimaryTextWidget(
                  text: _controller.selectedWallet.value.currencySymbol,
                  style: CustomStyler.withdrawMoneyAmountStyle,
                ),
                addHorizontalSpace(5.w),
                PrimaryTextWidget(
                  text: _controller.selectedWallet.value.balance.toStringAsFixed(2),
                  style: CustomStyler.withdrawMoneyAmountStyle,
                ),
              ],
            )),
            addVerticalSpace(10.h),
            PrimaryTextWidget(
              text: Strings.availableBalance,
              style: CustomStyler.availableBalanceStyle,
            ),
          ],
        ),
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          addVerticalSpace(30.h),
          TextLabelsWidget(
            textLabels: Strings.withdrawTo,
            textColor: CustomColor.textColor,
          ),
          Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: Obx(
                () => CustomDropDown<GatewayCurrency>(
                  items: _controller
                      .withdrawMoneyIndexModel.data.gatewayCurrencies,
                  onChanged: (value) {
                    _controller.selectedGateway.value = value!;
                    _controller
                        .calculation(_controller.amountController.text);
                  },
                  selectedValue: _controller.selectedGateway.value,
                  hint: Strings.selectCountry,
                  titleTextColor: CustomColor.primaryColor,
                  selectedTextColor: CustomColor.whiteColor,
                  hintTextColor: CustomColor.textColor,
                  decorationColor: CustomColor.gray,
                ),
              )),
          addVerticalSpace(6.h),
          TextLabelsWidget(
            textLabels: Strings.amount,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: InputTextField(
              controller: _controller.amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              hintText: Strings.enterAmount,
              backgroundColor: Colors.transparent,
              hintTextColor: CustomColor.textColor,
              borderColor: CustomColor.gray,
              onChanged: (value) {
                if (value.toString() == '.') {
                  _controller.amountController.text = "0.";
                  _controller.calculation("0.");
                } else {
                  _controller.calculation(value.toString());
                }
              },
              suffix: SizedBox(
                  width: MediaQuery.sizeOf(context).width * .3,
                  height: Dimensions.buttonHeight * .8,
                  child: Obx(
                    () => CustomDropDown<UserWallet>(
                        items:
                            _controller.withdrawMoneyIndexModel.data.userWallet,
                        onChanged: (value) {
                          _controller.selectedWallet.value = value!;
                          _controller
                              .calculation(_controller.amountController.text);
                        },
                        selectedValue: _controller.selectedWallet.value,
                        hint: Strings.selectCountry,
                        dropDownFieldColor: CustomColor.primaryColor,
                        titleTextColor: CustomColor.primaryColor,
                        selectedTextColor: CustomColor.whiteColor,
                        decorationColor: CustomColor.whiteColor,
                        customBorderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius *
                              (DynamicLanguage.languageDirection ==
                                  TextDirection.ltr
                                  ? 1
                                  : 0)),
                          bottomRight: Radius.circular(Dimensions.radius *
                              (DynamicLanguage.languageDirection ==
                                  TextDirection.ltr
                                  ? 1
                                  : 0)),
                          topLeft: Radius.circular(Dimensions.radius *
                              (DynamicLanguage.languageDirection ==
                                  TextDirection.ltr
                                  ? 0
                                  : 1)),
                          bottomLeft: Radius.circular(Dimensions.radius * (DynamicLanguage.languageDirection ==
                              TextDirection.ltr
                              ? 0 : 1)),
                        )
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  _infoWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.6),
      child: Obx(() => Column(
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainStart,
        children: [
          SortInfoWidget(
            name: Strings.exchangeRate,
            value:
            "1 ${_controller.selectedWallet.value.currencyCode} = ${_controller.exchangeRate.value.toStringAsFixed(4)} ${_controller.selectedGateway.value.currencyCode}",
          ),
          SortInfoWidget(
            name: Strings.limit,
            value:
            "${_controller.min.value.toStringAsFixed(2)} ~ ${_controller.max.value.toStringAsFixed(2)} ${_controller.selectedWallet.value.currencyCode}",
          ),
          SortInfoWidget(
            name: Strings.charge,
            value:
            "${_controller.selectedGateway.value.fixedCharge.toStringAsFixed(2)} ${_controller.selectedGateway.value.currencyCode} + ${_controller.selectedGateway.value.percentCharge}% = ${_controller.totalCharge.value.toStringAsFixed(2)} ${_controller.selectedGateway.value.currencyCode}",
          ),
        ],
      )),
    );
  }

  _continueButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.5),
      child: Obx(() => _controller.isSubmitLoading ? CustomLoadingAPI(): PrimaryButtonWidget(
        title: Strings.conTinue,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _controller.withdrawMoneySubmitProcess();
          }
        },
        borderColor: CustomColor.primaryColor,
        backgroundColor: CustomColor.primaryColor,
        textColor: CustomColor.whiteColor,
      )),
    );
  }
}
