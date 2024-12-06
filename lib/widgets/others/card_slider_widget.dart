import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:walletium/widgets/others/card_widget.dart';

import '../../controller/btm_nav/bottom_navigation_controller.dart';

class CardSliderWidget extends StatefulWidget {
  CardSliderWidget({Key? key}) : super(key: key);


  @override
  State<CardSliderWidget> createState() => _CardSliderWidgetState();
}

class _CardSliderWidgetState extends State<CardSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {


    return Obx(() => Get.find<BottomNavigationController>().isLoading
        ? SizedBox.shrink()
        : Column(
            children: [
              CarouselSlider(
                items: Get.find<BottomNavigationController>()
                    .dashboardModel
                    .data
                    .wallets
                    // .take(Get.find<BottomNavigationController>()
                    //         .dashboardModel
                    //         .data
                    //         .wallets
                    //         .length
                    //         .isGreaterThan(3)
                    //     ? 3
                    //     : Get.find<BottomNavigationController>()
                    //         .dashboardModel
                    //         .data
                    //         .wallets
                    //         .length)
                    .map((item) => CardWidget(
                          data: item,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 150.h,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: mainCenter,
                crossAxisAlignment: crossCenter,
                children: Get.find<BottomNavigationController>()
                    .dashboardModel
                    .data
                    .wallets
                    // .take(Get.find<BottomNavigationController>()
                    //         .dashboardModel
                    //         .data
                    //         .wallets
                    //         .length
                    //         .isGreaterThan(3)
                    //     ? 3
                    //     : Get.find<BottomNavigationController>()
                    //         .dashboardModel
                    //         .data
                    //         .wallets
                    //         .length)
                    .map((url) {
                  int index = Get.find<BottomNavigationController>()
                      .dashboardModel
                      .data
                      .wallets
                      .indexOf(url);
                  return Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(
                      // vertical: Dimensions.marginSize * 0.1,
                      horizontal: Dimensions.marginSize * 0.2,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? CustomColor.whiteColor
                          : const Color(0xFF40B8A9),
                    ),
                  );
                }).toList(),
              )
            ],
          ));
  }
}
