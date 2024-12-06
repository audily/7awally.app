import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../utils/custom_color.dart';
import '../../widgets/labels/primary_text_widget.dart';
import '../../widgets/others/back_button_widget.dart';

class WebViewScreen extends StatefulWidget {
  final String link, appTitle;
  final Function? onFinished;

  const WebViewScreen(
      {super.key, required this.link, required this.appTitle, this.onFinished});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: PrimaryTextWidget(
            text: widget.appTitle,
            style: TextStyle(color: CustomColor.whiteColor),
          ),
          leading: const BackButtonWidget(
          ),
          backgroundColor: CustomColor.primaryColor,
          elevation: 0,
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.link)),
              onWebViewCreated: (controller) {
                debugPrint(
                    ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
              },
              onLoadStart: (InAppWebViewController controller, Uri? url) {

                setState(() {
                  isLoading = true;
                });
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) async{


                // Get the current URL
                Uri currentUrl = url!;

                // Get the status code of the current URL
                HttpClient httpClient = HttpClient();
                HttpClientRequest request = await httpClient.getUrl(currentUrl);
                HttpClientResponse response = await request.close();
                int statusCode = response.statusCode;

                print('-------------------------');
                print('>> Status Code: $statusCode');



                controller
                    .evaluateJavascript(
                    source: 'document.querySelector("pre").innerText;')
                    .then((result) {

                  if (result != null) {

                    print(result);
                    print(result.toString().length);
                    print(result);

                    Map<String, dynamic> jsonData = json.decode(result);
                    debugPrint(
                        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    print(jsonData);
                    debugPrint(
                        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    widget.onFinished!(jsonData);
                  }
                });

                setState(() {
                  isLoading = false;
                });
              },
            ),
            Visibility(visible: isLoading, child: const CustomLoadingAPI())
          ],
        ));
  }
}
