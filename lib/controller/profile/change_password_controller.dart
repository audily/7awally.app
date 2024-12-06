import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';
import 'package:walletium/local_storage/local_storage.dart';

import '../../backend/services_and_models/profile_settings/profile_settings_services.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';

class ChangePasswordController extends GetxController with ProfileSettingsService{
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  ///------------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _passwordChangeModel;
  CommonSuccessModel get passwordChangeModel => _passwordChangeModel;

  ///* PasswordChange in process
  Future<CommonSuccessModel> passwordChangeProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'current_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    };
    await passwordChangeProcessApi(body: inputBody).then((value) {
      _passwordChangeModel = value!;
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _passwordChangeModel;
  }



///------------------------------------------------------------------
  final _isLogOutLoading = false.obs;
  bool get isLogOutLoading => _isLogOutLoading.value;

  late CommonSuccessModel _logOutModel;
  CommonSuccessModel get logOutModel => _logOutModel;

  ///* LogOut in process
  Future<CommonSuccessModel> logOutProcess() async {
    _isLogOutLoading.value = true;
    update();

    await logOutProcessApi(body: {}).then((value) {
      _logOutModel = value!;

      LocalStorage.logout();
      Get.offAllNamed(Routes.welcomeScreen);

      _isLogOutLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLogOutLoading.value = false;
    update();
    return _logOutModel;
  }


  ///------------------------------------------------------------------
  final _isDeleteLoading = false.obs;
  bool get isDeleteLoading => _isDeleteLoading.value;

  late CommonSuccessModel _deleteAccountModel;
  CommonSuccessModel get deleteAccountModel => _deleteAccountModel;

  ///* DeleteAccount in process
  Future<CommonSuccessModel> deleteAccountProcess() async {
    _isDeleteLoading.value = true;
    update();
    await deleteAccountProcessApi(body: {}).then((value) {
      _deleteAccountModel = value!;

      LocalStorage.logout();
      Get.offAllNamed(Routes.welcomeScreen);

      _isDeleteLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isDeleteLoading.value = false;
    update();
    return _deleteAccountModel;
  }
}
