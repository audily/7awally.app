import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/backend/utils/custom_snackbar.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/labels/text_labels_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../backend/services_and_models/add_money/add_money_index_model.dart';
import '../../../controller/add_money/add_money_controller.dart';
import '../../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../../widgets/inputs/input_text_field.dart';
import '../../../widgets/labels/limit_info_widget.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class AddMoneyScreen extends StatelessWidget {
  AddMoneyScreen({Key? key}) : super(key: key);
  final _controller = Get.find<AddMoneyController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.addMoney,
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
                        "1 ${_controller.selectedWallet.value.currencyCode} = ${_controller.exchangeRate.value.toStringAsFixed(4)} ${_controller.selectedGateway.value.currencyCode}",
                    color: CustomColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )),
        _inputWidget(context),
        _infoWidget(context),
        addVerticalSpace(30.h),
        _continueButtonWidget(context),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          addVerticalSpace(10.h),
          TextLabelsWidget(
            textLabels: Strings.paymentMethod,
            textColor: CustomColor.textColor,
          ),
          Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
              child: Obx(
                () => CustomDropDown<Currency>(
                  items: _controller.gatewayList,
                  onChanged: (value) {
                    _controller.selectedGateway.value = value!;
                    _controller.calculation(_controller.amountController.text);
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
                        items: _controller
                            .addMoneyIndexModel.data.paymentGateways.userWallet,
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
                name: Strings.availableBalance,
                value:
                    "${_controller.selectedWallet.value.balance.toStringAsFixed(2)} ${_controller.selectedWallet.value.currencyCode}",
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
    return Obx(() => _controller.isSubmitLoading
        ? CustomLoadingAPI()
        : PrimaryButtonWidget(
            title: Strings.conTinue,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                double amount = double.parse(_controller.amountController.text);
                if(amount.isGreaterThan(_controller.min.value - .0001) && amount.isLowerThan(_controller.max.value + .0001)){
                  debugPrint('''
                1. >>>  ${_controller.selectedWallet.value.currencyCode},
                2. >>>  ${_controller.selectedGateway.value.alias},
                3. >>>  ${_controller.selectedGateway.value.name}
                ''');

                  if(_controller.selectedGateway.value.alias.contains("automatic")){
                    if(_controller.selectedGateway.value.alias.contains("tatum")){
                      debugPrint(" >>> 1");
                      _controller.addMoneyTatumProcess();
                    }
                    else{
                      debugPrint(" >>> 2");
                      _controller.addMoneyAutomaticSubmitProcess();
                    }
                  }
                  else{
                    debugPrint(" >>> 3");
                    _controller.addMoneyManualGatewayProcess();
                  }
                }else{
                  CustomSnackBar.error(Strings.pleaseFollowTheLimit);
                }
              }
            },
            borderColor: CustomColor.primaryColor,
            backgroundColor: CustomColor.primaryColor,
            textColor: CustomColor.whiteColor,
          ));
  }
}
