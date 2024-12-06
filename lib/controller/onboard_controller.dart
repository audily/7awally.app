import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/controller/settings_controller.dart';
import 'package:walletium/routes/routes.dart';

class OnBoardController extends GetxController {
  var selectedIndex = 0.obs;
  var pageController = PageController();

  bool get isLastPage =>
      selectedIndex.value ==
      Get.find<SettingController>()
              .basicSettingModel
              .data
              .onboardScreens
              .length -
          1;

  void nextPage() {
    if (isLastPage) {
    } else {
      pageController.nextPage(
        duration: 300.milliseconds,
        curve: Curves.ease,
      );
    }
  }

  pageNavigate() {
    Get.offAllNamed(Routes.welcomeScreen);
  }

  void onTapCheck() {
    (!isLastPage) ? nextPage() : pageNavigate();
  }
}
