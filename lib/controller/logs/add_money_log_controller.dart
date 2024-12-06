

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/services_and_models/logs/logs_service.dart';

import '../../backend/model/common/common_success_model.dart';
import '../../backend/services_and_models/add_money/add_money_service.dart';
import '../../backend/services_and_models/add_money/tatum_model.dart' as tatum;
import '../../backend/services_and_models/logs/log_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimsensions.dart';
import '../../utils/size.dart';
import '../../utils/strings.dart';
import '../../views/screens/success_screen.dart';
import '../../widgets/inputs/input_text_field.dart';
import '../../widgets/labels/text_labels_widget.dart';
import '../profile/kyc_controller.dart';

class AddMoneyLogController extends GetxController with LogsService , AddMoneyService{
  RxInt selectedIndex = (-1).obs;



  late ScrollController scrollController;

  @override
  void onInit() {
    logProcess();
    scrollController = ScrollController()..addListener(scrollListener);
    super.onInit();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      print('Scrolled to the bottom');
      logMoreProcess();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// ------------------------------------- >>

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late LogModel _logModel;
  LogModel get logModel => _logModel;

  final _isMoreLoading = false.obs;
  bool get isMoreLoading => _isMoreLoading.value;

  int page = 1;
  RxBool hasNextPage = true.obs;
  RxList<Datum> historyList = <Datum>[].obs;  /// set it first


  ///* Get WithdrawLog in process
  Future<LogModel> logProcess() async {
    historyList.clear();
    hasNextPage.value = true;
    page = 1;

    _isLoading.value = true;
    update();
    await addMoneyLogProcessApi(page.toString()).then((value) {
      _logModel = value!;

      if(_logModel.data.transactions.lastPage > 1){
        hasNextPage.value = true;
      }else{
        hasNextPage.value = false;
      }

      historyList.addAll(_logModel.data.transactions.data);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _logModel;
  }



  ///* Get WithdrawLog in process
  Future<LogModel> logMoreProcess() async {
    page ++;

    if(hasNextPage.value && !_isMoreLoading.value){

      _isMoreLoading.value = true;
      update();
      await addMoneyLogProcessApi(page.toString()).then((value) {
        _logModel = value!;

        var data = _logModel.data.transactions.lastPage;
        historyList.addAll(_logModel.data.transactions.data);
        if(page >= data){
          hasNextPage.value = false;
        }

        _isMoreLoading.value = false;

        update();
      }).catchError((onError) {
        log.e(onError);
      });

      _isMoreLoading.value = false;
      update();

    }
    return _logModel;
  }





  /// ------------------------------------- >> set loading process & AddMoneyManualGateway Model

  late tatum.TatumModel _logTatumModel;
  tatum.TatumModel get logTatumModel =>
      _logTatumModel;

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  ///* Get AddMoneyManualGateway in process
  Future<tatum.TatumModel> logTatumProcess(String trxId) async {
    _isSubmitLoading.value = true;
    update();

    await logTatumProcessApi(trxId: trxId).then((value) {
      _logTatumModel = value!;

      _getTatumInputField(_logTatumModel.data.addressInfo.inputFields);
      Get.toNamed(Routes.logTatumScreen);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _logTatumModel;
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

  late CommonSuccessModel _logTatumSubmitModel;
  CommonSuccessModel get logTatumSubmitModel =>
      _logTatumSubmitModel;

  ///* AddMoneyManualSubmit in process
  Future<CommonSuccessModel> logTatumSubmitProcess() async {
    _isTatumSubmitLoading.value = true;
    update();
    Map<String, String> inputBody = {};

    final data = _logTatumModel.data.addressInfo.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }
    await addMoneyTatumSubmitProcessApi(
        body: inputBody, url: logTatumModel.data.addressInfo.submitUrl)
        .then((value) {
      _logTatumSubmitModel = value!;

      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();

      Get.to(SuccessScreen(
          title: Strings.addMoney,
          msg: _logTatumSubmitModel.message.success.first,
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
    return _logTatumSubmitModel;
  }
}