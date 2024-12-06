

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/voucher/voucher_log_model.dart';
import '../../backend/services_and_models/voucher/voucher_service.dart';
import '../../backend/utils/api_method.dart';

class VoucherLogController extends GetxController with VoucherService{
  late ScrollController scrollController;
  RxInt selectedIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("Profile Controller Called");
    voucherLogProcess();
    scrollController = ScrollController()..addListener(scrollListener);
    super.onInit();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      print('Scrolled to the bottom');
      // Call your function here
      voucherLogMoreProcess();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

///--------------------------------------------------------
  final _isCancelLoading = false.obs;
  bool get isCancelLoading => _isCancelLoading.value;

  late CommonSuccessModel _voucherCancelModel;
  CommonSuccessModel get voucherCancelModel => _voucherCancelModel;

  RxString voucherCode = "".obs;
  ///* Get VoucherCancel in process
  Future<CommonSuccessModel> voucherCancelProcess() async {
    _isCancelLoading.value = true;
    update();
    await voucherCancelProcessApi(code: voucherCode.value).then((value) {
      _voucherCancelModel = value!;

      voucherLogProcess();
      _isCancelLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isCancelLoading.value = false;
    update();
    return _voucherCancelModel;
  }

  /// ------------------------------------- >> set loading process & Pagination Model

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late VoucherLogModel _voucherLogModel;
  VoucherLogModel get voucherLogModel => _voucherLogModel;

  final _isMoreLoading = false.obs;
  bool get isMoreLoading => _isMoreLoading.value;

  int page = 1;
  RxBool hasNextPage = true.obs;
  RxList<Datum> historyList = <Datum>[].obs;

  ///* Get VoucherLog in process
  Future<VoucherLogModel> voucherLogProcess() async {
    historyList.clear();
    hasNextPage.value = true;
    page = 1;

    _isLoading.value = true;
    update();
    await voucherLogProcessApi(page.toString()).then((value) {
      _voucherLogModel = value!;

      debugPrint("Step 1");

      if(_voucherLogModel.data.transactions.lastPage > 1){
        hasNextPage.value = true;
        debugPrint("Step 2");
      }else{
        hasNextPage.value = false;
        debugPrint("Step 3");
      }

      debugPrint("Step 4");
      historyList.addAll(_voucherLogModel.data.transactions.data);

      debugPrint("Step 5");

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _voucherLogModel;
  }

  Future<VoucherLogModel> voucherLogMoreProcess() async {
    page ++;

    if(hasNextPage.value && !_isMoreLoading.value){

      _isMoreLoading.value = true;
      update();
      await voucherLogProcessApi(page.toString()).then((value) {
        _voucherLogModel = value!;

        var data = _voucherLogModel.data.transactions.lastPage;
        historyList.addAll(_voucherLogModel.data.transactions.data);
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

    return _voucherLogModel;
  }
}