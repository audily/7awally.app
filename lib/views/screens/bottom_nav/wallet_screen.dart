import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/views/screens/drawer/drawer_screen.dart';

import '../../../backend/services_and_models/bottom_nav/models/dashboard_model.dart';
import '../../../controller/btm_nav/bottom_navigation_controller.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/wallet_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBackgroundColor,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        iconTheme: const IconThemeData(color: CustomColor.whiteColor),
        title: const PrimaryTextWidget(text: Strings.wallet,  color: CustomColor.whiteColor),
        elevation: 0,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize,
        vertical: Dimensions.paddingVerticalSize
      ),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 1.3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 280,
      ),
      itemCount: Get.find<BottomNavigationController>()
          .dashboardModel
          .data
          .wallets.length,
      itemBuilder: (BuildContext context, int index) {
        Wallet data = Get.find<BottomNavigationController>()
            .dashboardModel
            .data
            .wallets[index];
        return WalletWidget(data: data, index: index);
      },
    );
  }

}
