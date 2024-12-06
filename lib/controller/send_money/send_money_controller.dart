import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';
import 'package:walletium/backend/services_and_models/send_money/send_money_service.dart';

import '../../backend/services_and_models/send_money/send_money_index_model.dart';
import '../../backend/services_and_models/send_money/send_money_submit_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';
import '../../views/screens/success_screen.dart';
import 'select_recipient_controller.dart';

class SendMoneyController extends GetxController with SendMoneyService{
  final senderController = TextEditingController();
  final receiverController = TextEditingController();
  final selectRecipientController = Get.put(SelectRecipientController());


  late Rx<ErWallet> senderWallet;
  late Rx<ErWallet> recipientWallet;

  RxDouble exchangeRate = 0.0.obs;
  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  RxDouble fix = 0.0.obs;
  double perc = 0.0;
  RxDouble totalCharge = 0.0.obs;

  calculation(String amount) {
    var data = _sendMoneyIndexModel.data.charges;

    exchangeRate.value = recipientWallet.value.rate / senderWallet.value.rate;
    min.value = data.minLimit * senderWallet.value.rate;
    max.value = data.maxLimit * senderWallet.value.rate;
    fix.value = data.fixedCharge * senderWallet.value.rate;
    perc = data.percentCharge;

    if (amount.isNotEmpty) {
      double senderAmount = double.parse(amount);
      totalCharge.value = fix.value +
          (senderAmount * data.percentCharge / 100);
      receiverController.text = (senderAmount * exchangeRate.value).toStringAsFixed(2);
    } else {
      totalCharge.value = fix.value;
      receiverController.clear();
    }
  }



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late SendMoneyIndexModel _sendMoneyIndexModel;
  SendMoneyIndexModel get sendMoneyIndexModel => _sendMoneyIndexModel;

  ///* Get SendMoneyIndex in process
  Future<SendMoneyIndexModel> sendMoneyIndexProcess() async {
    _isLoading.value = true;
    update();
    await sendMoneyIndexProcessApi().then((value) {
      _sendMoneyIndexModel = value!;


      senderWallet = _sendMoneyIndexModel.data.userWallet.first.obs;
      recipientWallet = _sendMoneyIndexModel.data.receiverWallets.first.obs;

      calculation("");

      Future.delayed(Duration(milliseconds: 200), () {
        Get.toNamed(Routes.sendMoneyScreen);
      });

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _sendMoneyIndexModel;
  }

  /// ---------------------------------------------------------------
  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late SendMoneySubmitModel _sendMoneySubmitModel;
  SendMoneySubmitModel get sendMoneySubmitModel => _sendMoneySubmitModel;

  ///* SendMoneySubmit in process
  Future<SendMoneySubmitModel> sendMoneySubmitProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'sender_amount': senderController.text,
      'sender_currency': senderWallet.value.currencyCode,
      'receiver_amount': "",
      'receiver_currency': recipientWallet.value.currencyCode
    };
    await sendMoneySubmitProcessApi(body: inputBody).then((value) {

      _sendMoneySubmitModel = value!;
      selectRecipientController.myRecipientProcess();
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _sendMoneySubmitModel;
  }


/// ---------------------------------------------------------------
  final _isConfirmLoading = false.obs;
  bool get isConfirmLoading => _isConfirmLoading.value;

  late CommonSuccessModel _sendMoneyConfirmModel;
  CommonSuccessModel get sendMoneyConfirmModel => _sendMoneyConfirmModel;

  ///* SendMoneyConfirm in process
  Future<CommonSuccessModel> sendMoneyConfirmProcess() async {
    _isConfirmLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': _sendMoneySubmitModel.data.identifier,
      'recipient': selectRecipientController.id.value.toString()
    };
    await sendMoneyConfirmProcessApi(body: inputBody).then((value) {
      _sendMoneyConfirmModel = value!;

      Get.to(
          SuccessScreen(title: Strings.sendMoney, msg: _sendMoneyConfirmModel.message.success.first, onTap: (){
            Get.offAllNamed(Routes.bottomNavigationScreen);
          })
      );

      _isConfirmLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isConfirmLoading.value = false;
    update();
    return _sendMoneyConfirmModel;
  }

}