// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/res/color_manager.dart';
import 'text_fields/default_text_field.dart';

class AppDropdownIntValue extends StatelessWidget {
  final double? height;
  final List<DropdownMenuItem<int>>? items;
  final void Function(int?)? onChanged;
  final int? value;
  final String hint;
  final String? labelText;
  final double verticalPaddingFactory;
  final bool isExpanded, isEnabled;

  final FormFieldValidator<int?>? validator;

  const AppDropdownIntValue({
    this.height,
    this.items,
    this.onChanged,
    required this.value,
    required this.hint,
    this.labelText,
    this.isExpanded = true,
    this.isEnabled = true,
    this.verticalPaddingFactory = 0,
    super.key,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //     padding: _padding,
      // decoration: _decoration,
      child: _dropdownButton,
    );
  }

  EdgeInsetsGeometry get _padding => EdgeInsets.symmetric(
        horizontal: 16.w,
      );

  Decoration get _decoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        // border: Border.all(
        //   color: Colors.grey.withOpacity(0.2),
        // ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 3,
            color: AppColors.shadow,
            offset: Offset(0, 2),
          )
        ],
      );

  Widget get _dropdownButton => DropdownButtonFormField<int>(
        value: value,
        isExpanded: isExpanded,
        validator: validator,
        iconEnabledColor: Colors.black87,
        borderRadius: BorderRadius.circular(4.r),
        //underline: const SizedBox(),
        style: const TextStyle().medium.s8.setFontFamily,
        items: items,

        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.hintText,
        ),
        onChanged: isEnabled ? onChanged : null,
        // decoration: InputDecoration(
        //   filled: true,
        //   fillColor: Colors.white,
        //   labelText: 'Occupation',
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(5.0)),
        //     contentPadding: EdgeInsets.all(10),
        // ),
        decoration: InputDecoration(
          hintStyle: const TextStyle().setFontFamily.s10.setHintColor.medium,
          fillColor: AppColors.fieldColor,
          filled: true,
          enabledBorder: const CustomOutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: const CustomOutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          errorBorder: const CustomOutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const CustomOutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        hint: Text(
          hint,
          style: const TextStyle().setFontFamily.s10.setHintColor.medium,
        ),
      );
}

class AppDropdownStringValue extends StatelessWidget {
  final double? height;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String? value;
  final String hint;
  final String? labelText;
  final double verticalPaddingFactory;
  final bool isExpanded, isEnabled;
  final FormFieldValidator<String?>? validator;

  const AppDropdownStringValue({
    this.height,
    this.items,
    this.onChanged,
    required this.value,
    required this.hint,
    required this.validator,
    this.labelText,
    this.isExpanded = true,
    this.isEnabled = true,
    this.verticalPaddingFactory = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //     padding: _padding,
      // decoration: _decoration,
      child: _dropdownButton,
    );
  }

  EdgeInsetsGeometry get _padding => EdgeInsets.symmetric(
        horizontal: 16.w,
      );

  Decoration get _decoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        // border: Border.all(
        //   color: Colors.grey.withOpacity(0.2),
        // ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 3,
            color: AppColors.shadow,
            offset: Offset(0, 2),
          )
        ],
      );

  Widget get _dropdownButton => DropdownButtonFormField<String>(
        value: value,
        isExpanded: isExpanded,
        validator: validator,
        iconEnabledColor: Colors.black87,
        borderRadius: BorderRadius.circular(4.r),
        //underline: const SizedBox(),
        style: const TextStyle().medium.s8.setFontFamily,
        items: items,

        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.hintText,
        ),
        onChanged: isEnabled ? onChanged : null,
        // decoration: InputDecoration(
        //   filled: true,
        //   fillColor: Colors.white,
        //   labelText: 'Occupation',
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(5.0)),
        //     contentPadding: EdgeInsets.all(10),
        // ),
        decoration: InputDecoration(
          hintStyle: const TextStyle().setFontFamily.s10.setHintColor.medium,
          fillColor: AppColors.fieldColor,
          errorStyle: const TextStyle().medium.s12.setErrorColor.setFontFamily,
          filled: true,
          enabledBorder: const CustomOutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: const CustomOutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          errorBorder: const CustomOutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const CustomOutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),

        hint: Text(
          hint,
          style: const TextStyle().setFontFamily.s10.setHintColor.medium,
        ),
      );
}
