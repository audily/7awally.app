import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/backend/utils/custom_snackbar.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/widgets/others/back_button_widget.dart';

import '../../../backend/services_and_models/api_endpoint.dart';
import '../../../backend/services_and_models/recipient/my_recipient_model.dart';
import '../../../backend/utils/no_data_widget.dart';
import '../../../controller/send_money/select_recipient_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_style.dart';
import '../../../widgets/buttons/primary_button_widget.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class SelectRecipientScreen extends StatelessWidget {
  SelectRecipientScreen({Key? key}) : super(key: key);
  final _controller = Get.find<SelectRecipientController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryTextWidget(
          text: Strings.myRecipient,
          style: TextStyle(color: CustomColor.whiteColor),
        ),
        leading: const BackButtonWidget(
          
        ),
        actions: [
          TextButton.icon(
              onPressed: () {
                Get.toNamed(Routes.addRecipientScreen);
              },
              icon: Icon(
                Icons.add,
                color: CustomColor.whiteColor,
              ),
              label: PrimaryTextWidget(
                text: Strings.addRecipient,
                color: CustomColor.whiteColor,
              ))
        ],
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
      ),
      body: Obx(() =>
          _controller.isLoading ? CustomLoadingAPI() : _bodyWidget(context)),
      bottomNavigationBar: _continueButtonWidget(context),
    );
  }

  _continueButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.5),
      child: PrimaryButtonWidget(
        title: Strings.conTinue,
        onPressed: () {
          if (_controller.selectedUser.value == -1) {
            CustomSnackBar.error(Strings.selectRecipientFirst);
          } else {
            Get.toNamed(Routes.sendMoneyDetailsScreen);
          }
        },
        borderColor: CustomColor.primaryColor,
        backgroundColor: CustomColor.primaryColor,
        textColor: CustomColor.whiteColor,
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return _controller.myRecipientModel.data.receipients.isEmpty
        ? NoDataWidget()
        : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingHorizontalSize,
                vertical: Dimensions.paddingVerticalSize),
            itemCount: _controller.myRecipientModel.data.receipients.length,
            itemBuilder: (BuildContext context, int index) {
              Receipient data =
                  _controller.myRecipientModel.data.receipients[index];
              return Obx(() => Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_controller.selectedIndex.value == index) {
                            _controller.selectedIndex.value = -1;
                          } else {
                            _controller.selectedIndex.value = index;
                          }
                        },
                        child: Container(
                          height: Dimensions.buttonHeight * 1.2,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingHorizontalSize,
                              vertical: Dimensions.paddingVerticalSize),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius),
                            color: CustomColor.whiteColor.withOpacity(1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1), // Shadow color
                                spreadRadius: 5, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset:
                                    Offset(0, 3), // Offset from the container
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(data.image.isEmpty
                                    ? "${ApiEndpoint.mainDomain}/${data.defaultImage}"
                                    : "${ApiEndpoint.mainDomain}/${data.pathLocation}/${data.image}"),
                              ),
                              addHorizontalSpace(5),
                              Column(
                                crossAxisAlignment: crossStart,
                                children: [
                                  PrimaryTextWidget(
                                    text: data.firstname + " " + data.lastname,
                                  ),
                                  addVerticalSpace(5),
                                  PrimaryTextWidget(
                                    text: data.email,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Obx(() => SizedBox(
                                    width: Dimensions.widthSize * 7,
                                    child: GestureDetector(
                                      onTap: () {
                                        _controller.selectedUser.value = index;
                                        _controller.id.value =
                                            data.userId.toString();
                                        _controller.email.value = data.email;
                                        _controller.name.value =
                                            data.firstname +
                                                " " +
                                                data.lastname;
                                        debugPrint('''
                                    ${_controller.id.value}
                                    ${_controller.email.value}
                                    ${_controller.name.value}
                                    ''');
                                      },
                                      child: AnimatedSwitcher(
                                        duration: Duration(milliseconds: 300),
                                        transitionBuilder: (Widget child,
                                            Animation<double> animation) {
                                          return ScaleTransition(
                                            scale: animation,
                                            child: child,
                                          );
                                        },
                                        child: _controller.selectedUser.value ==
                                                index
                                            ? Icon(
                                                Icons.check_circle,
                                                key: Key('selected'),
                                                color:
                                                    CustomColor.secondaryColor,
                                                size: 30,
                                              )
                                            : AnimatedContainer(
                                                key: Key('button'),
                                                duration:
                                                    Duration(milliseconds: 300),
                                                decoration: BoxDecoration(
                                                  color:
                                                      CustomColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.all(12),
                                                child: PrimaryTextWidget(
                                                  text: Strings.select,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    // fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(
                            milliseconds: 500), // Duration for the animation
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingHorizontalSize,
                            vertical: Dimensions.paddingVerticalSize),
                        height: _controller.selectedIndex.value == index
                            ? null
                            : 0, // Set height based on visibility
                        child: Visibility(
                          visible: _controller.selectedIndex.value == index,
                          child: DelayedDisplay(
                            delay: Duration(milliseconds: 450),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Divider(),
                                _rowWidget(
                                    context, Strings.username, data.username),
                                const Divider(),
                                _rowWidget(context, Strings.name,
                                    data.firstname + " " + data.lastname),
                                const Divider(),
                                _rowWidget(
                                    context, Strings.country, data.country),
                                const Divider(),
                                _rowWidget(
                                    context, Strings.zipCode, data.zipCode),
                                const Divider(),
                                _rowWidget(context, Strings.email, data.email),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                addVerticalSpace(Dimensions.paddingVerticalSize * .6),
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
          style: CustomStyler.otpVerificationDescriptionStyle,
        )
      ],
    );
  }
}
