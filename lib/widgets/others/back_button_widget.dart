import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_color.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key, this.onBack})
      : super(key: key);
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onBack ??
            () {
              Get.close(1);
            },
        child: Obx(() => Transform.rotate(
            angle: DynamicLanguage.selectedLanguage.value.contains("ar")
                ? 3.14
                : 0,
            child: CircleAvatar(
                backgroundColor: CustomColor.primaryColor,
                child: Icon(Icons.arrow_back, color: Colors.white)))));
  }
}
