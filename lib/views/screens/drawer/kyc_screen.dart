import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../controller/profile/kyc_controller.dart';
import '../../../widgets/buttons/primary_button_widget.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class KycScreen extends StatelessWidget {
  KycScreen({Key? key}) : super(key: key);

  final controller = Get.put(KYCController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.kyc,
          style: TextStyle(color: CustomColor.whiteColor),
        ),
        leading: const BackButtonWidget(
          
        ),
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
      ),
      body: Obx(() =>
          controller.isLoading ? CustomLoadingAPI() : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        controller.kycModel.data.status == 0
            ? SizedBox.shrink()
            : Center(
                child: Column(
                  children: [
                    addVerticalSpace(20.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: crossCenter,
                      children: [
                        Icon(
                          getStatusIcon(controller.kycModel.data.status),
                          color:
                              getStatusColor(controller.kycModel.data.status),
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        PrimaryTextWidget(
                          text: getStatusText(controller.kycModel.data.status),
                          style: TextStyle(
                              color: getStatusColor(
                                  controller.kycModel.data.status),
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        addVerticalSpace(20.h),
        _titleWidget(context),
        addVerticalSpace(20.h),
        (controller.kycModel.data.status == 1 ||
                controller.kycModel.data.status == 2)
            ? SizedBox.shrink()
            : Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ...controller.inputFields.map((element) {
                      return element;
                    }),
                    addVerticalSpace(Dimensions.paddingVerticalSize),
                    Visibility(
                      visible: controller.inputFileFields.isNotEmpty,
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
                          itemCount: controller.inputFileFields.length,
                          itemBuilder: (BuildContext context, int index) {
                            return controller.inputFileFields[index];
                          }),
                    ),
                  ],
                ),
              ),
        (controller.kycModel.data.status == 1 ||
                controller.kycModel.data.status == 2)
            ? SizedBox.shrink()
            : _buttonWidget(context),
      ],
    );
  }

  _titleWidget(BuildContext context) {
    return (controller.kycModel.data.status == 1 ||
            controller.kycModel.data.status == 2)
        ? SizedBox.shrink()
        : Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: Column(
              mainAxisAlignment: mainCenter,
              crossAxisAlignment: crossCenter,
              children: [
                PrimaryTextWidget(
                  text: Strings.verifyAccount,
                  style: CustomStyler.onboardTitleStyle,
                ),
                PrimaryTextWidget(
                  text: Strings.verifyAccountDescription,
                  textAlign: TextAlign.center,
                  style: CustomStyler.otpVerificationDescriptionStyle,
                ),
              ],
            ),
          );
  }

  _buttonWidget(BuildContext context) {
    return Obx(() => controller.isSubmitLoading
        ? CustomLoadingAPI()
        : PrimaryButtonWidget(
            title: Strings.signUp,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                controller.kycSubmitProcess();
              }
            },
            borderColor: CustomColor.textColor,
            backgroundColor: CustomColor.textColor,
            textColor: CustomColor.whiteColor,
          ));
  }

  String getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Approved';
      case 2:
        return 'Pending';
      case 3:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  IconData getStatusIcon(int status) {
    switch (status) {
      case 1:
        return Icons.verified_user;
      case 2:
        return Icons.pending;
      case 3:
        return Icons.error;
      default:
        return Icons.error_outline;
    }
  }
}
