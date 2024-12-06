import 'package:get/get.dart';
import '../binding/splash_binding.dart';
import '../binding/welcome_binding.dart';
import '../views/screens/add_money/add_money_details_screen.dart';
import '../views/screens/add_money/add_money_manual_screen.dart';
import '../views/screens/add_money/add_money_tatum_screen.dart';
import '../views/screens/auth/forgot_otp_screen.dart';
import '../views/screens/logs/add_money_log_screen.dart';
import '../views/screens/logs/exchange_money_log_screen.dart';
import '../views/screens/logs/log_tatum/log_tatum_screen.dart';
import '../views/screens/logs/request_money_log_screen.dart';
import '../views/screens/logs/send_money_log_screen.dart';
import '../views/screens/logs/withdraw_log_screen.dart';
import '../views/screens/profile_settings/change_password_screen.dart';
import '../views/screens/profile_settings/edit_profile_screen.dart';
import '../views/screens/drawer/kyc_screen.dart';
import '../views/screens/onboard_screen.dart';
import '../views/screens/auth/phone_verification_screen.dart';
import '../views/screens/profile_settings/language_change_screen.dart';
import '../views/screens/request_money/request_money_review_screen.dart';
import '../views/screens/request_money/request_money_screen.dart';
import '../views/screens/auth/reset_password_screen.dart';
import '../views/screens/send_money/send_money_details_screen.dart';
import '../views/screens/send_money/send_money_screen.dart';
import '../views/screens/auth/sign_up_screen.dart';
import '../views/screens/splash_screen.dart';
import '../views/screens/voucher/voucher_log_screen.dart';
import '../views/screens/welcome_screen.dart';
import '../views/screens/withdraw_money/withdraw_money_details_screen.dart';
import '../views/screens/withdraw_money/withdraw_money_preview_screen.dart';
import '../views/screens/withdraw_money/withdraw_screen.dart';
import '../widgets/others/bottom_navigation_widget.dart';

import '../binding/btm_binding.dart';
import '../views/screens/add_money/add_money_screen.dart';
import '../views/screens/auth/sign_in_screen.dart';
import '../views/screens/exchange_money/exchange_money_screen.dart';
import '../views/screens/profile_settings/fa_otp_screen.dart';
import '../views/screens/profile_settings/fa_screen.dart';
import '../views/screens/recipient/add_recipient_screen.dart';
import '../views/screens/recipient/recipient_screen.dart';
import '../views/screens/recipient/select_recipient_screen.dart';
import '../views/screens/recipient/update_recipient_screen.dart';
import '../views/screens/voucher/voucher_create_review_screen.dart';
import '../views/screens/voucher/voucher_create_screen.dart';
import '../views/screens/voucher/voucher_redeem_screen.dart';

class Routes {
  static const String splashScreen = '/splashScreen';
  static const String onboardScreen = '/onboardScreen';
  static const String welcomeScreen = '/welcomeScreen';

  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String otpVerificationScreen = '/otpVerificationScreen';
  static const String emailVerificationScreen = '/phoneVerificationScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';

  static const String bottomNavigationScreen = '/bottomNavigationScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String changeLanguageScreen = '/changeLanguageScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String faScreen = '/faScreen';
  static const String faOtpScreen = '/faOtpScreen';
  static const String kycScreen = '/kycScreen';

  static const String addMoneyScreen = '/depositScreen';
  static const String addMoneyDetailsScreen = '/addMoneyDetailsScreen';
  static const String addMoneyManualScreen = '/AddMoneyManualScreen';
  static const String addMoneyTatumScreen = '/addMoneyTatumScreen';
  static const String logTatumScreen = '/logTatumScreen';

  static const String withdrawScreen = '/withdrawScreen';
  static const String withdrawMoneyDetailsScreen =
      '/withdrawMoneyDetailsScreen';
  static const String withdrawMoneyReviewScreen = '/withdrawMoneyReviewScreen';


  static const String sendMoneyScreen = '/sendMoneyScreen';
  static const String sendMoneyDetailsScreen = '/sendMoneyDetailsScreen';

  static const String requestMoneyScreen = '/requestMoneyScreen';
  static const String requestMoneyReviewScreen = '/requestMoneyReviewScreen';

  static const String exchangeMoneyScreen = '/exchangeMoneyScreen';
  static const String exchangeMoneyReviewScreen = '/exchangeMoneyReviewScreen';

  static const String exchangeMoneyLogScreen = '/transactionsHistoryScreen';
  static const String sendMoneyLogScreen = '/transferHistoryScreen';
  static const String depositLogScreen = '/depositHistoryScreen';
  static const String withdrawLogScreen = '/withdrawHistoryScreen';

