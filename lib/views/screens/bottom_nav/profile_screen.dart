import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/routes/routes.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/views/screens/drawer/drawer_screen.dart';

import '../../../controller/profile/change_password_controller.dart';
import '../../../controller/profile/edit_profile_controller.dart';
import '../../../widgets/dialog_helper.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../backend/services_and_models/profile_settings/models/profile_info_model.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  // final Data data = Get.find<EditProfileController>().profileInfoModel.data;
  final controller = Get.find<EditProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBackgroundColor,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        iconTheme: const IconThemeData(color: CustomColor.whiteColor),
        title: const PrimaryTextWidget(
            text: Strings.profile, color: CustomColor.whiteColor),
        elevation: 0,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Obx(() => ListView(
      children: [
        addVerticalSpace(50.h),
        controller.isLoading ? SizedBox.shrink() : _profilePicture(context),
        addVerticalSpace(0.h),
        controller.isLoading ? SizedBox.shrink() : _usernameAndUserId(context),
        addVerticalSpace(50.h),
        _containerWidget(context),
      ],
    ));
  }

  _profilePicture(BuildContext context) {
    Data data = controller.profileInfoModel.data;
    debugPrint("Profile - BTM Nav -");
    debugPrint("${data.imagePaths.baseUrl}/${data.imagePaths.pathLocation}/${data.userInfo.image}");
    return Obx(() => Container(
      width: 120.h,
      height: 120.h,
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 0.3),
      decoration: BoxDecoration(
        color: CustomColor.textColor,
        image: DecorationImage(
            image: NetworkImage(controller.networkImage.value),
            fit: BoxFit.fitHeight),
        shape: BoxShape.circle,
      ),
    ));
  }

  _usernameAndUserId(BuildContext context) {
    Data data = controller.profileInfoModel.data;
    return Column(
      mainAxisAlignment: mainCenter,
      crossAxisAlignment: crossCenter,
      children: [
        PrimaryTextWidget(
          text: data.userInfo.firstname + " " + data.userInfo.lastname,
          style: CustomStyler.profileNameStyle,
        ),
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            PrimaryTextWidget(
              text: Strings.userId,
              style: CustomStyler.userIdStyle,
            ),
            PrimaryTextWidget(
                text: data.userInfo.username, style: CustomStyler.userIdStyle),
          ],
        )
      ],
    );
  }

  _containerWidget(BuildContext context) {
    return Column(
      children: [
        _smallContainer(
            context, Icons.account_circle_rounded, Strings.editProfile, () {
          Get.toNamed(Routes.editProfileScreen);
        }, null),
        addVerticalSpace(5.h),
        _smallContainer(context, Icons.security, Strings.twoFA, () {
          Get.toNamed(Routes.faScreen);
        }, null),

        addVerticalSpace(5.h),
        _smallContainer(context, Icons.key, Strings.changePassword, () {
          Get.toNamed(Routes.changePasswordScreen);
        }, null),

        addVerticalSpace(5.h),
        _smallContainer(context, Icons.language_outlined, Strings.changeLanguage, () {
          Get.toNamed(Routes.languageChangeScreen);
        }, null),

        addVerticalSpace(5.h),
        _smallContainer(context, Icons.delete_outline, Strings.deleteAccount, () {
          DialogHelper.show(
              context: context,
              title: Strings.deleteAccount,
              subTitle: Strings.deleteAccountDesc,
              actionText: Strings.okay,
              action: () {
                Get.find<ChangePasswordController>().deleteAccountProcess();
              });
        }, CustomColor.redColor),
      ],
    );
  }

  _smallContainer(BuildContext context, IconData icon, String name,
      VoidCallback onPressed, Color? color) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.5),
        padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.3),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color ?? CustomColor.textColor,
                  size: 30,
                ),
                addHorizontalSpace(10.w),
                PrimaryTextWidget(
                  text: name,
                  style: CustomStyler.editProfileStyle.copyWith(
                    color: color
                  )
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: color ?? CustomColor.textColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
