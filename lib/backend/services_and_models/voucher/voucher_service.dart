

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'voucher_index_model.dart';
import 'voucher_log_model.dart';
import 'voucher_submit_model.dart';

mixin VoucherService{
  ///* Get VoucherIndex api services
  Future<VoucherIndexModel?> voucherIndexProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.voucherIndexURL + "?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        VoucherIndexModel result = VoucherIndexModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from VoucherIndex api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get VoucherCancel api services
  Future<CommonSuccessModel?> voucherCancelProcessApi({required String code}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.voucherCancelURL + "/$code?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from VoucherCancel api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* VoucherSubmit api services
  Future<VoucherSubmitModel?> voucherSubmitProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.voucherSubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        VoucherSubmitModel result = VoucherSubmitModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from VoucherCreat api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* VoucherRedeem api services
  Future<CommonSuccessModel?> voucherRedeemProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.voucherRedeemURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from VoucherRedeem api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }






  ///* Get VoucherLog api services
  Future<VoucherLogModel?> voucherLogProcessApi(String page) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.voucherLogURL + "?page=$page&lang=${DynamicLanguage.selectedLanguage.value}",
      );
      if (mapResponse != null) {
        VoucherLogModel result = VoucherLogModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from VoucherLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}