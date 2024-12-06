import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/add_money/add_money_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/others/crypto_address_info_widget.dart';

class AddMoneyTatumScreen extends StatelessWidget {
  AddMoneyTatumScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
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
        CryptoAddressInfoWidget(address: _controller.addMoneyTatumModel.data.addressInfo.address),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ..._controller.inputFields.map((element) {
                return element;
              }),
              addVerticalSpace(Dimensions.paddingVerticalSize),
            ],
          ),
        ),
        _continueButtonWidget(context),
      ],
    );
  }

  _continueButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.5),
      child: Obx(() => _controller.isTatumSubmitLoading ? CustomLoadingAPI(): PrimaryButtonWidget(
        title: Strings.conTinue,
        onPressed: () {
          if(formKey.currentState!.validate()){
              _controller.addMoneyTatumSubmitProcess();
          }
        },
        borderColor: CustomColor.primaryColor,
        backgroundColor: CustomColor.primaryColor,
        textColor: CustomColor.whiteColor,
      )),
    );
  }
}