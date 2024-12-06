

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'send_money_index_model.dart';
import 'send_money_submit_model.dart';

mixin SendMoneyService{


  ///* Get SendMoneyIndex api services
  Future<SendMoneyIndexModel?> sendMoneyIndexProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.sendMoneyIndexURL + "?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        SendMoneyIndexModel result = SendMoneyIndexModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from SendMoneyIndex api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* SendMoneySubmit api services
  Future<SendMoneySubmitModel?> sendMoneySubmitProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.sendMoneySubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        SendMoneySubmitModel result = SendMoneySubmitModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from SendMoneySubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* SendMoneyConfirm api services
  Future<CommonSuccessModel?> sendMoneyConfirmProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.sendMoneyConfirmURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from SendMoneyConfirm api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}