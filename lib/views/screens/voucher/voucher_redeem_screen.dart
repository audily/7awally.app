import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/inputs/input_text_field.dart';
import 'package:walletium/widgets/labels/text_labels_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../controller/voucher/voucher_controller.dart';
import '../../../routes/routes.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class RedeemVoucherScreen extends StatelessWidget {
  RedeemVoucherScreen({Key? key}) : super(key: key);
  final _controller = Get.find<VoucherController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.redeemVoucher,
          style: TextStyle(color: CustomColor.whiteColor),
        ),
        leading: const BackButtonWidget(
          
        ),
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.voucherLogScreen);
              },
              icon: Icon(
                Icons.history,
                color: CustomColor.whiteColor,
              ))
        ],
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
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
          addVerticalSpace(Dimensions.paddingVerticalSize),
          TextLabelsWidget(
            textLabels: Strings.voucherCode,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: InputTextField(
              controller: _controller.codeController,
              hintText: "${DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.enter)} ${DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.voucherCode)}",
              backgroundColor: Colors.transparent,
              hintTextColor: CustomColor.textColor,
              borderColor: CustomColor.gray,
            ),
          ),
          addVerticalSpace(Dimensions.paddingVerticalSize * 2)
        ],
      ),
    );
  }

  _continueButtonWidget(BuildContext context) {
    return Obx(() => _controller.isRedeemLoading
        ? CustomLoadingAPI()
        : PrimaryButtonWidget(
            title: Strings.conTinue,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _controller.voucherRedeemProcess();
              }
            },
            borderColor: CustomColor.primaryColor,
            backgroundColor: CustomColor.primaryColor,
            textColor: CustomColor.whiteColor,
          ));
  }
}
