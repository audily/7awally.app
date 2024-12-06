import 'dart:io';

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/add_money/add_money_automatic_submit_model.dart';
import '../../backend/services_and_models/add_money/add_money_index_model.dart';
import '../../backend/services_and_models/add_money/add_money_manual_gateway_model.dart';
import '../../backend/services_and_models/add_money/add_money_service.dart';
import '../../backend/services_and_models/add_money/tatum_model.dart' as tatum;
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimsensions.dart';
import '../../utils/size.dart';
import '../../utils/strings.dart';
import '../../views/screens/success_screen.dart';
import '../../widgets/custom_upload_file_widget.dart';
import '../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../widgets/inputs/input_text_field.dart';
import '../../widgets/labels/text_labels_widget.dart';
import '../profile/kyc_controller.dart';

class AddMoneyController extends GetxController with AddMoneyService {
  final amountController = TextEditingController();

  late Rx<UserWallet> selectedWallet;
  late Rx<Currency> selectedGateway;

  List<Currency> gatewayList = [];

  RxDouble exchangeRate = 0.0.obs;
  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  RxDouble totalCharge = 0.0.obs;

  double enteredAmount = 0;
  double conversionAmount = 0;
  double totalConversionAmount = 0;

  calculation(String amount) {
    exchangeRate.value = selectedGateway.value.rate / selectedWallet.value.rate;
    min.value = selectedGateway.value.minLimit / exchangeRate.value;
    max.value = selectedGateway.value.maxLimit / exchangeRate.value;
    if (amount.isNotEmpty) {
      enteredAmount = double.parse(amount);
      totalCharge.value = selectedGateway.value.fixedCharge +
          ((enteredAmount * exchangeRate.value) *
              (selectedGateway.value.percentCharge / 100));

      conversionAmount = enteredAmount * exchangeRate.value;

      totalConversionAmount = conversionAmount + totalCharge.value;
    } else {
      totalCharge.value = selectedGateway.value.fixedCharge;
    }
  }

  ///--------------------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late AddMoneyIndexModel _addMoneyIndexModel;
  AddMoneyIndexModel get addMoneyIndexModel => _addMoneyIndexModel;

