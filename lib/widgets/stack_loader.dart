import 'package:flutter/material.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';

import '../utils/custom_color.dart';

class TransparentLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5), // Transparent black background
      child: Center(
        child: CustomLoadingAPI(
          color: CustomColor.primaryColor,
        ), // Loader widget
      ),
    );
  }
}