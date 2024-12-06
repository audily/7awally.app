import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';

import '../backend/services_and_models/request_money/request_money_info_model.dart';
import '../controller/request_money/request_money_controller.dart';
import '../routes/routes.dart';
import '../utils/custom_style.dart';
import '../utils/dimsensions.dart';
import '../utils/size.dart';
import '../utils/strings.dart';
import '../widgets/buttons/primary_button_widget.dart';
import '../widgets/inputs/input_text_field.dart';
import '../widgets/labels/primary_text_widget.dart';
import '../widgets/labels/text_labels_widget.dart';
import '../widgets/others/back_button_widget.dart';
import '../widgets/will_pop_widget.dart';

class DeepLinkScreen extends StatefulWidget {
  const DeepLinkScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<DeepLinkScreen> createState() => _DeepLinkScreenState();
}

class _DeepLinkScreenState extends State<DeepLinkScreen> {
  final _controller = Get.put(RequestMoneyController());
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.codeController.clear();
    _controller.showDetails.value = false;
    if (widget.id.isNotEmpty) {
      _controller.requestMoneyInfoProcess(widget.id);
    }
    super.initState();
  }

  String extractTokenFromUrl(String url) {
    // Split the URL by '/'
    List<String> segments = url.split('/');

    // Get the last segment
    String lastSegment = segments.last;

    return lastSegment;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      onPopMethod: (){
        Get.offAllNamed(Routes.bottomNavigationScreen);
      },
      canPop: false,
      child: Scaffold(
        backgroundColor: CustomColor.primaryBackgroundColor,
        appBar: AppBar(
          title: const PrimaryTextWidget(
            text: Strings.requestMoneyPayment,
            style: TextStyle(color: CustomColor.whiteColor),
          ),
          leading: BackButtonWidget(
            onBack: (){
              Get.offAllNamed(Routes.bottomNavigationScreen);
            },
          ),
          backgroundColor: CustomColor.primaryColor,
          elevation: 0,
        ),
        body: Obx(() => _controller.isInfoLoading
            ? CustomLoadingAPI()
            : _bodyWidget(context)),
      ),
    );
  }

  /// todo => if id is empty, then paste the code in primary field and fetch information
  /// todo => or if is not empty then auto fetch in initState
  _bodyWidget(BuildContext context) {
    return ListView(
      children: !_controller.showDetails.value
          ? [
              _inputWidgets(context),
              _continueButtonWidget2(context),
              // addVerticalSpace(20.h),
            ]
          : [
              addVerticalSpace(10.h),
              _detailsWidget(context),
              _continueButtonWidget(context),
            ],
    );
  }

  _detailsWidget(BuildContext context) {
    RequestMoneyInfo data =
        _controller.requestMoneyInfoModel.data.requestMoneyInfo;
    return Container(
      margin: EdgeInsets.all(Dimensions.marginSize * 0.5),
      child: Column(
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          PrimaryTextWidget(
            text: Strings.confirmDetails,
            style: CustomStyler.onboardTitleStyle,
          ),
          const Divider(),
          _rowWidget(context, data.token, data.status == 1 ? Strings.paid: Strings.pending),
          const Divider(),
          _rowWidget(
              context,
              Strings.requestAmount,
              data.requestAmount.toStringAsFixed(2) +
                  " " +
                  data.requestCurrency),
          const Divider(),
          _rowWidget(
            context,
            Strings.receiver,
            data.receiverEmail,
          ),
          const Divider(),
          _rowWidget(context, Strings.charge,
              data.totalCharge.toStringAsFixed(2) + " " + data.requestCurrency),
          const Divider(),
          _rowWidget(
              context,
              Strings.totalPayable,
              data.totalPayable.toStringAsFixed(2) +
                  " " +
                  data.requestCurrency),
          const Divider(),
          _rowWidget(context, Strings.remarks, data.remark),
        ],
      ),
    );
  }

  _continueButtonWidget(BuildContext context) {
    RequestMoneyInfo data =
        _controller.requestMoneyInfoModel.data.requestMoneyInfo;
    return data.status == 1
        ? SizedBox.shrink()
        : Container(
            margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.5),
            child: Obx(() => _controller.isConfirmLoading
                ? CustomLoadingAPI()
                : PrimaryButtonWidget(
                    title: Strings.conTinue,
                    onPressed: () {
                      _controller.requestMoneyConfirmProcess();
                    },
                    borderColor: CustomColor.primaryColor,
                    backgroundColor: CustomColor.primaryColor,
                    textColor: CustomColor.whiteColor,
                  )),
          );
  }

  _rowWidget(BuildContext context, String title, String amount) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        PrimaryTextWidget(
          text: title,
          style: CustomStyler.otpVerificationDescriptionStyle,
        ),
        PrimaryTextWidget(
          text: amount,
          textAlign: TextAlign.end,
          style: CustomStyler.otpVerificationDescriptionStyle,
        )
      ],
    );
  }

  /// --------------------------------------------------

  _inputWidgets(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          addVerticalSpace(Dimensions.paddingVerticalSize),
          TextLabelsWidget(
            textLabels: Strings.token,
            textColor: CustomColor.textColor,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
            child: InputTextField(
              controller: _controller.codeController,
              hintText: Strings.enterToken,
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

  _continueButtonWidget2(BuildContext context) {
    return PrimaryButtonWidget(
      title: Strings.conTinue,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          String token = _controller.codeController.text.contains('request-money/payment') ? extractTokenFromUrl(_controller.codeController.text): _controller.codeController.text;
          _controller.requestMoneyInfoProcess(token);
        }
      },
      borderColor: CustomColor.primaryColor,
      backgroundColor: CustomColor.primaryColor,
      textColor: CustomColor.whiteColor,
    );
  }
}
