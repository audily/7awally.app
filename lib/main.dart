import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:walletium/routes/routes.dart';

import 'backend/services_and_models/api_endpoint.dart';
import 'backend/utils/maintenance/maintenance_dialog.dart';
import 'backend/utils/network_check/dependency_injection.dart';
import 'controller/settings_controller.dart';

void main() async {
  // await initUniLinks();
  await ScreenUtil.ensureScreenSize();
  InternetCheckDependencyInjection.init();
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) => GetMaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Roboto',
              ),
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent),
        ),
        initialRoute: Routes.splashScreen,
        getPages: Routes.list,
        navigatorKey: Get.key,
        initialBinding: BindingsBuilder(() async {
          Get.put(SystemMaintenanceController(), permanent: true);
          Get.put(SettingController(), permanent: true);
          await DynamicLanguage.init(url: ApiEndpoint.languageURL);
        }),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return Obx(
            () => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(1.0)),
              child: Directionality(
                textDirection: DynamicLanguage.isLoading
                    ? TextDirection.ltr
                    : DynamicLanguage.languageDirection,
                child: widget!,
              ),
            ),
          );
        },
      ),
    );
  }
}
