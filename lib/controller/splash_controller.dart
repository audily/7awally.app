import 'dart:async';

import 'package:get/get.dart';
import 'package:walletium/local_storage/local_storage.dart';
import 'package:walletium/routes/routes.dart';

import '../backend/utils/navigator_plug.dart';
import '../views/deep_link_screen.dart';

// bool _initialURILinkHandled = false;

class SplashController extends GetxController {
  final navigatorPlug = NavigatorPlug();

  @override
  void onReady() {
    super.onReady();
    // _initURIHandler();
    // _incomingLinkHandler();
    navigatorPlug.startListening(
      seconds: 3,
      onChanged: () {
        // debugPrint("UNI Link Detail ==>> ");
        // debugPrint(_initialURI.toString());
        // debugPrint(_currentURI?.host.toString());
        // debugPrint(_currentURI?.scheme.toString());
        // debugPrint(_currentURI?.path.toString());
        // debugPrint(_currentURI?.toString());

        if (LocalStorage.isLoggedIn()) {
          if (_initialURI == null) {
            Get.offAllNamed(Routes.bottomNavigationScreen);
          } else {
            if (_initialURI.toString().contains('request-money/payment')) {
              Get.to(DeepLinkScreen(
                id: extractTokenFromUrl(_initialURI.toString()),
              ));
            } else {
              Get.offAllNamed(Routes.bottomNavigationScreen);
            }
          }
        } else {
          Get.offAllNamed(Routes.onboardScreen);
        }
      },
    );
  }

  String extractTokenFromUrl(String url) {
    List<String> segments = url.split('/');
    String lastSegment = segments.last;
    return lastSegment;
  }

  @override
  void onClose() {
    navigatorPlug.stopListening();
    super.onClose();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Uri? _initialURI;
  // Uri? _currentURI;
  Object? err;

  StreamSubscription? _streamSubscription;

  // Future<void> _initURIHandler() async {
  //   if (!_initialURILinkHandled) {
  //     _initialURILinkHandled = true;
  //     try {
  //       final initialURI = await getInitialUri();

  //       if (initialURI != null) {
  //         debugPrint("Initial URI received $initialURI");
  //         _initialURI = initialURI;
  //       } else {
  //         debugPrint("Null Initial URI received");
  //       }
  //     } on PlatformException {
  //       debugPrint("Failed to receive initial uri");
  //     } on FormatException catch (er) {
  //       err = er;
  //       debugPrint('Malformed Initial URI received');
  //     }
  //   }
  // }

  // void _incomingLinkHandler() {
  //   if (!kIsWeb) {
  //     // It will handle app links while the app is already started - be it in
  //     // the foreground or in the background.
  //     _streamSubscription = uriLinkStream.listen((Uri? uri) {
  //       // if (!mounted) {
  //       //   return;
  //       // }
  //       debugPrint('Received URI: $uri');
  //       // setState(() {
  //       _currentURI = uri;
  //       err = null;
  //       // });
  //     }, onError: (Object er) {
  //       // if (!mounted) {
  //       //   return;
  //       // }
  //       debugPrint('Error occurred: $er');
  //       // setState(() {
  //       _currentURI = null;
  //       if (er is FormatException) {
  //         err = er;
  //       } else {
  //         err = null;
  //       }
  //       // });
  //     });
  //   }
  // }
}


