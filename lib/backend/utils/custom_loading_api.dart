import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_color.dart';

class CustomLoadingAPI extends StatelessWidget {
  const CustomLoadingAPI({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWaveSpinner(
        waveColor: color ?? CustomColor.primaryColor,
        color: color ?? CustomColor.primaryColor,
      ),
    );
  }
}