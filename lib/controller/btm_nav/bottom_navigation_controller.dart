import 'package:get/get.dart';

import '../../backend/services_and_models/bottom_nav/bottom_nav_services.dart';
import '../../backend/services_and_models/bottom_nav/models/dashboard_model.dart';
import '../../backend/services_and_models/bottom_nav/models/notifications_model.dart';
import '../../backend/utils/api_method.dart';

class BottomNavigationController extends GetxController with BTMService{
  var _currentIndex = 0.obs;

  getIndex() => _currentIndex.value;

  setIndex(val) => _currentIndex.value = val;


  @override
  void onInit() {
    dashboardProcess();
    notificationProcess();
    super.onInit();
  }

/// ------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late DashboardModel _dashboardModel;
  DashboardModel get dashboardModel => _dashboardModel;

  ///* Get Dashboard in process
  Future<DashboardModel> dashboardProcess() async {
    _isLoading.value = true;
    update();
    await dashboardProcessApi().then((value) {
      _dashboardModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _dashboardModel;
  }


  /// ------------------------------------------------------------

  final _isNotificationLoading = false.obs;
  bool get isNotificationLoading => _isNotificationLoading.value;

  late NotificationModel _notificationModel;
  NotificationModel get notificationModel => _notificationModel;

  ///* Get Notification in process
  Future<NotificationModel> notificationProcess() async {
    _isNotificationLoading.value = true;
    update();
    await notificationProcessApi().then((value) {
      _notificationModel = value!;
      _isNotificationLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isNotificationLoading.value = false;
    update();
    return _notificationModel;
  }
}
