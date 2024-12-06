import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/logs/add_money_log_controller.dart';
import '../../../../utils/custom_color.dart';
import '../../../../utils/dimsensions.dart';
import '../../../../utils/size.dart';
import '../../../../utils/strings.dart';
import '../../../../widgets/buttons/primary_button_widget.dart';
import '../../../../widgets/labels/primary_text_widget.dart';
import '../../../../widgets/others/back_button_widget.dart';
import '../../../../widgets/others/crypto_address_info_widget.dart';

class LogTatumScreen extends StatelessWidget {
  LogTatumScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final _controller = Get.find<AddMoneyLogController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  PrimaryTextWidget(
          text: _controller.logTatumModel.data.addressInfo.coin,
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
        CryptoAddressInfoWidget(
            address: _controller.logTatumModel.data.addressInfo.address),
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
      child: Obx(() => _controller.isTatumSubmitLoading
          ? CustomLoadingAPI()
          : PrimaryButtonWidget(
              title: Strings.conTinue,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  _controller.logTatumSubmitProcess();
                }
              },
              borderColor: CustomColor.primaryColor,
              backgroundColor: CustomColor.primaryColor,
              textColor: CustomColor.whiteColor,
            )),
    );
  }
}
