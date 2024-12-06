import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:walletium/utils/custom_color.dart';
import 'package:walletium/utils/dimsensions.dart';
import 'package:walletium/utils/size.dart';

import '../../controller/profile/edit_profile_controller.dart';

class InputImageWidget extends StatefulWidget {
  InputImageWidget({Key? key}) : super(key: key);

  @override
  State<InputImageWidget> createState() => _InputImageWidgetState();
}

class _InputImageWidgetState extends State<InputImageWidget> {
  // final _controller = Get.put(InputImageController());

  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EditProfileController>();
    return Obx(() => Container(
        width: 150.w,
        height: 150.w,
        margin: EdgeInsets.all(Dimensions.marginSize * 0.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColor.inputBackgroundColor,
          image: DecorationImage(
            image: pickedFile != null
                ? FileImage(pickedFile!) as ImageProvider
                : NetworkImage(controller.networkImage.value),
            // fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.3),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => _bottomSheet(context));
            },
            child: const Icon(
              Icons.camera_alt,
              color: CustomColor.whiteColor,
            ),
          ),
        )));
  }

  _bottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      margin: EdgeInsets.all(Dimensions.marginSize * 0.5),
      // decoration: const BoxDecoration(
      //     color: Colors.orange,
      //     shape: BoxShape.circle
      // ),
      child: Row(
        mainAxisAlignment: mainCenter,
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.defaultPaddingSize),
            child: IconButton(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  color: CustomColor.primaryColor,
                  size: 50,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.defaultPaddingSize),
            child: IconButton(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera,
                  color: CustomColor.primaryColor,
                  size: 50,
                )),
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    Get.find<EditProfileController>().selectedImagePath.value =
        pickedFile!.path;

    Get.close(1);
    setState(() {});
  }
}
