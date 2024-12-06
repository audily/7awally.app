import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:walletium/utils/size.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../utils/custom_color.dart';
import '../utils/dimsensions.dart';
import '../utils/strings.dart';

class CustomUploadFileWidget extends StatefulWidget {
  const CustomUploadFileWidget({
    super.key,
    required this.labelText,
    required this.onTap,
    this.hint = "",
    this.optional = "",
  });

  final String labelText, optional, hint;
  final Function onTap;

  @override
  State<CustomUploadFileWidget> createState() => _CustomUploadFileWidgetState();
}

class _CustomUploadFileWidgetState extends State<CustomUploadFileWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PrimaryTextWidget(
              text: widget.labelText,
              fontWeight: FontWeight.w600,
            ),
            Visibility(
              visible: widget.optional.isNotEmpty,
              child: PrimaryTextWidget(
                text: widget.optional,
                opacity: .4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        addVerticalSpace(Dimensions.paddingVerticalSize * .2),
        InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              setState(() {
                file = File(result.files.single.path!);
                debugPrint("Picked ${file!.path}");
                // file.
                widget.onTap(file);
              });
            } else {
              // User canceled the picker
            }
          },
          child: Container(
            width: double.infinity,
            height: Dimensions.buttonHeight * 1.5,
            alignment: Alignment.center,
            decoration: DottedDecoration(
              shape: Shape.box,
              dash: const [3, 3],
              color: Theme.of(context).primaryColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(Dimensions.radius * .5),
            ),
            child: file == null
                ? DelayedDisplay(
                    delay: Duration(milliseconds: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.backup_outlined,
                          size: 30,
                          color: CustomColor.primaryColor.withOpacity(.4),
                        ),
                        addVerticalSpace(3),
                        PrimaryTextWidget(
                          text: Strings.upload,
                          color: CustomColor.primaryColor.withOpacity(.4),
                        ),
                      ],
                    ),
                  )
                : isImage(file!)
                    ? Image.file(
                        file!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(getFileNameFromPath(file!),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                      ),
          ),
        ),
        addVerticalSpace(Dimensions.paddingVerticalSize * .2),
        Visibility(
          visible: widget.hint.isNotEmpty,
          child: PrimaryTextWidget(
            text: widget.hint,
            opacity: .8,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.defaultTextSize * .5,
          ),
        )
      ],
    );
  }
}

// Function to check if the file is an image
bool isImage(File file) {
  String? mimeType = lookupMimeType(file.path);

  if (mimeType != null && mimeType.split('/').first == 'image') {
    return true;
  }
  return false;
}

String getFileNameFromPath(File file) {
  String fileName = p.basename(file.path);
  return fileName;
}
