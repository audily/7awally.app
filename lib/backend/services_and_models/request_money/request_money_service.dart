

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'request_money_index_model.dart';
import 'request_money_info_model.dart';
import 'request_money_submit_model.dart';

mixin RequestMoney{


  ///* Get RequestMoneyIndex api services
  Future<RequestMoneyIndexModel?> requestMoneyIndexProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.requestMoneyIndexURL + "?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        RequestMoneyIndexModel result = RequestMoneyIndexModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from RequestMoneyIndex api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }



  ///* RequestMoneySubmit api services
  Future<RequestMoneySubmitModel?> requestMoneySubmitProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.requestMoneySubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        RequestMoneySubmitModel result = RequestMoneySubmitModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from RequestMoneySubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }



  ///* Get RequestMoneyInfo api services
  Future<RequestMoneyInfoModel?> requestMoneyInfoProcessApi(String token) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.requestMoneyInfoURL + "?token=$token&lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        RequestMoneyInfoModel result = RequestMoneyInfoModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from RequestMoneyInfo api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }



  ///* RequestMoneyConfirm api services
  Future<CommonSuccessModel?> requestMoneyConfirmProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.requestMoneyConfirmURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from RequestMoneyConfirm api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}