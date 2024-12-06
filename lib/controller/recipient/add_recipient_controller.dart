


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/profile_settings/models/profile_info_model.dart';
import '../../backend/services_and_models/recipient/recipient_service.dart';
import '../../backend/services_and_models/recipient/search_recipient_model.dart';
import '../../backend/utils/api_method.dart';
import '../profile/edit_profile_controller.dart';
import '../send_money/select_recipient_controller.dart';
import 'recipient_controller.dart';

class AddRecipientController extends GetxController with RecipientService{

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
  final _isSearchLoading = false.obs;
  bool get isSearchLoading => _isSearchLoading.value;

  late SearchRecipientModel _searchRecipientModel;
  SearchRecipientModel get searchRecipientModel => _searchRecipientModel;

  ///* Get SearchRecipient in process
  Future<SearchRecipientModel> searchRecipientProcess(String user) async {
    _isSearchLoading.value = true;
    update();
    await searchRecipientProcessApi(user).then((value) {
      _searchRecipientModel = value!;

      var data = _searchRecipientModel.data.userData;
      firstNameController.text = data.firstname;
      lastNameController.text = data.lastname;
      emailController.text = data.email;

      cityController.text = data.address.city;
      stateController.text = data.address.state;
      addressController.text = data.address.address;
      zipCodeController.text = data.address.zip;
      countryController.text = data.address.country;

      Get.find<EditProfileController>().profileInfoModel.data.countries.forEach((element) {
        if(data.address.country == element.name){
          selectedCountry.value = element;
        }
      });

      _isSearchLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSearchLoading.value = false;
    update();
    return _searchRecipientModel;
  }

  /// -----------------------------------------------
  final _isStoreLoading = false.obs;
  bool get isStoreLoading => _isStoreLoading.value;

  late CommonSuccessModel _storeRecipientModel;
  CommonSuccessModel get storeRecipientModel => _storeRecipientModel;

  ///* StoreRecipient in process
  Future<CommonSuccessModel> storeRecipientProcess() async {
    _isStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'email': emailController.text,
      'city': cityController.text,
      'state': stateController.text,
      'zip': zipCodeController.text,
      'country': countryController.text,
      'address': addressController.text,
    };

    await storeRecipientProcessApi(body: inputBody).then((value) {
      _storeRecipientModel = value!;

      Get.back();
      Get.find<SelectRecipientController>().myRecipientProcess(route: false);
      Get.find<RecipientController>().myRecipientProcess(route: false);

      _isStoreLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStoreLoading.value = false;
    update();
    return _storeRecipientModel;
  }
}

