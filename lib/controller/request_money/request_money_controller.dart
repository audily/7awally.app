import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/request_money/request_money_index_model.dart';
import '../../backend/services_and_models/request_money/request_money_info_model.dart';
import '../../backend/services_and_models/request_money/request_money_service.dart';
import '../../backend/services_and_models/request_money/request_money_submit_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';
import '../../views/screens/success_screen.dart';

class RequestMoneyController extends GetxController with RequestMoney{
  final amountController = TextEditingController();
  final remarksController = TextEditingController();


  late Rx<UserWallet> selectedWallet;

  // RxDouble exchangeRate = 0.0.obs;

  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  RxDouble fix = 0.0.obs;
  double perc = 0.0;
  RxDouble totalCharge = 0.0.obs;

  calculation(String amount){

    min.value = _requestMoneyIndexModel.data.charges.minLimit * selectedWallet.value.rate;
    max.value = _requestMoneyIndexModel.data.charges.maxLimit * selectedWallet.value.rate;
    fix.value = _requestMoneyIndexModel.data.charges.fixedCharge * selectedWallet.value.rate;
    perc = _requestMoneyIndexModel.data.charges.percentCharge;

    if(amount.isNotEmpty){
      double value = double.parse(amount);
      totalCharge.value = fix.value + (value * _requestMoneyIndexModel.data.charges.percentCharge /100);
    }else{
      totalCharge.value = fix.value;
    }
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late RequestMoneyIndexModel _requestMoneyIndexModel;
  RequestMoneyIndexModel get requestMoneyIndexModel => _requestMoneyIndexModel;

  ///* Get RequestMoneyIndex in process
  Future<RequestMoneyIndexModel> requestMoneyIndexProcess() async {
    _isLoading.value = true;
    update();
    await requestMoneyIndexProcessApi().then((value) {
      _requestMoneyIndexModel = value!;

      selectedWallet = _requestMoneyIndexModel.data.userWallet.first.obs;
      calculation("");

      Future.delayed(Duration(milliseconds: 200), () {
        Get.toNamed(Routes.requestMoneyScreen);
      });


      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _requestMoneyIndexModel;
  }


  ///-----------------------------------------------------------------

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late RequestMoneySubmitModel _requestMoneySubmitModel;
  RequestMoneySubmitModel get requestMoneySubmitModel => _requestMoneySubmitModel;

  ///* RequestMoneySubmit in process
  Future<RequestMoneySubmitModel> requestMoneySubmitProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'amount': amountController.text,
      'request_currency': selectedWallet.value.currencyCode,
      'remark': remarksController.text
    };
    await requestMoneySubmitProcessApi(body: inputBody).then((value) {
      _requestMoneySubmitModel = value!;

      Get.toNamed(Routes.requestMoneyReviewScreen);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _requestMoneySubmitModel;
  }



  /// ------------------------------------- >>

  final codeController = TextEditingController();

  final _isInfoLoading = false.obs;
  bool get isInfoLoading => _isInfoLoading.value;

  late RequestMoneyInfoModel _requestMoneyInfoModel;
  RequestMoneyInfoModel get requestMoneyInfoModel => _requestMoneyInfoModel;

  RxBool showDetails = false.obs;

  ///* Get RequestMoneyInfo in process
  Future<RequestMoneyInfoModel> requestMoneyInfoProcess(String token) async {
    _isInfoLoading.value = true;
    update();
    await requestMoneyInfoProcessApi(token).then((value) {
      _requestMoneyInfoModel = value!;

      showDetails.value = true;

      _isInfoLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isInfoLoading.value = false;
    update();
    return _requestMoneyInfoModel;
  }


  /// ------------------------------------- >>

  final _isConfirmLoading = false.obs;
  bool get isConfirmLoading => _isConfirmLoading.value;

  late CommonSuccessModel _requestMoneyConfirmModel;
  CommonSuccessModel get requestMoneyConfirmModel => _requestMoneyConfirmModel;

  ///* RequestMoneyConfirm in process
  Future<CommonSuccessModel> requestMoneyConfirmProcess() async {
    _isConfirmLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'token': _requestMoneyInfoModel.data.requestMoneyInfo.token,
    };
    await requestMoneyConfirmProcessApi(body: inputBody).then((value) {
      _requestMoneyConfirmModel = value!;

      Get.to(SuccessScreen(
          title: Strings.requestMoney,
          msg: _requestMoneyConfirmModel.message.success.first,
          onTap: () {
            Get.offAllNamed(Routes.bottomNavigationScreen);
          }));

      _isConfirmLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isConfirmLoading.value = false;
    update();
    return _requestMoneyConfirmModel;
  }

}