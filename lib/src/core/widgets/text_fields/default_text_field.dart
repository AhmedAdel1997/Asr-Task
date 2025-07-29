import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/src/config/res/constants_manager.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/res/color_manager.dart';

class DefaultTextField extends StatefulWidget {
  final String? hintText;
  final bool secure;
  final TextInputType inputType;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final String? label;
  final String? initialValue;
  final Function(String?)? onSubmitted;
  final Color? fillColor;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool filled;
  final int? maxLength;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final GestureTapCallback? onTap;
  final String? suffixText;
  final TextInputAction action;
  final bool autoFocus;
  final FocusNode? focusNode;
  final Widget? prefixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final bool? isPassword;
  final int? maxLines;
  final bool? hasBorderColor;
  final Color? borderColor;
  final void Function(String?)? onChanged;
  final bool closeWhenTapOutSide;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final BoxConstraints? suffixConstraints;

  const DefaultTextField({
    super.key,
    this.hintText,
    this.initialValue,
    this.secure = false,
    this.inputType = TextInputType.text,
    this.borderColor,
    this.onTap,
    this.controller,
    this.contentPadding,
    this.closeWhenTapOutSide = true,
    this.hasBorderColor = true,
    this.validator,
    this.label,
    this.onSubmitted,
    this.isPassword = false,
    this.fillColor,
    this.inputFormatters,
    this.prefixIcon,
    this.prefixWidget,
    this.maxLength,
    this.filled = true,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.action = TextInputAction.next,
    this.focusNode,
    this.autoFocus = false,
    this.suffixText,
    this.suffixIcon,
    this.maxLines,
    this.onChanged,
    this.style,
    this.hintStyle,
    this.suffixConstraints,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late bool _isSecure;

  @override
  void initState() {
    if (widget.isPassword != null) {
      _isSecure = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLabel = widget.label != null;
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.isPassword == true ? _isSecure : widget.secure,
      onTap: widget.onTap,
      onTapOutside: (event) {
        if (widget.closeWhenTapOutSide == true) {
          FocusScope.of(context).unfocus();
        }
      },
      keyboardType: widget.inputType,
      autofillHints: _getAutoFillHints(widget.inputType),
      validator: widget.validator,
      maxLength: widget.maxLength,
      readOnly: widget.onTap != null ? true : widget.readOnly,
      textAlign: widget.textAlign!,
      maxLines: widget.inputType == TextInputType.multiline
          ? widget.maxLines ?? 7
          : 1,
      style: widget.style,
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: widget.action,
      enableSuggestions: false,
      autocorrect: false,
      autofocus: widget.autoFocus,
      focusNode: widget.autoFocus == true ? widget.focusNode : null,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        isDense: true,
        errorMaxLines: 2,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        counterText: ConstantManager.emptyText,
        filled: widget.filled,
        suffixText: widget.suffixText,
        prefixIcon:
            // widget.isPassword == true
            //     ? const Icon(Icons.lock_outline, color: AppColors.hintText)
            //     :
            widget.prefixIcon,
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isSecure = !_isSecure;
                  });
                },
                icon: Icon(
                  _isSecure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.hintText,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: widget.suffixIcon,
              ),
        prefix: widget.prefixWidget,
        fillColor: widget.fillColor ?? Colors.white,
        hintText: widget.hintText,
        label: isLabel ? Text(widget.label!) : null,
        errorStyle: const TextStyle().setTitleSemiBold.setErrorColor,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: const TextStyle().setBodySemiBold.setBlackColor,
        // prefixIconConstraints: widget.suffixConstraints ??
        //     BoxConstraints(maxWidth: 50.w, minHeight: 12.h, minWidth: 24.w),
        suffixIconConstraints: widget.suffixConstraints ??
            BoxConstraints(maxWidth: 50.w, minHeight: 12.h, minWidth: 24.w),
        hintStyle:
            widget.hintStyle ?? const TextStyle().setTitleMedium.setHintColor,
        enabledBorder: CustomOutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? AppColors.border),
        ),
        focusedBorder: CustomOutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? AppColors.border),
        ),
        errorBorder: CustomOutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? Colors.red),
        ),
        focusedErrorBorder: CustomOutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? Colors.red),
        ),
      ),
    );
  }
}

List<String> _getAutoFillHints(TextInputType inputType) {
  if (inputType == TextInputType.emailAddress) {
    return [AutofillHints.email];
  } else if (inputType == TextInputType.datetime) {
    return [AutofillHints.birthday];
  } else if (inputType == TextInputType.phone) {
    return [AutofillHints.telephoneNumber];
  } else if (inputType == TextInputType.url) {
    return [AutofillHints.url];
  }
  return [AutofillHints.name, AutofillHints.username];
}

class CustomOutlineInputBorder extends UnderlineInputBorder {
  const CustomOutlineInputBorder({
    super.borderSide,
    super.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0),
    ),
  });

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final Paint paint = borderSide.toPaint();
    final RRect outer = borderRadius.toRRect(rect);
    final RRect center = outer.deflate(borderSide.width / 2.0);
    canvas.drawRRect(center, paint);
  }
}
