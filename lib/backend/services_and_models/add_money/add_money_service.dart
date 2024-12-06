

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'add_money_automatic_submit_model.dart';
import 'add_money_index_model.dart';
import 'add_money_manual_gateway_model.dart';
import 'tatum_model.dart';

mixin AddMoneyService{

  ///* Get AddMoneyIndex api services
  Future<AddMoneyIndexModel?> addMoneyIndexProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.addMoneyIndexURL + "?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        AddMoneyIndexModel result = AddMoneyIndexModel.fromJson(mapResponse);
        // CustomSnackBarsuccess(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AddMoneyIndex api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* AddMoneyAutomaticSubmit api services
  Future<AddMoneyAutomaticSubmitModel?> addMoneyAutomaticSubmitProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.addMoneyAutomaticSubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        AddMoneyAutomaticSubmitModel result = AddMoneyAutomaticSubmitModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());toString
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AddMoneyAutomaticSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get AddMoneyManualGateway api services
  Future<AddMoneyManualGatewayModel?> addMoneyManualGatewayProcessApi(String alias) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.addMoneyManualInputURL + "?alias=$alias&lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        AddMoneyManualGatewayModel result = AddMoneyManualGatewayModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AddMoneyManualGateway api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* AddMoneyManualSubmit api services
  Future<CommonSuccessModel?> addMoneyManualSubmitProcessApi(
      {required Map<String, String> body, required List<String> fieldList, required List<String> pathList}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.addMoneyManualSubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
        pathList: pathList,
        fieldList: fieldList,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AddMoneyManualSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }



  ///* AddMoneyTatum api services
  Future<TatumModel?> addMoneyTatumProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.addMoneyAutomaticSubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        TatumModel result = TatumModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());toString
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AddMoneyTatumSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* AddMoneyLogTatum api services
  Future<TatumModel?> logTatumProcessApi(
      {required String trxId}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.logTatumURL + "/$trxId?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        TatumModel result = TatumModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AddMoneyTatumSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* AddMoneyTatumSubmit api services
  Future<CommonSuccessModel?> addMoneyTatumSubmitProcessApi({required Map<String, String> body, required String url}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        url + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AddMoneyManualSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}