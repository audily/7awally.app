import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../../utils/dimsensions.dart';
import '../../utils/strings.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: crossCenter,
        mainAxisAlignment: mainCenter,
        children: [
          Lottie.asset('assets/empty_animation.json',height: Dimensions.buttonHeight * 3),
          PrimaryTextWidget(text: Strings.noDataAvailable, fontWeight: FontWeight.w800)
        ],
      ),
    );
  }
}