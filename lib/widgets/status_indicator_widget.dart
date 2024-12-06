import 'package:flutter/material.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../utils/strings.dart';

class StatusIndicatorWidget extends StatelessWidget {
  final int status;

  StatusIndicatorWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case 1:
        color = Colors.green;
        text = Strings.success;
        break;
      case 2:
        color = Colors.orange;
        text = Strings.pending;
        break;
      case 3:
        color = Colors.redAccent;
        text = Strings.hold;
        break;
      case 4:
        color = Colors.red;
        text = Strings.rejected;
        break;
      case 5:
        color = Colors.yellow;
        text = Strings.waiting;
        break;
      default:
        color = Colors.grey;
        text = Strings.unknown;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 6,
        ),
        SizedBox(width: 5),
        PrimaryTextWidget(
          text: text,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}