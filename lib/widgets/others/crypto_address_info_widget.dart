import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:walletium/utils/size.dart';
import 'package:walletium/widgets/inputs/input_text_field.dart';

import '../../utils/custom_color.dart';
import '../../utils/dimsensions.dart';


class CryptoAddressInfoWidget extends StatelessWidget {
  const CryptoAddressInfoWidget({super.key, required this.address});
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize,
        vertical: Dimensions.paddingVerticalSize,
      ),
      child: Column(
        children: [
          QrImageView(
            data: address,
            version: QrVersions.auto,
            size: 200.0,
          ),

          addVerticalSpace(Dimensions.heightSize),

          InputTextField(
              controller: TextEditingController(text: address),
            suffix: IconButton(
              onPressed: (){
                Clipboard.setData(ClipboardData(text: address));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied $address'),
                    duration: const Duration(seconds: 2), // Duration for which Snackbar is visible
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
                );
              },
              icon: Icon(Icons.copy_all, color: CustomColor.primaryColor),
            ), hintText: '',
            backgroundColor: Colors.transparent,
            hintTextColor: CustomColor.textColor,
            borderColor: CustomColor.gray,
          ),
        ],
      ),
    );
  }
}
