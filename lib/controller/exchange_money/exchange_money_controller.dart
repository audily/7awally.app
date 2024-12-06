import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/exchange_money/exchange_money_index_model.dart';
import '../../backend/services_and_models/exchange_money/exchange_money_service.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';
import '../../views/screens/success_screen.dart';

class ExchangeMoneyController extends GetxController with ExchangeMoneyService {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  late Rx<UserWallet> fromWallet;
  late Rx<UserWallet> toWallet;

  RxDouble exchangeRate = 0.0.obs;
  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  RxDouble fix = 0.0.obs;
  double perc = 0.0;
  RxDouble totalCharge = 0.0.obs;

  calculation(String amount) {
    var data = _exchangeMoneyIndexModel.data.charges;

    exchangeRate.value = toWallet.value.rate / fromWallet.value.rate;
    min.value = data.minLimit * fromWallet.value.rate;
    max.value = data.maxLimit * fromWallet.value.rate;
    fix.value = data.fixedCharge * fromWallet.value.rate;
    perc = data.percentCharge;

    if (amount.isNotEmpty) {
      double senderAmount = double.parse(amount);
      totalCharge.value = fix.value +
          (senderAmount * data.percentCharge / 100);
      toController.text = (senderAmount * exchangeRate.value).toStringAsFixed(2);
    } else {
      totalCharge.value = fix.value;
      toController.clear();
    }
  }

  ///------------------------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ExchangeMoneySubmitModel _exchangeMoneyIndexModel;
  ExchangeMoneySubmitModel get exchangeMoneyIndexModel =>
      _exchangeMoneyIndexModel;

  ///* Get RequestMoneyIndex in process
  Future<ExchangeMoneySubmitModel> exchangeMoneyIndexProcess() async {
    _isLoading.value = true;
    update();
    await exchangeMoneyIndexProcessApi().then((value) {
      _exchangeMoneyIndexModel = value!;

      fromWallet = _exchangeMoneyIndexModel.data.userWallet.first.obs;
      toWallet = _exchangeMoneyIndexModel.data.userWallet.first.obs;

      calculation("");

      Future.delayed(Duration(milliseconds: 200), () {
        Get.toNamed(Routes.exchangeMoneyScreen);
      });

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _exchangeMoneyIndexModel;
  }

  ///------------------------------------------------------------------------------
  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late CommonSuccessModel _exchangeMoneySubmitModel;
  CommonSuccessModel get exchangeMoneySubmitModel => _exchangeMoneySubmitModel;

  ///* RequestMoneySubmit in process
  Future<CommonSuccessModel> exchangeMoneySubmitProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'exchange_from_amount': fromController.text,
      'exchange_from_currency': fromWallet.value.currencyCode,
      'exchange_to_amount': '', // blank
      'exchange_to_currency': toWallet.value.currencyCode,
    };
    await exchangeMoneySubmitProcessApi(body: inputBody).then((value) {
      _exchangeMoneySubmitModel = value!;

      Get.to(SuccessScreen(
        title: Strings.exchangeMoney,
        msg: _exchangeMoneySubmitModel.message.success.first,
        onTap: (){
          Get.offAllNamed(Routes.bottomNavigationScreen);
        },
      ));
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _exchangeMoneySubmitModel;
  }
}
