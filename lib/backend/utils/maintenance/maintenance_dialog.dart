    // ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';

import '../../../utils/dimsensions.dart';
import 'maintenance_model.dart';

class SystemMaintenanceController extends GetxController {
  RxBool maintenanceStatus = false.obs;
}

class MaintenanceDialog {
  show({required MaintenanceModel maintenanceModel}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          Restart.restartApp();
          return false;
        },
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            // color: Get.isDarkMode
            //     ? CustomColor.
            //     : CustomColor.primaryLightScaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 0.8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: Dimensions.heightSize * 0.5,
                  ),
                  child: Image.network(
                    "${maintenanceModel.data.baseUrl}/${maintenanceModel.data.imagePath}/${maintenanceModel.data.image}",
                  ),
                ),
                Text(
                   maintenanceModel.data.title,
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: Dimensions.heightSize * 0.5,
                  ),
                  child: Text(
                    maintenanceModel.data.details,
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  child: Text("Restart"),
                  onPressed: () {
                    Restart.restartApp();
                  }
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
