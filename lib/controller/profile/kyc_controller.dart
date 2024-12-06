import 'dart:io';

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletium/backend/model/common/common_success_model.dart';
import 'package:walletium/utils/size.dart';

import '../../backend/services_and_models/profile_settings/models/kyc_model.dart';
import '../../backend/services_and_models/profile_settings/profile_settings_services.dart';
import '../../backend/utils/api_method.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimsensions.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_upload_file_widget.dart';
import '../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../widgets/inputs/input_text_field.dart';
import '../../widgets/labels/text_labels_widget.dart';

class KYCController extends GetxController with ProfileSettingsService {
  @override
  void onInit() {
    kycProcess();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late KycModel _kycModel;
  KycModel get kycModel => _kycModel;

  Future<KycModel> kycProcess() async {
    _isLoading.value = true;
    update();
    await kycProcessApi().then((value) {
      _kycModel = value!;
      _getDynamicInputField(_kycModel.data.inputFields);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _kycModel;
  }

  List<TextEditingController> inputFieldControllers = [];
  RxList inputFields = [].obs;
  RxList inputFileFields = [].obs;

  final selectedIDType = "".obs;
  List<IdTypeModel> idTypeList = [];

  int totalFile = 0;
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  RxBool hasFile = false.obs;

  late Rx<IdTypeModel> selectedValue;

  void _getDynamicInputField(List<InputField> data) {
    inputFieldControllers.clear();
    inputFields.clear();
    inputFileFields.clear();
    idTypeList.clear();
    listImagePath.clear();
    listFieldName.clear();


    for (int item = 0; item < data.length; item++) {
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);
      if (data[item].type.contains('select')) {
        hasFile.value = true;
        selectedIDType.value = data[item].validation.options.first.toString();
        inputFieldControllers[item].text = selectedIDType.value;
        for (var element in data[item].validation.options) {
          idTypeList.add(IdTypeModel("", element));
        }
        selectedValue = idTypeList.first.obs;
        inputFields.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.marginSize * 0.5),
                    child: CustomDropDown<IdTypeModel>(
                      selectedValue: selectedValue.value,
                      items: idTypeList,
                      title: data[item].label,
                      hint: selectedIDType.value.isEmpty
                          ? Strings.selectIDType
                          : selectedIDType.value,
                      onChanged: (value) {
                        selectedIDType.value = value!.title;
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingHorizontalSize * 0.25,
                      ),
                      titleTextColor: CustomColor.textColor,
                      selectedTextColor: CustomColor.whiteColor,
                      hintTextColor: CustomColor.textColor,
                      borderEnable: true,
                      dropDownFieldColor: Colors.transparent,
                      decorationColor: CustomColor.textColor,
                    ),
                  )),
              addVerticalSpace(Dimensions.paddingVerticalSize * .3),
            ],
          ),
        );
      }
      else if (data[item].type.contains('file')) {
        totalFile++;
        hasFile.value = true;
        inputFileFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              CustomUploadFileWidget(
                labelText: data[item].label,
                hint: data[item].validation.mimes.join(","),
                onTap: (File value) {
                  updateImageData(data[item].name, value.path);
                },
              ),
            ],
          ),
        );
      }
      else if (data[item].type.contains('textarea')) {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              TextLabelsWidget(
                textLabels: data[item].label,
                textColor: CustomColor.textColor,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.5),
                child: InputTextField(
                  maxLine: 3,
                  controller: inputFieldControllers[item],
                  hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.enter) + " " + data[item].label,
                  borderColor: CustomColor.gray,
                  backgroundColor: Colors.transparent,
                  hintTextColor: CustomColor.textColor,
                ),
              ),
            ],
          ),
        );
      }
      else if (data[item].type == 'text') {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              TextLabelsWidget(
                textLabels: data[item].label,
                textColor: CustomColor.textColor,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.5),
                child: InputTextField(
                  controller: inputFieldControllers[item],
                  hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.enter) + " " + data[item].label,
                  borderColor: CustomColor.gray,
                  backgroundColor: Colors.transparent,
                  hintTextColor: CustomColor.textColor,
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  updateImageData(String fieldName, String imagePath) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      listImagePath[itemIndex] = imagePath;
    } else {
      listFieldName.add(fieldName);
      listImagePath.add(imagePath);
    }
    update();
  }

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late CommonSuccessModel _kycSubmitModel;
  CommonSuccessModel get kycSubmitModel => _kycSubmitModel;

  Future<CommonSuccessModel> kycSubmitProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, String> inputBody = {};

    final data = kycModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await kycSubmitProcessApi(
            body: inputBody, fieldList: listFieldName, pathList: listImagePath)
        .then((value) {
      _kycSubmitModel = value!;

      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();

      kycProcess();

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _kycSubmitModel;
  }
}

class IdTypeModel implements DropdownModel {
  final String id;
  final String name;

  IdTypeModel(this.id, this.name);

  @override
  String get title => name;

  @override
  String get img => throw UnimplementedError();
}
