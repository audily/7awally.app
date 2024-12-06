import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/services_and_models/auth_service/auth_service.dart';
import '../../backend/services_and_models/auth_service/models/forgot_send_otp_model.dart';
import '../../backend/services_and_models/auth_service/models/login_model.dart';
import '../../backend/utils/api_method.dart';
import '../../local_storage/local_storage.dart';
import '../../routes/routes.dart';
import 'phone_verification_otp_controller.dart';
import 'sign_up_controller.dart';

class SignInController extends GetxController with AuthService{
  final emailOrUserNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();


  @override
  void dispose() {
    emailOrUserNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }


/// -------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late LoginModel _loginModel;
  LoginModel get loginModel => _loginModel;

  ///* Login in process
  Future<LoginModel> loginProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'credentials': emailOrUserNameController.text,
      'password': passwordController.text,
    };
    await loginProcessApi(body: inputBody).then((value) {
      _loginModel = value!;

      LocalStorage.saveToken(token: _loginModel.data.token);

      var userInfo = _loginModel.data.userInfo;

      if(userInfo.emailVerified == 1){
        debugPrint("--EMAIL VERIFIED");

        if(userInfo.kycVerified != 0 || userInfo.kycVerified != 3){
          debugPrint("--KYC VERIFIED");

          if(userInfo.twoFactorStatus == 1){
            debugPrint("--2 FA Enable");
            Get.toNamed(Routes.faOtpScreen);
          }

          else{
            debugPrint("--2 FA Disable");
            LocalStorage.isLoginSuccess(isLoggedIn: true);
            Get.offAllNamed(Routes.bottomNavigationScreen);
          }
        }

        else{
          debugPrint("--KYC UN-VERIFIED");
          Get.toNamed(Routes.kycScreen);
        }
      }
      else{
        debugPrint("--EMAIL UN-VERIFIED");
        Get.find<SignUpController>().emailController.text = emailController.text;
        Get.put(PhoneVerificationOtpController()).token = _loginModel.data.authorization.token;
        Get.toNamed(Routes.emailVerificationScreen);
      }


      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _loginModel;
  }


  /// -------------------------------
  final _isOTPSendLoading = false.obs;
  bool get isOTPSendLoading => _isOTPSendLoading.value;

  late ForgotSendOtpModel _forgotSendOtpModel;
  ForgotSendOtpModel get forgotSendOtpModel => _forgotSendOtpModel;

  ///* ForgotSendOtp in process
  Future<ForgotSendOtpModel> forgotSendOtpProcess() async {
    _isOTPSendLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'credentials': emailController.text,
    };
    await forgotSendOtpProcessApi(body: inputBody).then((value) {
      _forgotSendOtpModel = value!;

      Get.toNamed(Routes.otpVerificationScreen);

      _isOTPSendLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isOTPSendLoading.value = false;
    update();
    return _forgotSendOtpModel;
  }

}
