import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../controller/profile/fa_controller.dart';
import '../../../utils/assets.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class FAScreen extends StatelessWidget {
  FAScreen({Key? key}) : super(key: key);
  final _controller = Get.put(FAController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.twoFA,
          style: TextStyle(color: CustomColor.whiteColor),
        ),
        leading: const BackButtonWidget(
          
        ),
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
      ),
      body: Obx(() => _controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }


  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize * .75),
      child: Column(
        mainAxisAlignment: mainStart,
        children: [
          addVerticalSpace(Dimensions.paddingVerticalSize),
          Container(
            decoration: BoxDecoration(
              color: CustomColor.primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(Dimensions.radius)
            ),
            padding: const EdgeInsets.all(24.0),
            margin: const EdgeInsets.all(24.0),
            child: FadeInImage(
              placeholder: AssetImage(
                Assets.drawerBG
              ),
              image: NetworkImage(_controller.faInfoModel.data.qrCode),
            )
          ),
          _enableTwoFATitleWidget(context),
          _enableTwoFASubTitleWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _enableTwoFATitleWidget(BuildContext context) {
    return PrimaryTextWidget(
        padding: EdgeInsets.only(
            top: Dimensions.paddingVerticalSize * .75,
            bottom: Dimensions.paddingVerticalSize * .5),
        text: _controller.faInfoModel.data.status == 0
            ? Strings.enableTwoFASecurity
            : Strings.disableTwoFASecurity

    );
  }

  _enableTwoFASubTitleWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.paddingVerticalSize),
      child: SelectableText(
        _controller.faInfoModel.data.message,
        style: TextStyle(
          color: CustomColor.textColor.withOpacity(.40),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(() => _controller.isUpdateLoading
        ? const CustomLoadingAPI()
        : PrimaryButtonWidget(
      title: _controller.faInfoModel.data.status == 0
          ? Strings.enable.tr
          : Strings.disable.tr,
      onPressed: () {
        _controller.fAStatusUpdateProcess();
      },
      borderColor: CustomColor.primaryColor,
      backgroundColor: CustomColor.primaryColor,
      textColor: CustomColor.whiteColor,
    ));
  }
}
