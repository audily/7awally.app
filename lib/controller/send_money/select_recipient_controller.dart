
import 'package:get/get.dart';

import '../../backend/services_and_models/recipient/my_recipient_model.dart';
import '../../backend/services_and_models/recipient/recipient_service.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';

class SelectRecipientController extends GetxController with RecipientService{

  RxInt selectedIndex = (-1).obs;
  RxInt selectedUser = (-1).obs;

  RxString email = "".obs;
  RxString name = "".obs;
  RxString id = "".obs;
/// -----------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late MyRecipientModel _myRecipientModel;
  MyRecipientModel get myRecipientModel => _myRecipientModel;

  ///* Get MyRecipient in process
  Future<MyRecipientModel> myRecipientProcess({bool route = true}) async {
    selectedUser.value = -1;
    selectedIndex.value = -1;

    _isLoading.value = true;
    // _isDeleteLoading.value = true;
    update();
    await myRecipientProcessApi().then((value) {
      _myRecipientModel = value!;

      if(route){
        Future.delayed(Duration(milliseconds: 200), () {
          Get.toNamed(Routes.selectRecipientScreen);
        });
      }


      _isLoading.value = false;
      // _isDeleteLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    // _isDeleteLoading.value = false;
    update();
    return _myRecipientModel;
  }

}

