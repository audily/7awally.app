import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/profile_settings/models/profile_info_model.dart';
import '../../backend/services_and_models/profile_settings/profile_settings_services.dart';
import '../../backend/utils/api_method.dart';

class EditProfileController extends GetxController with ProfileSettingsService{
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNUmberController = TextEditingController();

  late Rx<Country> selectedCountry;
  RxString selectedImagePath = "".obs;

  RxString networkImage = "".obs;

  @override
  void onInit() {
    selectedImagePath.value = "";
    profileInfoProcess();
    super.onInit();
  }

  /// ------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ProfileInfoModel _profileInfoModel;
  ProfileInfoModel get profileInfoModel => _profileInfoModel;

  ///* Get ProfileInfo in process
  Future<ProfileInfoModel> profileInfoProcess() async {
    _isLoading.value = true;
    update();
    await profileInfoProcessApi().then((value) {
      _profileInfoModel = value!;


      selectedCountry = _profileInfoModel.data.countries.first.obs;
      var data = _profileInfoModel.data;

      networkImage.value = (data.userInfo.image.toString().isEmpty
          ? "${data.imagePaths.baseUrl}/${data.imagePaths.defaultImage}"
          : "${data.imagePaths.baseUrl}/${data.imagePaths.pathLocation}/${data.userInfo.image}") ;

      _profileInfoModel.data.countries.forEach((element) {
        if(data.userInfo.country == element.name){
          selectedCountry.value = element;
        }
      });

      firstNameController.text = data.userInfo.firstname;
      lastNameController.text = data.userInfo.lastname;
      cityController.text = data.userInfo.city;
      stateController.text = data.userInfo.state;
      addressController.text = data.userInfo.address;
      zipCodeController.text = data.userInfo.zipCode;
      emailController.text = data.userInfo.email;
      phoneNUmberController.text = data.userInfo.mobile;


      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _profileInfoModel;
  }


  /// ------------------------------------------------------------
  final _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _profileUpdateModel;
  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  ///* ProfileUpdate in process
  Future<CommonSuccessModel> profileUpdateProcess() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'mobile_code': selectedCountry.value.mobileCode,
      'mobile': phoneNUmberController.text,
      'country': selectedCountry.value.name,
      'city': cityController.text,
      'state': stateController.text,
      'zip_code': zipCodeController.text,
      'address': addressController.text
    };
    await profileUpdateProcessApi(body: inputBody).then((value) {
      _profileUpdateModel = value!;
      selectedImagePath.value = "";
      profileInfoProcess();
      Get.close(1);
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  ///* ProfileUpdate in process
  Future<CommonSuccessModel> profileUpdateProcessWithImage() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, String> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'mobile_code': selectedCountry.value.mobileCode,
      'mobile': phoneNUmberController.text,
      'country': selectedCountry.value.name,
      'city': cityController.text,
      'state': stateController.text,
      'zip_code': zipCodeController.text,
      'address': addressController.text
    };
    await profileUpdateProcessApiWithImage(body: inputBody, filePath: selectedImagePath.value, filedName: 'image').then((value) {
      _profileUpdateModel = value!;
      selectedImagePath.value = "";
      profileInfoProcess();
      Get.close(1);
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }
}
