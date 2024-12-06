import 'package:get/get.dart';

import '../controller/auth/sign_in_controller.dart';
import '../controller/auth/sign_up_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SignUpController(),
    );
    Get.put(
      SignInController(),
    );
  }
}
