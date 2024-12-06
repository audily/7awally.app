import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';
import 'package:walletium/backend/services_and_models/recipient/my_recipient_model.dart';
import 'package:walletium/controller/recipient/recipient_controller.dart';

import '../../backend/services_and_models/profile_settings/models/profile_info_model.dart';
import '../../backend/services_and_models/recipient/recipient_service.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../profile/edit_profile_controller.dart';
import '../send_money/select_recipient_controller.dart';

class UpdateRecipientController extends GetxController with RecipientService{

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();
  final emailController = TextEditingController();


  @override
  void onInit() {
    selectedCountry = Get.find<EditProfileController>().profileInfoModel.data.countries.first.obs;

    super.onInit();
  }

  late Rx<Country> selectedCountry;

  /// -----------------------------------------------
  /// -----------------------------------------------
  final _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _updateRecipientModel;
  CommonSuccessModel get updateRecipientModel => _updateRecipientModel;

  ///* UpdateRecipient in process
  Future<CommonSuccessModel> updateRecipientProcess() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'id': userId,
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'email': emailController.text,
      'city': cityController.text,
      'state': stateController.text,
      'zip': zipCodeController.text,
      'country': countryController.text,
      'address': addressController.text,
    };
    await updateRecipientProcessApi(body: inputBody).then((value) {
      _updateRecipientModel = value!;

      Get.back();
      Get.find<SelectRecipientController>().myRecipientProcess(route: false);
      Get.find<RecipientController>().myRecipientProcess(route: false);

      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _updateRecipientModel;
  }


  String userId = "";
  void setValues(Receipient data) {
    userId = data.id.toString();

    firstNameController.text = data.firstname;
    lastNameController.text = data.lastname;
    emailController.text = data.email;

    cityController.text = data.city;
    stateController.text = data.state;
    addressController.text = data.address;
    zipCodeController.text = data.zipCode;
    countryController.text = data.country;

    Get.find<EditProfileController>().profileInfoModel.data.countries.forEach((element) {
      if(data.country == element.name){
        selectedCountry.value = element;
      }
    });

    Get.toNamed(Routes.updateRecipientScreen);
  }
}

