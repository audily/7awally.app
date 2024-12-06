import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';

import '../../controller/settings_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
        backgroundColor: CustomColor.primaryBackgroundColor,
        body: Obx(() => Get.find<SettingController>().isSettingsLoading
            ? CustomLoadingAPI()
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.marginSize),
                      child: Image.network(
                          "${Get.find<SettingController>().basicSettingModel.data.appImagePaths.baseUrl}/${Get.find<SettingController>().basicSettingModel.data.appImagePaths.pathLocation}/${Get.find<SettingController>().basicSettingModel.data.splashScreen.image}")),
                  Visibility(
                    visible: DynamicLanguage.isLoading,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.sizeOf(context).height * 0.2,
                        left: MediaQuery.sizeOf(context).width * 0.15,
                        right: MediaQuery.sizeOf(context).width * 0.15,
                      ),
                      child: LinearProgressIndicator(
                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              )));
  }
}
