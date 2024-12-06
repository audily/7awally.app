import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/local_storage/local_storage.dart';

import '../../backend/services_and_models/auth_service/auth_service.dart';
import '../../backend/services_and_models/auth_service/models/register_model.dart';
import '../../backend/services_and_models/settings/models/basic_settings_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';
import '../../views/screens/auth/auth_congratulations_screen.dart';
import '../settings_controller.dart';
import 'phone_verification_otp_controller.dart';

class SignUpController extends GetxController with AuthService {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final companyNameController = TextEditingController();
  final passwordController = TextEditingController();

  late Rx<Country> selectedCountry;
  RxInt selectIndex = 0.obs;
  RxDouble containerHeight = 0.0.obs;

  @override
  void onInit() {
    selectedCountry = Get.find<SettingController>()
        .basicSettingModel
        .data
        .countries
        .first
        .obs;
    super.onInit();
  }

  /// ----------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late RegisterModel _registerModel;
  RegisterModel get registerModel => _registerModel;

  ///* Register in process
  Future<RegisterModel> registerProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'company_name': selectIndex.value == 0 ? "" : companyNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'country': selectedCountry.value.name,
      'type': selectIndex.value == 0 ? "personal" : "business",
    };
    await registerProcessApi(body: inputBody).then((value) {
      _registerModel = value!;

      LocalStorage.saveToken(token: _registerModel.data.token);
      if (_registerModel.data.authorization.status) {
        Get.put(PhoneVerificationOtpController()).token =
            _registerModel.data.authorization.token;
        Get.toNamed(Routes.emailVerificationScreen);
      } else {
        Get.to(AuthCongratulationsScreen(
          text: Strings.signUpCongDes,
          onTap: () {
            LocalStorage.isLoginSuccess(isLoggedIn: true);
            Get.offAllNamed(Routes.bottomNavigationScreen);
          },
        ));
      }

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _registerModel;
  }
}
