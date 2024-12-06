import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:walletium/routes/routes.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';

import '../../../controller/profile/change_password_controller.dart';
import '../../../controller/settings_controller.dart';
import '../../../utils/assets.dart';
import '../../../widgets/dialog_helper.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../deep_link_screen.dart';
import '../../dynamic_web_screen/dynamic_web_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: Border(),
        backgroundColor: CustomColor.whiteColor,
        child: ListView(
          children: [
            _headerDrawer(context),
            _drawerList(context),
          ],
        ),
      ),
    );
  }

  _headerDrawer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      padding: EdgeInsets.all(Dimensions.defaultPaddingSize),
      decoration: BoxDecoration(
          color: Color(0xFF0AD1DD),
          image: DecorationImage(
              image: AssetImage(Assets.drawerBG), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: mainEnd,
        crossAxisAlignment: crossCenter,
        children: [
          Image.asset(Assets.splashLogo),
        ],
      ),
    );
  }

  _drawerList(BuildContext context) {
    return Column(
      children: [
        _menuItems(
          context,
          Strings.requestMoneyPayment,
          Icons.request_page,
          25,
          () {
            Get.to(DeepLinkScreen(id: ""));
          },
        ),
        _menuItems(
          context,
          Strings.exchangeMoneyLog,
          Icons.insert_drive_file,
          25,
          () {
            Get.toNamed(Routes.exchangeMoneyLogScreen);
          },
        ),
        _menuItems(
          context,
          Strings.sendMoneyLog,
          FontAwesomeIcons.solidPaperPlane,
          25,
          () {
            Get.toNamed(Routes.sendMoneyLogScreen);
          },
        ),
        _menuItems(
          context,
          Strings.addMoneyLog,
          FontAwesomeIcons.solidMoneyBill1,
          25,
          () {
            Get.toNamed(Routes.depositLogScreen);
          },
        ),
        _menuItems(
          context,
          Strings.withdrawLog,
          FontAwesomeIcons.arrowUpFromBracket,
          25,
          () {
            Get.toNamed(Routes.withdrawLogScreen);
          },
        ),
        _menuItems(
          context,
          Strings.kyc,
          FontAwesomeIcons.idCard,
          25,
          () {
            Get.toNamed(Routes.kycScreen);
          },
        ),

        _menuItems(
          context,
          Strings.aboutUs,
          FontAwesomeIcons.circleInfo,
          25,
          () {
            Get.to(WebViewScreen(
              link: Get.find<SettingController>()
                  .basicSettingModel
                  .data
                  .webLinks
                  .aboutUs,
              appTitle: Strings.aboutUs,
            ));
          },
        ),
        _menuItems(
          context,
          Strings.privacyPolicy,
          FontAwesomeIcons.headphones,
          25,
          () {
            Get.to(WebViewScreen(
              link: Get.find<SettingController>()
                  .basicSettingModel
                  .data
                  .webLinks
                  .privacyPolicy,
              appTitle: Strings.privacyPolicy,
            ));
          },
        ),
        // _menuItems(
        //   context,
        //   Strings.shareApp,
        //   Icons.share,
        //   25,
        //   () {},
        // ),
        // _menuItems(
        //   context,
        //   Strings.rateUs,
        //   Icons.star_half,
        //   25,
        //   () {},
        // ),
        _menuItems(
          context,
          Strings.signOut,
          Icons.power_settings_new,
          25,
          () {
            Get.close(1);
            DialogHelper.show(
                context: context,
                title: Strings.signOut,
                subTitle: Strings.signOutDesc,
                actionText: Strings.okay,
                action: () {
                  Get.find<ChangePasswordController>().logOutProcess();
                });
          },
        ),
        addVerticalSpace(50.h),
      ],
    );
  }

  _menuItems(BuildContext context, String screenName, IconData icon,
      double iconSize, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      splashColor: CustomColor.primaryColor,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.defaultPaddingSize * 0.4),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: iconSize,
                color: CustomColor.textColor,
              ),
            ),
            Expanded(
              flex: 3,
              child: PrimaryTextWidget(
                text: screenName,
                style: const TextStyle(
                    color: CustomColor.textColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
