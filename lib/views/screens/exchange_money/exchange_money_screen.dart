import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/dropdown/custom_dropdown_widget.dart';
import 'package:walletium/widgets/inputs/input_text_field.dart';
import 'package:walletium/widgets/labels/text_labels_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../backend/services_and_models/exchange_money/exchange_money_index_model.dart';
import '../../../controller/exchange_money/exchange_money_controller.dart';
import '../../../widgets/labels/limit_info_widget.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class ExchangeMoneyScreen extends StatelessWidget {
  ExchangeMoneyScreen({Key? key}) : super(key: key);
  final _controller = Get.find<ExchangeMoneyController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.exchangeMoney,
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
        addVerticalSpace(Dimensions.paddingVerticalSize),
        Obx(() => Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * 2,
                  vertical: Dimensions.paddingVerticalSize * 1.5),
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * 2,
                  vertical: Dimensions.paddingVerticalSize * 1),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 1),
                  color: CustomColor.primaryColor.withOpacity(.8)),
              child: Column(
                children: [
                  PrimaryTextWidget(
                    text: Strings.exchangeRate,
                    color: CustomColor.whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                  addVerticalSpace(Dimensions.paddingVerticalSize * .4),
                  PrimaryTextWidget(
                    text:
                        "1 ${_controller.fromWallet.value.currencyCode} = ${_controller.exchangeRate.value.toStringAsFixed(4)} ${_controller.toWallet.value.currencyCode}",
                    color: CustomColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )),
        _inputWidgets(context),
        _continueButtonWidget(context),
        addVerticalSpace(20.h),
      ],
    );
  }

  _inputWidgets(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          // addVerticalSpace(Dimensions.paddingVerticalSize),
          TextLabelsWidget(
            textLabels: Strings.exchangeFrom,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: InputTextField(
              controller: _controller.fromController,
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
                  _controller.fromController.text = "0.";
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
                            _controller.exchangeMoneyIndexModel.data.userWallet,
                        onChanged: (value) {
                          _controller.fromWallet.value = value!;
                          _controller
                              .calculation(_controller.fromController.text);
                        },
                        selectedValue: _controller.fromWallet.value,
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

          _infoWidget(context),

          TextLabelsWidget(
            textLabels: Strings.exchangeTo,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: InputTextField(
              readOnly: true,
              controller: _controller.toController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              hintText: "0.0",
              backgroundColor: Colors.transparent,
              hintTextColor: CustomColor.textColor,
              borderColor: CustomColor.gray,
              suffix: SizedBox(
                  width: MediaQuery.sizeOf(context).width * .3,
                  height: Dimensions.buttonHeight * .8,
                  child: Obx(
                    () => CustomDropDown<UserWallet>(
                        items:
                            _controller.exchangeMoneyIndexModel.data.userWallet,
                        onChanged: (value) {
                          _controller.toWallet.value = value!;
                          _controller
                              .calculation(_controller.fromController.text);
                        },
                        selectedValue: _controller.toWallet.value,
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

          addVerticalSpace(Dimensions.paddingVerticalSize * 2)
        ],
      ),
    );
  }

  _continueButtonWidget(BuildContext context) {
    return Obx(() => _controller.isSubmitLoading
        ? CustomLoadingAPI()
        : PrimaryButtonWidget(
            title: Strings.conTinue,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _controller.exchangeMoneySubmitProcess();
              }
            },
            borderColor: CustomColor.primaryColor,
            backgroundColor: CustomColor.primaryColor,
            textColor: CustomColor.whiteColor,
          ));
  }

  _infoWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.6),
      child: Obx(() => Column(
            crossAxisAlignment: crossStart,
            mainAxisAlignment: mainStart,
            children: [
              SortInfoWidget(
                name: Strings.availableBalance,
                value:
                    "${_controller.fromWallet.value.balance.toStringAsFixed(2)} ${_controller.fromWallet.value.currencyCode}",
              ),
              SortInfoWidget(
                name: Strings.limit,
                value:
                    "${_controller.min.value.toStringAsFixed(2)} ~ ${_controller.max.value.toStringAsFixed(2)} ${_controller.fromWallet.value.currencyCode}",
              ),
              SortInfoWidget(
                name: Strings.charge,
                value:
                    "${_controller.fix.value.toStringAsFixed(2)} ${_controller.fromWallet.value.currencyCode} + ${_controller.perc}% = ${_controller.totalCharge.value.toStringAsFixed(2)} ${_controller.fromWallet.value.currencyCode}",
              ),
            ],
          )),
    );
  }
}
