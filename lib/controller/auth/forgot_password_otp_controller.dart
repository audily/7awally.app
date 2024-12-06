import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/model/common/common_success_model.dart';
import '../../backend/services_and_models/auth_service/auth_service.dart';
import '../../backend/services_and_models/auth_service/models/forgot_send_otp_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import 'sign_in_controller.dart';

class ForgetPasswordOtpController extends GetxController with AuthService {
  final otpController = TextEditingController();

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

  ///------------------------------   for forget pass ------------------------------------
  /// ----------------------------------------------------------------
  final _isResendPasswordLoading = false.obs;
  bool get isResendPasswordLoading => _isResendPasswordLoading.value;

  late ForgotSendOtpModel _forgotSendOtpModel;
  ForgotSendOtpModel get forgotSendOtpModel => _forgotSendOtpModel;

  Future<ForgotSendOtpModel> forgotReSendOtpProcess() async {
    resendVisible.value = false;
    _isResendPasswordLoading.value = true;
    update();
    await forgotReSendOtpProcessApi(
        Get.find<SignInController>().forgotSendOtpModel.data.token)
        .then((value) {
      _forgotSendOtpModel = value!;
      timer.value = 60;
      _isResendPasswordLoading.value = false;
      update();
    }).catchError((onError) {
      resendVisible.value = true;
      log.e(onError);
    });
    _isResendPasswordLoading.value = false;
    update();
    return _forgotSendOtpModel;
  }

  /// -------------------------------
  final _isOTPSVerifyLoading = false.obs;
  bool get isOTPSVerifyLoading => _isOTPSVerifyLoading.value;

  late CommonSuccessModel _forgotVerifyOtpModel;
  CommonSuccessModel get forgotVerifyOtpModel => _forgotVerifyOtpModel;

  ///* ForgotVerifyOtp in process
  Future<CommonSuccessModel> forgotVerifyOtpProcess() async {
    _isOTPSVerifyLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'token': Get.find<SignInController>().forgotSendOtpModel.data.token,
      'code': otpController.text,
    };
    await forgotVerifyOtpProcessApi(body: inputBody).then((value) {
      _forgotVerifyOtpModel = value!;

      Get.toNamed(Routes.resetPasswordScreen);

      _isOTPSVerifyLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isOTPSVerifyLoading.value = false;
    update();
    return _forgotVerifyOtpModel;
  }
}