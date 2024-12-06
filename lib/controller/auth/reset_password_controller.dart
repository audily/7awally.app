import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/model/common/common_success_model.dart';
import '../../backend/services_and_models/auth_service/auth_service.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../views/screens/auth/auth_congratulations_screen.dart';
import 'sign_in_controller.dart';

class ResetPasswordController extends GetxController with AuthService{
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();




  /// -------------------------------
  final _isResetPasswordLoading = false.obs;
  bool get isResetPasswordLoading => _isResetPasswordLoading.value;

  late CommonSuccessModel _resetPasswordModel;
  CommonSuccessModel get resetPasswordModel => _resetPasswordModel;

  ///* ForgotVerifyOtp in process
  Future<CommonSuccessModel> resetPasswordProcess() async {
    _isResetPasswordLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'token': Get.find<SignInController>().forgotSendOtpModel.data.token,
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    };
    await resetPasswordProcessApi(body: inputBody).then((value) {
      _resetPasswordModel = value!;

      Get.to(AuthCongratulationsScreen(
        text: _resetPasswordModel.message.success.first,
        onTap: () {
          Get.offAllNamed(Routes.welcomeScreen);
        },
      ));

      _isResetPasswordLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isResetPasswordLoading.value = false;
    update();
    return _resetPasswordModel;
  }
}
