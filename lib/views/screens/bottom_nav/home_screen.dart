import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:walletium/backend/utils/custom_loading_api.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/custom_style.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/utils/strings.dart';
import 'package:walletium/views/screens/drawer/drawer_screen.dart';
import 'package:walletium/widgets/others/card_slider_widget.dart';
import 'package:walletium/widgets/others/small_container_widget.dart';

import '../../../backend/services_and_models/bottom_nav/models/dashboard_model.dart';
import '../../../backend/utils/no_data_widget.dart';
import '../../../controller/add_money/add_money_controller.dart';
import '../../../controller/btm_nav/bottom_navigation_controller.dart';
import '../../../controller/exchange_money/exchange_money_controller.dart';
import '../../../controller/profile/edit_profile_controller.dart';
import '../../../controller/recipient/recipient_controller.dart';
import '../../../controller/request_money/request_money_controller.dart';
import '../../../controller/send_money/send_money_controller.dart';
import '../../../controller/voucher/voucher_controller.dart';
import '../../../controller/withdraw_money/withdraw_controller.dart';
import '../../../utils/assets.dart';
import '../../../widgets/labels/primary_text_widget.dart';
import '../../../widgets/stack_loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        iconTheme: const IconThemeData(color: CustomColor.whiteColor),
        title: const PrimaryTextWidget(
            text: Strings.dashboard, color: CustomColor.whiteColor),
        elevation: 0,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Get.find<BottomNavigationController>().dashboardProcess();
        Get.find<BottomNavigationController>().notificationProcess();
        Get.find<EditProfileController>().profileInfoProcess();
      },
      child: Obx(() => Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  CardSliderWidget(),
                  addVerticalSpace(10.h),
                  _smallContainerWidget(context),
                  addVerticalSpace(5.h),
                ],
              ),
              Get.find<BottomNavigationController>().isLoading
                  ? CustomLoadingAPI()
                  : DraggableScrollableSheet(
                          builder: (_, scrollController) {
                            return _transactionHistoryWidget(
                                context, scrollController);
                          },
                          initialChildSize: .4,
                          minChildSize: 0.35,
                          maxChildSize: 0.99,
                        ),
              if (Get.find<AddMoneyController>().isLoading ||
                  Get.find<WithdrawController>().isLoading ||
                  Get.find<SendMoneyController>().isLoading ||
                  Get.find<RequestMoneyController>().isLoading ||
                  Get.find<ExchangeMoneyController>().isLoading ||
                  Get.find<RecipientController>().isLoading ||
                  Get.find<VoucherController>().isLoading)
                TransparentLoader()
            ],
          )),
    );
  }

  _smallContainerWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize * 1.5,
        vertical: Dimensions.paddingVerticalSize * 1.2,
      ),
      child: Obx(() => Column(
            crossAxisAlignment: crossStart,
            mainAxisAlignment: mainCenter,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmallContainerWidget(
                    loader: Get.find<AddMoneyController>().isLoading,
                    onPressed: () {
                      Get.find<AddMoneyController>().addMoneyIndexProcess();
                    },
                    icon: Assets.deposit,
                    containerName: Strings.addMoney,
                  ),
                  addHorizontalSpace(10.w),
                  SmallContainerWidget(
                    loader: Get.find<WithdrawController>().isLoading,
                    onPressed: () {
                      Get.find<WithdrawController>()
                          .withdrawMoneyIndexProcess();
                    },
                    icon: Assets.withdraw,
                    containerName: Strings.withdraw,
                  ),
                  addHorizontalSpace(10.w),
                  SmallContainerWidget(
                    loader: Get.find<SendMoneyController>().isLoading,
                    onPressed: () {
                      Get.find<SendMoneyController>().sendMoneyIndexProcess();
                    },
                    icon: Assets.send,
                    containerName: Strings.send,
                  ),
                  addHorizontalSpace(10.w),
                  SmallContainerWidget(
                    loader: Get.find<RequestMoneyController>().isLoading,
                    onPressed: () {
                      Get.find<RequestMoneyController>()
                          .requestMoneyIndexProcess();
                    },
                    icon: Assets.requestMoney,
                    containerName: Strings.request,
                  )
                ],
              ),
              addVerticalSpace(15.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmallContainerWidget(
                    loader: Get.find<ExchangeMoneyController>().isLoading,
                    onPressed: () {
                      Get.find<ExchangeMoneyController>()
                          .exchangeMoneyIndexProcess();
                    },
                    icon: Assets.exchange,
                    containerName: Strings.exchange,
                  ),
                  addHorizontalSpace(10.w),
                  SmallContainerWidget(
                    loader: Get.find<RecipientController>().isLoading,
                    onPressed: () {
                      Get.find<RecipientController>().myRecipientProcess();
                    },
                    icon: Assets.recipient,
                    containerName: Strings.recipient,
                  ),
                  addHorizontalSpace(20.w),
                  SmallContainerWidget(
                    loader: Get.find<VoucherController>().isLoading &&
                        Get.find<VoucherController>().createPage.value,
                    onPressed: () {
                      Get.find<VoucherController>().createPage.value = true;
                      Get.find<VoucherController>().voucherIndexProcess();
                    },
                    icon: Assets.createVoucher,
                    containerName: Strings.createVoucher,
                  ),
                  addHorizontalSpace(10.w),
                  SmallContainerWidget(
                      loader: Get.find<VoucherController>().isLoading &&
                          !Get.find<VoucherController>().createPage.value,
                      onPressed: () {
                        Get.find<VoucherController>().createPage.value = false;
                        Get.find<VoucherController>().voucherIndexProcess();
                      },
                      icon: Assets.redeemVoucher,
                      containerName: Strings.redeemVoucher),
                ],
              ),
            ],
          )),
    );
  }

  _transactionHistoryWidget(
      BuildContext context, ScrollController scrollController) {
    return Container(
      // margin: EdgeInsets.all(Dimensions.marginSize),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * 0.5),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: ListView(
        controller: scrollController,
        // physics: BouncingScrollPhysics(),
        children: [
          addVerticalSpace(Dimensions.paddingVerticalSize * .8),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
            ],
          ),
          addVerticalSpace(20.h),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultPaddingSize * 0.3),
            child: PrimaryTextWidget(
              text: Strings.transactionHistory,
              style: CustomStyler.transactionsHistoryStyle,
            ),
          ),
          addVerticalSpace(5.h),
          _transactionHistoryListWidget(context, scrollController),
        ],
      ),
    );
  }

  _transactionHistoryListWidget(
      BuildContext context, ScrollController scrollController) {
    return Get.find<BottomNavigationController>()
            .dashboardModel
            .data
            .recentTransactions
            .isEmpty
        ? NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: Get.find<BottomNavigationController>()
                .dashboardModel
                .data
                .recentTransactions
                .length,
            itemBuilder: (BuildContext context, int index) {
              RecentTransaction data = Get.find<BottomNavigationController>()
                  .dashboardModel
                  .data
                  .recentTransactions[index];

              return SizedBox(
                height: 60.h,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.3),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    crossAxisAlignment: crossCenter,
                    children: [
                      Row(
                        mainAxisAlignment: mainStart,
                        crossAxisAlignment: crossCenter,
                        children: [
                          Icon(
                            FontAwesomeIcons.moneyBill,
                            color: CustomColor.primaryColor,
                            size: 35,
                          ),
                          addHorizontalSpace(15.w),
                          Column(
                            mainAxisAlignment: mainCenter,
                            crossAxisAlignment: crossStart,
                            children: [
                              Row(
                                children: [
                                  PrimaryTextWidget(
                                    text: data.type,
                                    style: CustomStyler.moneyDepositTitleStyle,
                                  ),
                                  addHorizontalSpace(5),
                                  // StatusIndicatorWidget(
                                  //   status: data.status,
                                  // )
                                ],
                              ),
                              PrimaryTextWidget(
                                text: data.trxId,
                                style: CustomStyler.moneyDepositDateStyle
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            Dimensions.defaultTextSize * .6),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: mainCenter,
                        crossAxisAlignment: crossEnd,
                        children: [
                          PrimaryTextWidget(
                            text: DateFormat('dd').format(data.createdAt) +
                                " " +
                                DateFormat('MMM')
                                    .format(data.createdAt)
                                    .substring(0, 3),
                            style: CustomStyler.moneyDepositDollarStyle
                                .copyWith(fontWeight: FontWeight.w200),
                          ),
                          PrimaryTextWidget(
                            text: data.receiveAmount.toStringAsFixed(2) +
                                " " +
                                data.requestCurrency,
                            style: CustomStyler.moneyDepositDollarStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
  }
}
