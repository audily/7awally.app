import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/controller/onboard_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/widgets/buttons/onboard_button.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../controller/settings_controller.dart';
import '../../utils/assets.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({Key? key}) : super(key: key);
  final _controller = Get.put(OnBoardController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: CustomColor.primaryColor, // Cha
      statusBarIconBrightness: Brightness.light, // Change the status bar text color
    ));

    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Obx(() => Get.find<SettingController>().isSettingsLoading
          ? CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        children: [
          Get.find<SettingController>()
                  .basicSettingModel
                  .data
                  .onboardScreens
                  .isEmpty
              ? SizedBox.shrink()
              : Column(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      color: CustomColor.whiteColor,
                      child: PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        controller: _controller.pageController,
                        onPageChanged: _controller.selectedIndex,
                        itemCount: Get.find<SettingController>()
                            .basicSettingModel
                            .data
                            .onboardScreens
                            .length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.bottomCenter,
                            child: Image.network(
                              "${Get.find<SettingController>().basicSettingModel.data.appImagePaths.baseUrl}/${Get.find<SettingController>().basicSettingModel.data.appImagePaths.pathLocation}/${Get.find<SettingController>().basicSettingModel.data.onboardScreens[index].image}",
                              height: MediaQuery.sizeOf(context).height,
                              width: MediaQuery.sizeOf(context).width,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
          Positioned(top: 42, child: _logoWidget(context)),
          Positioned(top: 140, child: _descriptionWidget(context)),
          Positioned(bottom: 90, child: _buttonWidget(context)),
        ],
      ),
    );
  }

  _descriptionWidget(BuildContext context) {
    var data =
        Get.find<SettingController>().basicSettingModel.data.onboardScreens;
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * 1.7,
              vertical: Dimensions.paddingVerticalSize * 0.2),
          child: PrimaryTextWidget(
            text:
                data.isEmpty ? "" : data[_controller.selectedIndex.value].title,
            textAlign: TextAlign.start,
            style: CustomStyler.onboardTitleStyle
                .copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        //dot
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * 1.8,
              vertical: Dimensions.paddingVerticalSize * 1.2),
          child: Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Get.find<SettingController>()
                      .basicSettingModel
                      .data
                      .onboardScreens
                      .isEmpty
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        Get.find<SettingController>()
                            .basicSettingModel
                            .data
                            .onboardScreens
                            .length,
                        (index) => Obx(() => AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.only(right: 10.w),
                              height: 10.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == _controller.selectedIndex.value
                                    ? CustomColor.textColor
                                    : Colors.grey,
                              ),
                            )),
                      ),
                    ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * .9,
          margin: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * 1.8,
              vertical: Dimensions.paddingVerticalSize * 1),
          child: PrimaryTextWidget(
            text: data.isEmpty
                ? ""
                : data[_controller.selectedIndex.value].subTitle,
            textAlign: TextAlign.start,
            style: CustomStyler.onboardDesStyle,
          ),
        ),
      ],
    );
  }

  _logoWidget(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(Dimensions.marginSize),
      child: Image.asset(
        Assets.splashLogo,
        width: 150.w,
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return OnboardButton(
      onPressed: () {
        _controller.onTapCheck();
      },
    );
  }
}
