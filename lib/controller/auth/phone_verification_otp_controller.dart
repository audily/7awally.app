import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/model/common/common_success_model.dart';
import '../../backend/services_and_models/auth_service/auth_service.dart';
import '../../backend/utils/api_method.dart';
import '../../local_storage/local_storage.dart';
import '../../routes/routes.dart';
import '../../views/screens/auth/auth_congratulations_screen.dart';

class PhoneVerificationOtpController extends GetxController with AuthService {
  final otpController = TextEditingController();

  String token = "";

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    Timer.periodic(Duration(seconds: 1), (time) {
      if (timer.value > 0) {
        resendVisible.value = false;
        timer.value--;
      } else {
        resendVisible.value = true;
        timer.value = 0;
      }
    });
    super.onInit();
  }

  /// timer
  RxInt timer = 60.obs;
  RxBool resendVisible = false.obs;

  RxString formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr =
        (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';
    return '$minutesStr:$secondsStr'.obs;
  }

  ///------------------------------   for email verification ------------------------------------
  /// ----------------------------------------------------------------
  final _isVerifyLoading = false.obs;
  bool get isVerifyLoading => _isVerifyLoading.value;

  late CommonSuccessModel _registrationModel;
  CommonSuccessModel get registrationModel => _registrationModel;

  ///* Registration in process
  Future<CommonSuccessModel> registrationProcess() async {
    _isVerifyLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'token': token,
      'code': otpController.text
    };
    await registrationProcessApi(body: inputBody).then((value) {
      _registrationModel = value!;

      Get.to(AuthCongratulationsScreen(
        text: _registrationModel.message.success.first,
        onTap: () {
          LocalStorage.isLoginSuccess(isLoggedIn: true);
          Get.offAllNamed(Routes.bottomNavigationScreen);
        },
      ));

      _isVerifyLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isVerifyLoading.value = false;
    update();
    return _registrationModel;
  }

  /// ----------------------------------------------------------------

  final _isResendLoading = false.obs;
  bool get isResendLoading => _isResendLoading.value;

  late CommonSuccessModel _registerResendModel;
  CommonSuccessModel get registerResendModel => _registerResendModel;

  ///* Get RegisterResend in process
  Future<CommonSuccessModel> registerResendProcess() async {
    resendVisible.value = false;
    _isResendLoading.value = true;
    update();
    await registerResendProcessApi(token)
        .then((value) {
      _registerResendModel = value!;
      timer.value = 60;
      _isResendLoading.value = false;
      update();
    }).catchError((onError) {
      resendVisible.value = true;
      log.e(onError);
    });
    _isResendLoading.value = false;
    update();
    return _registerResendModel;
  }
}
