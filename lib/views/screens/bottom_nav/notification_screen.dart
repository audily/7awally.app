import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/views/screens/drawer/drawer_screen.dart';

import '../../../backend/services_and_models/bottom_nav/models/notifications_model.dart'
    as notification;
import '../../../backend/utils/no_data_widget.dart';
import '../../../controller/btm_nav/bottom_navigation_controller.dart';
import '../../../widgets/labels/primary_text_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBackgroundColor,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        iconTheme: const IconThemeData(color: CustomColor.whiteColor),
        title: const PrimaryTextWidget(
            text: Strings.notification, color: CustomColor.whiteColor),
        elevation: 0,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return _transactionHistoryListWidget(context);
  }

  _transactionHistoryListWidget(BuildContext context) {
    return Get.find<BottomNavigationController>()
            .notificationModel
            .data
            .notifications
            .isEmpty
        ? NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Get.find<BottomNavigationController>()
                .notificationModel
                .data
                .notifications
                .length,
            itemBuilder: (BuildContext context, int index) {
              notification.Notification data =
                  Get.find<BottomNavigationController>()
                      .notificationModel
                      .data
                      .notifications[index];
              return SizedBox(
                // height: 60.h,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.3),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    crossAxisAlignment: crossCenter,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: mainStart,
                          crossAxisAlignment: crossCenter,
                          children: [
                            Container(
                              width: 50.h,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: CustomColor.textColor,
                                image: DecorationImage(
                                    image: NetworkImage(data.message.image),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              ),
                            ),
                            addHorizontalSpace(10.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: mainCenter,
                                crossAxisAlignment: crossStart,
                                children: [
                                  PrimaryTextWidget(
                                    text: data.message.title,
                                    style: CustomStyler.moneyDepositTitleStyle,
                                  ),
                                  PrimaryTextWidget(
                                    text: data.message.message,
                                    style: CustomStyler.moneyDepositDateStyle
                                        .copyWith(
                                            fontSize: 9,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      addHorizontalSpace(5.w),
                      PrimaryTextWidget(
                        text: data.message.time,
                        style: CustomStyler.moneyDepositDollarStyle,
                      )
                    ],
                  ),
                ),
              );
            });
  }
}
