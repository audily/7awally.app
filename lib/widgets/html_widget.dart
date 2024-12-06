
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../utils/custom_color.dart';
import '../utils/dimsensions.dart';

class HTMLWidget extends StatelessWidget {
  const HTMLWidget({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        'p': Style(
            color: CustomColor.whiteColor.withOpacity(1),
            fontSize: FontSize(Dimensions.defaultTextSize * .8)
        ),
        'li': Style(
            color: CustomColor.whiteColor.withOpacity(.8),
            fontSize: FontSize(Dimensions.defaultTextSize * .7)
        ),
        'a': Style(
            color: Colors.black.withOpacity(.8),
            fontSize: FontSize(Dimensions.defaultTextSize * .8)
        )
      },
    );
  }
}
