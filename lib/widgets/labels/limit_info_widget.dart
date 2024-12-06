import 'package:flutter/material.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../../utils/dimsensions.dart';

class SortInfoWidget extends StatelessWidget {
  const SortInfoWidget({super.key, required this.name, required this.value});
  final String name, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.paddingVerticalSize * .1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          PrimaryTextWidget(
            text: name,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w600,
          ),
          PrimaryTextWidget(
            text: ":",
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w600,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: PrimaryTextWidget(
              text: " $value ",
              color: Colors.orangeAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
