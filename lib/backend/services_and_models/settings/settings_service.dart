
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'models/basic_settings_model.dart';

mixin SettingsService{
  ///* Get BasicSetting api services
  Future<BasicSettingModel?> basicSettingProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      debugPrint(">> Step >> 2.1");
      debugPrint(">> In Service >>");

      mapResponse = await ApiMethod(isBasic: true).get(
          ApiEndpoint.basicSettingsUrl + "?lang=${DynamicLanguage.selectedLanguage.value}",
        showResult: true
      );
      debugPrint(">> Step >> 2.2");
      debugPrint(">> After Hit On Api Method >>");

      if (mapResponse != null) {
        debugPrint(">> Step >> 2.3");
        debugPrint(">> Not Null Response >>");
        BasicSettingModel result = BasicSettingModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BasicSetting api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}