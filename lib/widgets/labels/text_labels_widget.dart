import 'package:flutter/material.dart';
import 'package:walletium/utils/dimsensions.dart';

import 'primary_text_widget.dart';

// ignore: must_be_immutable
class TextLabelsWidget extends StatelessWidget {
  TextLabelsWidget(
      {Key? key,
      required this.textLabels,
      required this.textColor,
      this.margin = 0.5})
      : super(key: key);

  final String textLabels;
  final Color textColor;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: (Dimensions.paddingHorizontalSize * 2) * margin,
          vertical: (Dimensions.paddingVerticalSize * 1) * margin,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: PrimaryTextWidget(
              text: textLabels,
              style: TextStyle(
                  color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