  ///* Get AddMoneyIndex in process
  Future<AddMoneyIndexModel> addMoneyIndexProcess() async {
    amountController.clear();
    _isLoading.value = true;
    update();
    await addMoneyIndexProcessApi().then((value) {
      _addMoneyIndexModel = value!;

      selectedWallet =
          _addMoneyIndexModel.data.paymentGateways.userWallet.first.obs;
      selectedGateway = _addMoneyIndexModel
          .data.paymentGateways.gatewayCurrencies.first.currencies.first.obs;

      _addMoneyIndexModel.data.paymentGateways.gatewayCurrencies
          .forEach((element) {
        gatewayList.addAll(element.currencies);
      });

      calculation("");

      Future.delayed(Duration(milliseconds: 200), () {
        Get.toNamed(Routes.addMoneyScreen);
      });

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _addMoneyIndexModel;
  }

  /// >> set loading process & AddMoneyAutomaticSubmit Model
  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late AddMoneyAutomaticSubmitModel _addMoneyAutomaticSubmitModel;
  AddMoneyAutomaticSubmitModel get addMoneyAutomaticSubmitModel =>
      _addMoneyAutomaticSubmitModel;

  ///* AddMoneyAutomaticSubmit in process
  Future<AddMoneyAutomaticSubmitModel> addMoneyAutomaticSubmitProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'gateway_currency': selectedGateway.value.alias,
      'amount': amountController.text,
      'request_currency': selectedWallet.value.currencyCode
    };
    await addMoneyAutomaticSubmitProcessApi(body: inputBody).then((value) {
      _addMoneyAutomaticSubmitModel = value!;
      debugPrint(">> URL >>");
      debugPrint(_addMoneyAutomaticSubmitModel.data.redirectUrl);
      Get.toNamed(Routes.addMoneyDetailsScreen);
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _addMoneyAutomaticSubmitModel;
  }



  /// ------------------------------------- >> set loading process & AddMoneyManualGateway Model

  late tatum.TatumModel _addMoneyTatumModel;
  tatum.TatumModel get addMoneyTatumModel =>
      _addMoneyTatumModel;

  ///* Get AddMoneyManualGateway in process
  Future<tatum.TatumModel> addMoneyTatumProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'gateway_currency': selectedGateway.value.alias,
      'amount': amountController.text,
      'request_currency': selectedWallet.value.currencyCode
    };

    await addMoneyTatumProcessApi(body: inputBody).then((value) {
      _addMoneyTatumModel = value!;

      _getTatumInputField(_addMoneyTatumModel.data.addressInfo.inputFields);
      Get.toNamed(Routes.addMoneyDetailsScreen);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _addMoneyTatumModel;
  }

  List<TextEditingController> inputFieldControllers = [];
  RxList inputFields = [].obs;
  RxList inputFileFields = [].obs;

  final selectedIDType = "".obs;
  List<IdTypeModel> idTypeList = [];

  int totalFile = 0;
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  RxBool hasFile = false.obs;

  late Rx<IdTypeModel> selectedValue;

  void _getTatumInputField(List<tatum.InputField> data) {
    inputFieldControllers.clear();
    inputFields.clear();
    inputFileFields.clear();
    idTypeList.clear();
    listImagePath.clear();
    listFieldName.clear();

    for (int item = 0; item < data.length; item++) {
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);
      if (data[item].type.contains('textarea')) {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              TextLabelsWidget(
                textLabels: data[item].label,
                textColor: CustomColor.textColor,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.5),
                child: InputTextField(
                  maxLine: 3,
                  controller: inputFieldControllers[item],
                  hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.enter) + data[item].label,
                  borderColor: CustomColor.gray,
                  backgroundColor: Colors.transparent,
                  hintTextColor: CustomColor.textColor,
                ),
              ),
            ],
          ),
        );
      }
      else if (data[item].type == 'text') {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              TextLabelsWidget(
                textLabels: data[item].label,
                textColor: CustomColor.textColor,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.5),
                child: InputTextField(
                  controller: inputFieldControllers[item],
                  hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.enter) + data[item].label,
                  borderColor: CustomColor.gray,
                  backgroundColor: Colors.transparent,
                  hintTextColor: CustomColor.textColor,
                ),
              ),
            ],
          ),
        );
      }
    }
  }


  /// ------------------------------------- >> set loading process & AddMoneyManualSubmit Model
  final _isTatumSubmitLoading = false.obs;
  bool get isTatumSubmitLoading => _isTatumSubmitLoading.value;

  late CommonSuccessModel _addMoneyTatumSubmitModel;
  CommonSuccessModel get addMoneyTatumSubmitModel =>
      _addMoneyTatumSubmitModel;

  ///* AddMoneyManualSubmit in process
  Future<CommonSuccessModel> addMoneyTatumSubmitProcess() async {
    _isTatumSubmitLoading.value = true;
    update();
    Map<String, String> inputBody = {
      // 'currency': selectedGateway.value.alias,
      // 'amount': amountController.text,
    };

    final data = _addMoneyTatumModel.data.addressInfo.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }
    await addMoneyTatumSubmitProcessApi(
        body: inputBody, url: addMoneyTatumModel.data.addressInfo.submitUrl)
        .then((value) {
      _addMoneyTatumSubmitModel = value!;

      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();

      Get.to(SuccessScreen(
          title: Strings.addMoney,
          msg: _addMoneyTatumSubmitModel.message.success.first,
          onTap: () {
            Get.offAllNamed(Routes.bottomNavigationScreen);
          }));

      _isTatumSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isTatumSubmitLoading.value = false;
    update();
    return _addMoneyTatumSubmitModel;
  }

  /// ------------------------------------- >> set loading process & AddMoneyManualGateway Model

  late AddMoneyManualGatewayModel _addMoneyManualGatewayModel;
  AddMoneyManualGatewayModel get addMoneyManualGatewayModel =>
      _addMoneyManualGatewayModel;

  ///* Get AddMoneyManualGateway in process
  Future<AddMoneyManualGatewayModel> addMoneyManualGatewayProcess() async {
    _isSubmitLoading.value = true;
    update();
    await addMoneyManualGatewayProcessApi(selectedGateway.value.alias).then((value) {
      _addMoneyManualGatewayModel = value!;

      _getDynamicInputField(_addMoneyManualGatewayModel.data.inputFields);
      Get.toNamed(Routes.addMoneyDetailsScreen);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _addMoneyManualGatewayModel;
  }


  void _getDynamicInputField(List<InputField> data) {
    inputFieldControllers.clear();
    inputFields.clear();
    inputFileFields.clear();
    idTypeList.clear();
    listImagePath.clear();
    listFieldName.clear();

    for (int item = 0; item < data.length; item++) {
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);
      if (data[item].type.contains('select')) {
        hasFile.value = true;
        selectedIDType.value = data[item].validation.options.first.toString();
        inputFieldControllers[item].text = selectedIDType.value;
        for (var element in data[item].validation.options) {
          idTypeList.add(IdTypeModel("", element));
        }
        selectedValue = idTypeList.first.obs;
        inputFields.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.marginSize * 0.5),
                    child: CustomDropDown<IdTypeModel>(
                      selectedValue: selectedValue.value,
                      items: idTypeList,
                      title: data[item].label,
                      hint: selectedIDType.value.isEmpty
                          ? Strings.selectIDType
                          : selectedIDType.value,
                      onChanged: (value) {
                        selectedIDType.value = value!.title;
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingHorizontalSize * 0.25,
                      ),
                      titleTextColor: CustomColor.textColor,
                      selectedTextColor: CustomColor.whiteColor,
                      hintTextColor: CustomColor.textColor,
                      borderEnable: true,
                      dropDownFieldColor: Colors.transparent,
                      decorationColor: CustomColor.textColor,
                    ),
                  )),
              addVerticalSpace(Dimensions.paddingVerticalSize * .3),
            ],
          ),
        );
      }
      else if (data[item].type.contains('file')) {
        totalFile++;
        hasFile.value = true;
        inputFileFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              CustomUploadFileWidget(
                labelText: data[item].label,
                hint: data[item].validation.mimes.join(","),
                onTap: (File value) {
                  updateImageData(data[item].name, value.path);
                },
              ),
            ],
          ),
        );
      }
      else if (data[item].type.contains('textarea')) {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              TextLabelsWidget(
                textLabels: data[item].label,
                textColor: CustomColor.textColor,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.5),
                child: InputTextField(
                  maxLine: 3,
                  controller: inputFieldControllers[item],
                  hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.enter) + data[item].label,
                  borderColor: CustomColor.gray,
                  backgroundColor: Colors.transparent,
                  hintTextColor: CustomColor.textColor,
                ),
              ),
            ],
          ),
        );
      }
      else if (data[item].type == 'text') {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              TextLabelsWidget(
                textLabels: data[item].label,
                textColor: CustomColor.textColor,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.5),
                child: InputTextField(
                  controller: inputFieldControllers[item],
                  hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.enter) + data[item].label,
                  borderColor: CustomColor.gray,
                  backgroundColor: Colors.transparent,
                  hintTextColor: CustomColor.textColor,
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  updateImageData(String fieldName, String imagePath) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      listImagePath[itemIndex] = imagePath;
    } else {
      listFieldName.add(fieldName);
      listImagePath.add(imagePath);
    }
    update();
  }

  /// ------------------------------------- >> set loading process & AddMoneyManualSubmit Model
  final _isManualSubmitLoading = false.obs;
  bool get isManualSubmitLoading => _isManualSubmitLoading.value;

  late CommonSuccessModel _addMoneyManualSubmitModel;
  CommonSuccessModel get addMoneyManualSubmitModel =>
      _addMoneyManualSubmitModel;

  ///* AddMoneyManualSubmit in process
  Future<CommonSuccessModel> addMoneyManualSubmitProcess() async {
    _isManualSubmitLoading.value = true;
    update();
    Map<String, String> inputBody = {
      'currency': selectedGateway.value.alias,
      'request_currency': selectedWallet.value.currencyCode,
      'amount': amountController.text,
    };

    final data = _addMoneyManualGatewayModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }
    await addMoneyManualSubmitProcessApi(
            body: inputBody, fieldList: listFieldName, pathList: listImagePath)
        .then((value) {
      _addMoneyManualSubmitModel = value!;

      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();

      Get.to(SuccessScreen(
          title: Strings.addMoney,
          msg: _addMoneyManualSubmitModel.message.success.first,
          onTap: () {
            Get.offAllNamed(Routes.bottomNavigationScreen);
          }));

      _isManualSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isManualSubmitLoading.value = false;
    update();
    return _addMoneyManualSubmitModel;
  }
}
