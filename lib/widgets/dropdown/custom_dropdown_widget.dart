import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walletium/widgets/labels/primary_text_widget.dart';

import '../../../utils/custom_color.dart';
import '../../../utils/size.dart';
import '../../utils/dimsensions.dart';

abstract class DropdownModel {
  String get title;
  String get img;
}

class CustomDropDown<T extends DropdownModel> extends StatefulWidget {
  final String hint;
  final String title;
  final T? selectedValue;
  final Color? decorationColor;
  final Color? dropDownFieldColor;
  final List<T> items;
  final void Function(T?) onChanged;
  final BoxBorder? border;
  final double? fieldBorderRadius;
  final Color? titleTextColor;
  final Color? selectedTextColor;
  final Color? hintTextColor;
  final bool isExpanded;
  final bool borderEnable;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleStyle;
  final BorderRadiusGeometry? customBorderRadius;
  const CustomDropDown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.border,
      this.fieldBorderRadius,
      this.titleTextColor,
      this.selectedTextColor,
      this.hintTextColor,
      this.isExpanded = true,
      this.padding,
      this.margin,
      this.titleStyle,
      this.decorationColor,
      required this.hint,
      this.borderEnable = true,
      this.title = '',
      this.customBorderRadius,
      this.selectedValue,
      this.dropDownFieldColor});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T extends DropdownModel>
    extends State<CustomDropDown<T>> {
  // T? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return widget.title != ''
        ? Visibility(
            visible: widget.title != '',
            child: Column(
              crossAxisAlignment: crossStart,
              mainAxisSize: mainMin,
              children: [
                PrimaryTextWidget(
                  text: widget.title,
                  fontWeight: FontWeight.w500,
                ).paddingOnly(bottom: Dimensions.paddingVerticalSize),
                _dropDown()
              ],
            ))
        : _dropDown();
  }

  _dropDown() {
    return Container(
      height: Dimensions.buttonHeight * 0.9,
      // margin: widget.margin,
      // padding: EdgeInsets.symmetric(
      //   horizontal: Dimensions.paddingHorizontalSize * .6
      // ),
      decoration: BoxDecoration(
        color: widget.dropDownFieldColor ?? Colors.transparent,
        border: widget.borderEnable
            ? widget.border ??
                Border.all(
                  color: widget.decorationColor?.withOpacity(0.2) ??
                      (widget.selectedValue != null
                          ? Theme.of(context).primaryColor
                          : CustomColor.whiteColor.withOpacity(0.15)),
                  width: 2
                )
            : null,
        borderRadius: widget.customBorderRadius ??
            BorderRadius.circular(
              widget.fieldBorderRadius ?? Dimensions.radius,
            ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200.h,
            decoration: BoxDecoration(
              color: CustomColor.primaryColor
            )
          ),
          hint: Text(
            widget.selectedValue!.title,
            style: TextStyle(
              color: widget.hintTextColor ?? widget.selectedTextColor,
              fontSize: Dimensions.defaultTextSize * .7,
              fontWeight: FontWeight.w500,
            ),
          ),
          // value: widget.selectedValue,
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingHorizontalSize * .6
              ),
              child: Icon(Icons.arrow_drop_down),
            ),
              iconEnabledColor:
                  (widget.decorationColor ?? CustomColor.whiteColor)
                      .withOpacity(1),
              iconDisabledColor:
                  (widget.decorationColor ?? CustomColor.whiteColor)
                      .withOpacity(0.4)),
          style: TextStyle(
            color: widget.hintTextColor ?? widget.selectedTextColor,
            fontSize: Dimensions.defaultTextSize * .7,
            fontWeight: FontWeight.w500,
          ),
          isExpanded: widget.isExpanded,
          underline: Container(),
          onChanged: (T? newValue) {
            setState(() {
              // _selectedItem = newValue;
              widget.onChanged(newValue);
            });
          },
          items: widget.items.map<DropdownMenuItem<T>>(
            (T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.title,
                  style: TextStyle(
                    color: widget.selectedTextColor
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
