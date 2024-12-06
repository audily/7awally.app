import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';
import 'models/fa_info_model.dart';
import 'models/kyc_model.dart';
import 'models/profile_info_model.dart';

mixin ProfileSettingsService {
  ///* Get Kyc api services
  Future<KycModel?> kycProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.kycInfoURL + "?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        KycModel result = KycModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from Kyc api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* KycSubmit api services
  Future<CommonSuccessModel?> kycSubmitProcessApi(
      {required Map<String, String> body,
      required List<String> pathList,
      required List<String> fieldList}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.kycSubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
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
      log.e(
          ':ladybug::ladybug::ladybug: err from KycSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///-----------------------------------------------------------
  ///* Get FaInfo api services
  Future<FaInfoModel?> faInfoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(ApiEndpoint.faInfoURL + "?lang=${DynamicLanguage.selectedLanguage.value}");
      if (mapResponse != null) {
        FaInfoModel result = FaInfoModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from FaInfo api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* FAStatusUpdate api services
  Future<CommonSuccessModel?> fAStatusUpdateProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.faUpdateURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from FAStatusUpdate api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* FaVerify api services
  Future<CommonSuccessModel?> faVerifyProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.faOTPSubmitURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from FaVerify api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///-----------------------------------------------------------
  ///* Get ProfileInfo api services
  Future<ProfileInfoModel?> profileInfoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse =
          await ApiMethod(isBasic: false).get(ApiEndpoint.profileInfoURL + "?lang=${DynamicLanguage.selectedLanguage.value}");
      if (mapResponse != null) {
        ProfileInfoModel result = ProfileInfoModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from ProfileInfo api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* ProfileUpdate api services
  Future<CommonSuccessModel?> profileUpdateProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.profileUpdateURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from ProfileUpdate api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* ProfileUpdate api services
  Future<CommonSuccessModel?> profileUpdateProcessApiWithImage(
      {required Map<String, String> body,
      required String filePath,
      required String filedName}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .multipart(ApiEndpoint.profileUpdateURL + "?lang=${DynamicLanguage.selectedLanguage.value}", body, filePath, filedName);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from ProfileUpdate api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///-----------------------------------------------------------
  ///* PasswordChange api services
  Future<CommonSuccessModel?> passwordChangeProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.passwordUpdateURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from PasswordChange api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* LogOut api services
  Future<CommonSuccessModel?> logOutProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.logOutURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from LogOut api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* DeleteAccount api services
  Future<CommonSuccessModel?> deleteAccountProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.deleteAccountURL + "?lang=${DynamicLanguage.selectedLanguage.value}",
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from DeleteAccount api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
