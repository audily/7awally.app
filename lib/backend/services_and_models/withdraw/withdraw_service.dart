

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'withdraw_money_index_model.dart';
import 'withdraw_money_submit_model.dart';

mixin WithdrawService{

  ///* Get WithdrawMoneyIndex api services
  Future<WithdrawMoneyIndexModel?> withdrawMoneyIndexProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.withdrawMoneyIndexURL + "?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        WithdrawMoneyIndexModel result = WithdrawMoneyIndexModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawMoneyIndex api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* WithdrawMoneySubmitModel api services
  Future<WithdrawMoneySubmitModel?> withdrawMoneySubmitProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.withdrawMoneySubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        WithdrawMoneySubmitModel result = WithdrawMoneySubmitModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawMoneySubmitModel api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* WithdrawMoneyConfirm api services
  Future<CommonSuccessModel?> withdrawMoneyConfirmProcessApi(
      {required Map<String, String> body,
        required List<String> pathList,
        required List<String> fieldList}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.withdrawMoneyConfirmURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
        pathList: pathList,
        fieldList: fieldList,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawMoneyConfirm api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}