import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../../utils/strings.dart';

class CustomSnackBar1 {
  static success(String message) {
    return Get.snackbar(
        DynamicLanguage.isLoading ? "" : DynamicLanguage.key(Strings.success),
        DynamicLanguage.isLoading ? "" : DynamicLanguage.key(message),
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  static error(String message) {
    return Get.snackbar(
        DynamicLanguage.isLoading ? "" : DynamicLanguage.key(Strings.alert),
        DynamicLanguage.isLoading ? "" : DynamicLanguage.key(message),
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}

class CustomSnackBar {
  static success(String message) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Column(
      crossAxisAlignment: crossStart,
      // mainAxisAlignment: mainSpaceBet,
      children: [
        PrimaryTextWidget(
          text: Strings.success,
          color: Colors.green,
        ),
        addVerticalSpace(5),
        PrimaryTextWidget(
          text: message,
          color: Colors.white,
        ),
      ],
    )));
  }

  static error(String message) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Column(
      crossAxisAlignment: crossStart,
      // mainAxisAlignment: mainSpaceBet,
      children: [
        PrimaryTextWidget(
          text: Strings.alert,
          color: Colors.red,
        ),
        addVerticalSpace(5),
        PrimaryTextWidget(
          text: message,
          color: Colors.white,
        ),
      ],
    )));
  }
}