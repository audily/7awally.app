import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/extensions/custom_extensions.dart';
import '../backend/services_and_models/settings/models/basic_settings_model.dart';
import '../backend/services_and_models/settings/settings_service.dart';
import '../backend/utils/api_method.dart';
import '../utils/custom_color.dart';

class SettingController extends GetxController with SettingsService{

  @override
  void onInit() {
    debugPrint(">> Step >> 1");
    basicSettingProcess();
    super.onInit();
  }

  final _isSettingsLoading = false.obs;
  bool get isSettingsLoading => _isSettingsLoading.value;

  late BasicSettingModel _basicSettingModel;
  BasicSettingModel get basicSettingModel => _basicSettingModel;

  ///* Get BasicSetting in process
  Future<BasicSettingModel> basicSettingProcess() async {
    _isSettingsLoading.value = true;

    update();
    await basicSettingProcessApi().then((value) {
      _basicSettingModel = value!;

      print(_basicSettingModel.data.basicSettings.baseColor);
      print(_basicSettingModel.data.basicSettings.secondaryColor);
      CustomColor.primaryColor = HexColor(_basicSettingModel.data.basicSettings.baseColor);

      _isSettingsLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSettingsLoading.value = false;
    update();
    return _basicSettingModel;
  }

}
