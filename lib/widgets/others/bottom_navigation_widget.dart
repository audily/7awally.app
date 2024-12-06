import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/controller/btm_nav/bottom_navigation_controller.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/views/screens/bottom_nav/home_screen.dart';
import 'package:walletium/views/screens/bottom_nav/notification_screen.dart';
import 'package:walletium/views/screens/bottom_nav/profile_screen.dart';
import 'package:walletium/views/screens/bottom_nav/wallet_screen.dart';

import '../../utils/assets.dart';
import '../../utils/strings.dart';

class BottomNavigationWidget extends StatelessWidget {
  BottomNavigationWidget({Key? key}) : super(key: key);

  final _controller = Get.put(BottomNavigationController());

  static List<StatelessWidget> mainScreens = [
    const HomeScreen(),
    const WalletScreen(),
    const NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Obx(
      () => Scaffold(
          backgroundColor: CustomColor.primaryBackgroundColor,
          body: _controller.isLoading
              ? CustomLoadingAPI()
              : mainScreens[_controller.getIndex()],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => _controller.setIndex(index),
            backgroundColor: CustomColor.primaryColor,
            currentIndex: _controller.getIndex(),
            selectedItemColor: CustomColor.whiteColor,
            unselectedItemColor: CustomColor.whiteColor.withOpacity(0.5),
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 11,
            selectedFontSize: 12,
            elevation: 2,
            unselectedLabelStyle: const TextStyle(fontSize: 8),
            selectedLabelStyle: const TextStyle(fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: Opacity(
                        opacity: _controller.getIndex() == 0 ? 1 : .5,
                        child: SvgPicture.asset(Assets.home))
                    .paddingOnly(top: 5),
                label: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.home),
              ),
              BottomNavigationBarItem(
                icon: Opacity(
                        opacity: _controller.getIndex() == 1 ? 1 : .5,
                        child: SvgPicture.asset(Assets.wallet))
                    .paddingOnly(top: 5),
                label: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.wallet),
              ),
              BottomNavigationBarItem(
                icon: Opacity(
                        opacity: _controller.getIndex() == 2 ? 1 : .5,
                        child: SvgPicture.asset(Assets.notification))
                    .paddingOnly(top: 5),
                label: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.notification),
              ),
              BottomNavigationBarItem(
                icon: Opacity(
                        opacity: _controller.getIndex() == 3 ? 1 : .5,
                        child: SvgPicture.asset(Assets.profile))
                    .paddingOnly(top: 5),
                label: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.profile),
              ),
            ],
          )),
    );
  }
}
