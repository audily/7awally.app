import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/profile_settings/models/fa_info_model.dart';
import '../../backend/services_and_models/profile_settings/profile_settings_services.dart';
import '../../backend/utils/api_method.dart';
import '../../local_storage/local_storage.dart';
import '../../routes/routes.dart';

class FAController extends GetxController with ProfileSettingsService {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    faInfoProcess();
    super.onInit();
  }

/// ------------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late FaInfoModel _faInfoModel;
  FaInfoModel get faInfoModel => _faInfoModel;

  ///* Get FaInfo in process
  Future<FaInfoModel> faInfoProcess() async {
    _isLoading.value = true;
    update();
    await faInfoProcessApi().then((value) {
      _faInfoModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _faInfoModel;
  }


  /// ------------------------------------------------------------------
  final _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _fAStatusUpdateModel;
  CommonSuccessModel get fAStatusUpdateModel => _fAStatusUpdateModel;

  ///* fAStatusUpdate in process
  Future<CommonSuccessModel> fAStatusUpdateProcess() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'status': _faInfoModel.data.status == 1 ? 0 : 1,
    };
    await fAStatusUpdateProcessApi(body: inputBody).then((value) {
      _fAStatusUpdateModel = value!;
      faInfoProcess();
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _fAStatusUpdateModel;
  }


/// ------------------------------------------------------------------


  final _isOTPLoading = false.obs;
  bool get isOTPLoading => _isOTPLoading.value;

  late CommonSuccessModel _faVerifyModel;
  CommonSuccessModel get faVerifyModel => _faVerifyModel;

  ///* faVerify in process
  Future<CommonSuccessModel> faVerifyProcess() async {
    _isOTPLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'code': otpController.text,
    };
    await faVerifyProcessApi(body: inputBody).then((value) {
      _faVerifyModel = value!;

      LocalStorage.isLoginSuccess(isLoggedIn: true);
      Get.offAllNamed(Routes.bottomNavigationScreen);

      _isOTPLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isOTPLoading.value = false;
    update();
    return _faVerifyModel;
  }
}
