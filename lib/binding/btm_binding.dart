import 'package:get/get.dart';

import '../controller/add_money/add_money_controller.dart';
import '../controller/btm_nav/bottom_navigation_controller.dart';
import '../controller/exchange_money/exchange_money_controller.dart';
import '../controller/profile/change_password_controller.dart';
import '../controller/profile/edit_profile_controller.dart';
import '../controller/recipient/recipient_controller.dart';
import '../controller/request_money/request_money_controller.dart';
import '../controller/send_money/send_money_controller.dart';
import '../controller/voucher/voucher_controller.dart';
import '../controller/withdraw_money/withdraw_controller.dart';

class BTMBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationController());

    Get.put(EditProfileController());
    Get.put(ChangePasswordController());

    Get.put(AddMoneyController());
    Get.put(RequestMoneyController());
    Get.put(ExchangeMoneyController());
    Get.put(WithdrawController());
    Get.put(SendMoneyController());
    Get.put(VoucherController());
    Get.put(RecipientController());
  }
}
