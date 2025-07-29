import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/src/config/language/locale_keys.g.dart';
import 'package:flutter_base/src/config/res/constants_manager.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_base/src/core/helpers/validators.dart';
import 'package:flutter_base/src/core/widgets/custom_widget_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../config/res/color_manager.dart';

class CustomPinTextField extends StatelessWidget {
  final ValueChanged<String>? onCompleted;
  final TextEditingController controller;
  const CustomPinTextField(
      {super.key, required this.controller, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.border),
      ),
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary),
      color: AppColors.white,
    );
    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.error),
    );
    return CustomWidgetValidator(
        validator: Validators.validateEmpty,
        builder: (state) {
          return Pinput(
            length: ConstantManager.pinCodeFieldsCount,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            forceErrorState: state.hasError,
            validator: (value) => Validators.validateEmpty(value,
                message: LocaleKeys.emptyOtpRequired),
            errorTextStyle: const TextStyle().setTitleSemiBold.setErrorColor,
            autofocus: true,
            onChanged: (value) {
              state.didChange(value);
            },
            separatorBuilder: (index) => 20.szW,
            focusedPinTheme: focusedPinTheme,
            defaultPinTheme: defaultPinTheme,
            errorPinTheme: errorPinTheme,
            onCompleted: onCompleted,
            controller: controller,
          );
        });
  }
}
