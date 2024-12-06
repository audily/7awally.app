


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/services_and_models/logs/logs_service.dart';

import '../../backend/services_and_models/logs/request_money_log_model.dart';
import '../../backend/utils/api_method.dart';

class RequestMoneyLogController extends GetxController with LogsService{
  late ScrollController scrollController;
  RxInt selectedIndex = (-1).obs;

  @override
  void onInit() {
    requestMoneyLogProcess();
    scrollController = ScrollController()..addListener(scrollListener);
    super.onInit();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      print('Scrolled to the bottom');
      // Call your function here
      requestMoneyLogMoreProcess();
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

  late RequestMoneyLogModel _requestMoneyLogModel;
  RequestMoneyLogModel get requestMoneyLogModel => _requestMoneyLogModel;

  final _isMoreLoading = false.obs;
  bool get isMoreLoading => _isMoreLoading.value;

  int page = 1;
  RxBool hasNextPage = true.obs;
  RxList<Datum> historyList = <Datum>[].obs;  /// set it first


  ///* Get RequestMoneyLog in process
  Future<RequestMoneyLogModel> requestMoneyLogProcess() async {
    historyList.clear();
    hasNextPage.value = true;
    page = 1;

    _isLoading.value = true;
    update();
    await requestMoneyLogProcessApi(page.toString()).then((value) {
      _requestMoneyLogModel = value!;

      if(_requestMoneyLogModel.data.transactions.lastPage > 1){
        hasNextPage.value = true;
      }else{
        hasNextPage.value = false;
      }

      historyList.addAll(_requestMoneyLogModel.data.transactions.data);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _requestMoneyLogModel;
  }



  ///* Get RequestMoneyLog in process
  Future<RequestMoneyLogModel> requestMoneyLogMoreProcess() async {
    page ++;

    if(hasNextPage.value && !_isMoreLoading.value) {
      _isMoreLoading.value = true;
      update();
      await requestMoneyLogProcessApi(page.toString()).then((value) {
        _requestMoneyLogModel = value!;

        var data = _requestMoneyLogModel.data.transactions.lastPage;
        historyList.addAll(_requestMoneyLogModel.data.transactions.data);

        if (page >= data) {
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
    return _requestMoneyLogModel;

  }


}