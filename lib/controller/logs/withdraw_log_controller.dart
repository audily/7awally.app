

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/services_and_models/logs/logs_service.dart';

import '../../backend/services_and_models/logs/log_model.dart';
import '../../backend/utils/api_method.dart';

class WithdrawLogController extends GetxController with LogsService{

  RxInt selectedIndex = (-1).obs;

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
    await withdrawLogProcessApi(page.toString()).then((value) {
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
      await withdrawLogProcessApi(page.toString()).then((value) {
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
      // Call your function here
      logMoreProcess();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


}