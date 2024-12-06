import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/routes/routes.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/buttons/primary_button_widget.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../controller/withdraw_money/withdraw_controller.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class WithdrawMoneyDetailsScreen extends StatelessWidget {
  WithdrawMoneyDetailsScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final _controller = Get.find<WithdrawController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.withdrawMoneyDetails,
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

        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize * .8,
            vertical: Dimensions.paddingVerticalSize * .8
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize * .8,
            vertical: Dimensions.paddingVerticalSize * .8
          ),
          decoration: BoxDecoration(
            color: CustomColor.primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: PrimaryTextWidget(text: _controller.withdrawMoneySubmitModel.data.details, color: CustomColor.whiteColor),
        ),

        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ..._controller.inputFields.map((element) {
                return element;
              }),
              addVerticalSpace(Dimensions.paddingVerticalSize),
              Visibility(
                visible: _controller.inputFileFields.isNotEmpty,
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.marginSize * 0.5),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: .99,
                    ),
                    itemCount: _controller.inputFileFields.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _controller.inputFileFields[index];
                    }),
              ),
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
      child: PrimaryButtonWidget(
        title: Strings.conTinue,
        onPressed: () {
          if(formKey.currentState!.validate()){
            // if(_controller.listImagePath.any((element) => element.isNotEmpty)){
              Get.toNamed(Routes.withdrawMoneyReviewScreen);
            // }else{
            //   CustomSnackBar.error(Strings.selectFileFirst);
            // }

          }

        },
        borderColor: CustomColor.primaryColor,
        backgroundColor: CustomColor.primaryColor,
        textColor: CustomColor.whiteColor,
      ),
    );
  }
}
