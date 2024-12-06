

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'my_recipient_model.dart';
import 'search_recipient_model.dart';

mixin RecipientService{

  ///* Get MyRecipient api services
  Future<MyRecipientModel?> myRecipientProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.myRecipientURL + "?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        MyRecipientModel result = MyRecipientModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from MyRecipient api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get SearchRecipient api services
  Future<SearchRecipientModel?> searchRecipientProcessApi(String user) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.searchRecipientURL + "?text=$user&lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        SearchRecipientModel result = SearchRecipientModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from SearchRecipient api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* StoreRecipient api services
  Future<CommonSuccessModel?> storeRecipientProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.storeRecipientURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from StoreRecipient api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* UpdateRecipient api services
  Future<CommonSuccessModel?> updateRecipientProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.updateRecipientURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from UpdateRecipient api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get DeleteRecipient api services
  Future<CommonSuccessModel?> deleteRecipientProcessApi(String target) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).delete(
          ApiEndpoint.deleteRecipientURL + "?target=$target&lang=${DynamicLanguage.selectedLanguage.value}",
        code: 200
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from DeleteRecipient api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}