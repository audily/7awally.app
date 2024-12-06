import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

class DateShower extends StatelessWidget {
  final DateTime dateTime;

  DateShower({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryTextWidget(
          text: DateFormat('dd').format(dateTime),
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        PrimaryTextWidget(
          text: DateFormat('MMM').format(dateTime).substring(0, 3),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }
}