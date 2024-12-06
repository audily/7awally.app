

import 'package:dynamic_languages/dynamic_languages.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'log_model.dart';
import 'request_money_log_model.dart';

mixin LogsService{
  ///* Get RequestMoneyLog api services
  Future<RequestMoneyLogModel?> requestMoneyLogProcessApi(String page) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.requestMoneyLogURL + "?page=" + page + "&lang=${DynamicLanguage.selectedLanguage.value}",
      );
      if (mapResponse != null) {
        RequestMoneyLogModel result = RequestMoneyLogModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from RequestMoneyLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get WithdrawLog api services
  Future<LogModel?> withdrawLogProcessApi(String page) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.logURL + "?slug=withdraw&page=" + page + "&lang=${DynamicLanguage.selectedLanguage.value}",
      );
      if (mapResponse != null) {
        LogModel result = LogModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get Exchange api services
  Future<LogModel?> moneyExchangeLogProcessApi(String page) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.logURL + "?slug=money-exchange&page=" + page + "&lang=${DynamicLanguage.selectedLanguage.value}",
      );
      if (mapResponse != null) {
        LogModel result = LogModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from MoneyExchangeLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get AddMoney api services
  Future<LogModel?> addMoneyLogProcessApi(String page) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.logURL + "?slug=add-money&page=" + page + "&lang=${DynamicLanguage.selectedLanguage.value}",
      );
      if (mapResponse != null) {
        LogModel result = LogModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AddMoneyLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get AddMoney api services
  Future<LogModel?> sendMoneyLogProcessApi(String page) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.logURL + "?slug=money-transfer&page=" + page + "&lang=${DynamicLanguage.selectedLanguage.value}",
      );
      if (mapResponse != null) {
        LogModel result = LogModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from SendMoneyLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}