


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';

import '../../backend/services_and_models/recipient/my_recipient_model.dart';
import '../../backend/services_and_models/recipient/recipient_service.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';

class RecipientController extends GetxController with RecipientService{

  RxInt selectedIndex = (-1).obs;
  RxInt selectedUser = (-1).obs;
/// -----------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late MyRecipientModel _myRecipientModel;
  MyRecipientModel get myRecipientModel => _myRecipientModel;

  ///* Get MyRecipient in process
  Future<MyRecipientModel> myRecipientProcess({bool route = true}) async {
    _isLoading.value = true;
    // _isDeleteLoading.value = true;
    update();
    await myRecipientProcessApi().then((value) {
      _myRecipientModel = value!;

      if(route) {
        Future.delayed(Duration(milliseconds: 200), () {
          Get.toNamed(Routes.recipientScreen);
        });
      }else{
        Get.back();
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

/// -----------------------------------------------
  final _isDeleteLoading = false.obs;
  bool get isDeleteLoading => _isDeleteLoading.value;

  late CommonSuccessModel _deleteRecipientModel;
  CommonSuccessModel get deleteRecipientModel => _deleteRecipientModel;

  ///* Get DeleteRecipient in process
  Future<CommonSuccessModel> deleteRecipientProcess(String targetId, BuildContext context) async {
    _deleteItem(context);
    _isDeleteLoading.value = true;
    update();
    await deleteRecipientProcessApi(targetId).then((value) {
      _deleteRecipientModel = value!;


        Navigator.of(context).pop();
        print('Delete pressed');


      myRecipientProcess();
      _isDeleteLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isDeleteLoading.value = false;

    update();
    return _deleteRecipientModel;
  }



  void _deleteItem(BuildContext context) {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Deleting..."),
            ],
          ),
        );
      },
    );
  }
}

