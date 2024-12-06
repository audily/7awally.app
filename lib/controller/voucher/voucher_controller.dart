

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/voucher/voucher_index_model.dart';
import '../../backend/services_and_models/voucher/voucher_service.dart';
import '../../backend/services_and_models/voucher/voucher_submit_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';

class VoucherController extends GetxController with VoucherService{

  final amountController = TextEditingController();
  final codeController = TextEditingController();


  late Rx<UserWallet> selectedWallet;

  // RxDouble exchangeRate = 0.0.obs;

  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  RxDouble fix = 0.0.obs;
  double perc = 0.0;
  RxDouble totalCharge = 0.0.obs;

  calculation(String amount){

    min.value = _voucherIndexModel.data.charges.minLimit * selectedWallet.value.rate;
    max.value = _voucherIndexModel.data.charges.maxLimit * selectedWallet.value.rate;
    fix.value = _voucherIndexModel.data.charges.fixedCharge * selectedWallet.value.rate;
    perc = _voucherIndexModel.data.charges.percentCharge;

    if(amount.isNotEmpty){
      double value = double.parse(amount);
      totalCharge.value = fix.value + (value * _voucherIndexModel.data.charges.percentCharge /100);
    }else{
      totalCharge.value = fix.value;
    }
  }


  RxBool createPage = false.obs;

///--------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late VoucherIndexModel _voucherIndexModel;
  VoucherIndexModel get voucherIndexModel => _voucherIndexModel;

  ///* Get VoucherIndex in process
  Future<VoucherIndexModel> voucherIndexProcess() async {
    _isLoading.value = true;
    update();
    await voucherIndexProcessApi().then((value) {
      _voucherIndexModel = value!;


      selectedWallet = _voucherIndexModel.data.userWallet.first.obs;
      calculation("");

      Future.delayed(Duration(milliseconds: 200), () {
        if(createPage.value){
          Get.toNamed(Routes.createVoucherScreen);
        }else{
          Get.toNamed(Routes.redeemVoucherScreen);
        }
      });

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _voucherIndexModel;
  }

///--------------------------------------------------------
  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late VoucherSubmitModel _voucherSubmitModel;
  VoucherSubmitModel get voucherSubmitModel => _voucherSubmitModel;

  ///* VoucherSubmit in process
  Future<VoucherSubmitModel> voucherSubmitProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'amount': amountController.text,
      'request_currency': selectedWallet.value.currencyCode,
    };
    await voucherSubmitProcessApi(body: inputBody).then((value) {
      _voucherSubmitModel = value!;
      Get.toNamed(Routes.createVoucherPreviewScreen);
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _voucherSubmitModel;
  }



  ///--------------------------------------------------------

  final _isRedeemLoading = false.obs;
  bool get isRedeemLoading => _isRedeemLoading.value;

  late CommonSuccessModel _voucherRedeemModel;
  CommonSuccessModel get voucherRedeemModel => _voucherRedeemModel;

  ///* VoucherRedeem in process
  Future<CommonSuccessModel> voucherRedeemProcess() async {
    _isRedeemLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'code': codeController.text,
    };
    await voucherRedeemProcessApi(body: inputBody).then((value) {
      _voucherRedeemModel = value!;

      codeController.clear();
      _isRedeemLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isRedeemLoading.value = false;
    update();
    return _voucherRedeemModel;
  }
}