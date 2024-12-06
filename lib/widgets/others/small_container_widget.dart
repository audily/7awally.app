import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/size.dart';

import '../../utils/custom_color.dart';
import '../labels/primary_text_widget.dart';

class SmallContainerWidget extends StatelessWidget {
  const SmallContainerWidget({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.containerName,
    this.loader = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String icon;
  final String containerName;
  final bool loader;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: crossCenter,
        children: [
          GestureDetector(
              onTap: loader ? null : onPressed,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: loader ? EdgeInsets.all(16) : EdgeInsets.all(16),
                width: loader ? 50 : 65,
                height: loader ? 50 : 60,
                decoration: BoxDecoration(
                  color: loader
                      ? CustomColor.whiteColor.withOpacity(.2)
                      : CustomColor.secondaryColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: SvgPicture.asset(
                  icon,
                  // height: loader ? 30 : 40,
                  // width: loader ? 30 : 40,
                ),
              )),
          addVerticalSpace(5.h),
          PrimaryTextWidget(
            text: containerName,
            style: CustomStyler.cardSmallContainerStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