  static const String createVoucherScreen = '/voucherScreen';
  static const String redeemVoucherScreen = '/redeemVoucherScreen';
  static const String createVoucherPreviewScreen =
      '/createVoucherPreviewScreen';

  static const String voucherLogScreen =
      '/voucherLogScreen';
  static const String requestMoneyLogScreen =
      '/RequestMoneyLogScreen';

  static const String recipientScreen = '/recipientScreen';
  static const String selectRecipientScreen = '/selectRecipientScreen';
  static const String addRecipientScreen = '/addRecipientScreen';
  static const String updateRecipientScreen = '/updateRecipientScreen';
  static const String languageChangeScreen = '/languageChangeScreen';

  static var list = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: onboardScreen,
      page: () => OnboardScreen(),
    ),
    GetPage(
      name: welcomeScreen,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding()
    ),

    GetPage(
      name: signInScreen,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: otpVerificationScreen,
      page: () => OtpVerificationScreen(),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: emailVerificationScreen,
      page: () => PhoneVerificationScreen(),
    ),
    GetPage(
        name: bottomNavigationScreen,
        page: () => BottomNavigationWidget(),
        binding: BTMBinding()),
    GetPage(
      name: changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),

    GetPage(
      name: editProfileScreen,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: addMoneyScreen,
      page: () => AddMoneyScreen(),
    ),
    GetPage(
      name: withdrawScreen,
      page: () => WithdrawScreen(),
    ),

    GetPage(
      name: sendMoneyScreen,
      page: () => SendMoneyScreen(),
    ),

    GetPage(
      name: sendMoneyDetailsScreen,
      page: () => SendMoneyDetailsScreen(),
    ),

    GetPage(
      name: requestMoneyScreen,
      page: () => RequestMoneyScreen(),
    ),
    GetPage(
      name: requestMoneyReviewScreen,
      page: () => const RequestMoneyReviewScreen(),
    ),

    GetPage(
      name: exchangeMoneyScreen,
      page: () => ExchangeMoneyScreen(),
    ),

    GetPage(
      name: addMoneyDetailsScreen,
      page: () => AddMoneyDetailsScreen(),
    ),
    GetPage(
      name: addMoneyManualScreen,
      page: () => AddMoneyManualScreen(),
    ),
    GetPage(
      name: addMoneyTatumScreen,
      page: () => AddMoneyTatumScreen(),
    ),
    GetPage(
      name: logTatumScreen,
      page: () => LogTatumScreen(),
    ),
    GetPage(
      name: withdrawMoneyDetailsScreen,
      page: () => WithdrawMoneyDetailsScreen(),
    ),
    GetPage(
      name: withdrawMoneyReviewScreen,
      page: () => const WithdrawMoneyPreviewScreen(),
    ),
    GetPage(
      name: exchangeMoneyLogScreen,
      page: () => ExchangeMoneyLogScreen(),
    ),
    GetPage(
      name: sendMoneyLogScreen,
      page: () => SendMoneyLogScreen(),
    ),
    GetPage(
      name: depositLogScreen,
      page: () => AddMoneyLogScreen(),
    ),
    GetPage(
      name: withdrawLogScreen,
      page: () => WithdrawLogScreen(),
    ),
    GetPage(
      name: kycScreen,
      page: () => KycScreen(),
    ),
    GetPage(
      name: faOtpScreen,
      page: () => FaOtpScreen(),
    ),
    GetPage(
      name: faScreen,
      page: () => FAScreen(),
    ),

    GetPage(
      name: createVoucherScreen,
      page: () => CreateVoucherScreen(),
    ),
    GetPage(
      name: createVoucherPreviewScreen,
      page: () => VoucherCreateReviewScreen(),
    ),
    GetPage(
      name: redeemVoucherScreen,
      page: () => RedeemVoucherScreen(),
    ),

    GetPage(
      name: recipientScreen,
      page: () => RecipientScreen(),
    ),
    GetPage(
      name: selectRecipientScreen,
      page: () => SelectRecipientScreen(),
    ),

    GetPage(
      name: addRecipientScreen,
      page: () => AddRecipientScreen(),
    ),
    GetPage(
      name: updateRecipientScreen,
      page: () => UpdateRecipientScreen(),
    ),

    GetPage(
      name: voucherLogScreen,
      page: () => VoucherLogScreen(),
    ),
    GetPage(
      name: requestMoneyLogScreen,
      page: () => RequestMoneyLogScreen(),
    ),
    GetPage(
      name: languageChangeScreen,
      page: () => LanguageChangeScreen(),
    ),
  ];
}
