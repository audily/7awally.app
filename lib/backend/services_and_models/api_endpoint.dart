import 'package:walletium/backend/extensions/custom_extensions.dart';

class ApiEndpoint {
  // static const String mainDomain = "https://7awally.com";
  static const String mainDomain = "https://7awally.com";
  
  static const String baseUrl = "$mainDomain/api/v1";

  static String languageURL = '/settings/languages'.addBaseURl();
  static String basicSettingsUrl = '/settings/basic-settings'.addBaseURl();
  static String countryListUrl = '/country-list'.addBaseURl();

  static String loginURL = '/login'.addBaseURl();
  static String forgotPassURL = '/password/forgot/find/user'.addBaseURl();
  static String forgotPassVerifyURL = '/password/forgot/verify/code'.addBaseURl();
  static String forgotPassResendURL = '/password/forgot/resend/code?token='.addBaseURl();
  static String forgotPassResetURL = '/password/forgot/reset'.addBaseURl();

  static String registerURL = '/register'.addBaseURl();
  static String registerVerifyURL = '/authorize/mail/verify/code'.addBaseURl();
  static String registerResendURL = '/authorize/mail/resend/code?token='.addBaseURl();

  static String kycInfoURL = '/authorize/kyc/input-fields'.addBaseURl();
  static String kycSubmitURL = '/authorize/kyc/submit'.addBaseURl();

  static String faInfoURL = '/authorize/google/2fa/status'.addBaseURl();
  static String faUpdateURL = '/authorize/google/2fa/status-update'.addBaseURl();
  static String faOTPSubmitURL = '/authorize/google/2fa/verify'.addBaseURl();

  static String profileInfoURL = '/user/profile/info'.addBaseURl();
  static String profileUpdateURL = '/user/profile/info/update'.addBaseURl();
  static String passwordUpdateURL = '/user/profile/password/update'.addBaseURl();
  static String deleteAccountURL = '/user/delete/account'.addBaseURl();
  static String logOutURL = '/user/logout'.addBaseURl();

  static String dashboardURL = '/user/dashboard'.addBaseURl();
  static String notificationsURL = '/user/notifications'.addBaseURl();

  static String requestMoneyIndexURL = '/user/request-money/index'.addBaseURl();
  static String requestMoneySubmitURL = '/user/request-money/submit'.addBaseURl();
  static String requestMoneyInfoURL = '/user/request-money/information'.addBaseURl();
  static String requestMoneyConfirmURL = '/user/request-money/payment-submit'.addBaseURl();

  static String exchangeMoneyIndexURL = '/user/exchange-money/index'.addBaseURl();
  static String exchangeMoneySubmitURL = '/user/exchange-money/submit'.addBaseURl();

  static String withdrawMoneyIndexURL = '/user/withdraw-money/index'.addBaseURl();
  static String withdrawMoneySubmitURL = '/user/withdraw-money/submit'.addBaseURl();
  static String withdrawMoneyConfirmURL = '/user/withdraw-money/manual/confirm'.addBaseURl();

  static String sendMoneyIndexURL = '/user/send-money/index'.addBaseURl();
  static String sendMoneySubmitURL = '/user/send-money/submit'.addBaseURl();
  static String sendMoneyConfirmURL = '/user/send-money/recipient-submit'.addBaseURl();

  static String myRecipientURL = '/user/recipient/my-recipient'.addBaseURl();
  static String searchRecipientURL = '/user/recipient/user-search'.addBaseURl();
  static String storeRecipientURL = '/user/recipient/store-recipient'.addBaseURl();
  static String updateRecipientURL = '/user/recipient/update'.addBaseURl();
  static String deleteRecipientURL = '/user/recipient/delete'.addBaseURl();

  static String addMoneyIndexURL = '/user/add-money/payment-gateways'.addBaseURl();
  static String addMoneyAutomaticSubmitURL = '/user/add-money/automatic/submit'.addBaseURl();
  static String logTatumURL = '/user/add-money/payment/crypto/address'.addBaseURl();

  static String addMoneyManualInputURL = '/user/add-money/manual/input-fields'.addBaseURl();
  static String addMoneyManualSubmitURL = '/user/add-money/manual/submit'.addBaseURl();

  static String voucherIndexURL = '/user/my-voucher/index'.addBaseURl();
  static String voucherSubmitURL = '/user/my-voucher/submit'.addBaseURl();
  static String voucherCancelURL = '/user/my-voucher/cancel'.addBaseURl();
  static String voucherRedeemURL = '/user/my-voucher/redeem-submit'.addBaseURl();

  static String voucherLogURL = '/user/transaction/voucher-money'.addBaseURl();
  static String requestMoneyLogURL = '/user/transaction/request-money'.addBaseURl();
  static String logURL = '/user/transaction/log'.addBaseURl();

}
