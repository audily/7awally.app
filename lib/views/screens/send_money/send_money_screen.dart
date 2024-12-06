import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/send_money/send_money_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../backend/services_and_models/send_money/send_money_index_model.dart';
import '../../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../../widgets/inputs/input_text_field.dart';
import '../../../widgets/labels/limit_info_widget.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/labels/text_labels_widget.dart';

class SendMoneyScreen extends StatelessWidget {
  SendMoneyScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final _controller = Get.find<SendMoneyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.sendMoney,
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
                        "1 ${_controller.senderWallet.value.currencyCode} = ${_controller.exchangeRate.value.toStringAsFixed(4)} ${_controller.recipientWallet.value.currencyCode}",
                    color: CustomColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )),
        _youSendWidget(context),
        _continueButtonWidget(context)
      ],
    );
  }

  _youSendWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TextLabelsWidget(
            textLabels: Strings.sendingAmount,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: InputTextField(
              controller: _controller.senderController,
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
                  _controller.senderController.text = "0.";
                  _controller.calculation("0.");
                } else {
                  _controller.calculation(value.toString());
                }
              },
              suffix: SizedBox(
                  width: MediaQuery.sizeOf(context).width * .3,
                  height: Dimensions.buttonHeight * .8,
                  child: Obx(
                    () => CustomDropDown<ErWallet>(
                        items: _controller.sendMoneyIndexModel.data.userWallet,
                        onChanged: (value) {
                          _controller.senderWallet.value = value!;
                          _controller
                              .calculation(_controller.senderController.text);
                        },
                        selectedValue: _controller.senderWallet.value,
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
            textLabels: Strings.recipientsAmount,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: InputTextField(
              readOnly: true,
              controller: _controller.receiverController,
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
                    () => CustomDropDown<ErWallet>(
                        items: _controller
                            .sendMoneyIndexModel.data.receiverWallets,
                        onChanged: (value) {
                          _controller.recipientWallet.value = value!;
                          _controller
                              .calculation(_controller.senderController.text);
                        },
                        selectedValue: _controller.recipientWallet.value,
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
                    "${_controller.senderWallet.value.balance.toStringAsFixed(2)} ${_controller.senderWallet.value.currencyCode}",
              ),
              SortInfoWidget(
                name: Strings.limit,
                value:
                    "${_controller.min.value.toStringAsFixed(2)} ~ ${_controller.max.value.toStringAsFixed(2)} ${_controller.senderWallet.value.currencyCode}",
              ),
              SortInfoWidget(
                name: Strings.charge,
                value:
                    "${_controller.fix.value.toStringAsFixed(2)} ${_controller.senderWallet.value.currencyCode} + ${_controller.perc}% = ${_controller.totalCharge.value.toStringAsFixed(2)} ${_controller.senderWallet.value.currencyCode}",
              ),
            ],
          )),
    );
  }

  _continueButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.5),
      child: Obx(() => _controller.selectRecipientController.isLoading || _controller.isSubmitLoading
          ? CustomLoadingAPI()
          : PrimaryButtonWidget(
              title: Strings.conTinue,
              onPressed: () {
                if(formKey.currentState!.validate()) {
                  _controller.sendMoneySubmitProcess();
                }
              },
              borderColor: CustomColor.primaryColor,
              backgroundColor: CustomColor.primaryColor,
              textColor: CustomColor.whiteColor,
            )),
    );
  }
}
