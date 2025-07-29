import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/res/color_manager.dart';
import '../../config/res/constants_manager.dart';

extension TextStyleEx on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w900);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w300);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get s6 => copyWith(fontSize: 6.sp);
  TextStyle get s8 => copyWith(fontSize: 8.sp);
  TextStyle get s10 => copyWith(fontSize: 10.sp);
  TextStyle get s11 => copyWith(fontSize: 11.sp);
  TextStyle get s12 => copyWith(fontSize: 12.sp);
  TextStyle get s14 => copyWith(fontSize: 14.sp);
  TextStyle get s16 => copyWith(fontSize: 16.sp);
  TextStyle get s18 => copyWith(fontSize: 18.sp);
  TextStyle get s20 => copyWith(fontSize: 20.sp);
  TextStyle get s22 => copyWith(fontSize: 22.sp);
  TextStyle get s24 => copyWith(fontSize: 24.sp);
  TextStyle get s26 => copyWith(fontSize: 26.sp);
  TextStyle get s28 => copyWith(fontSize: 28.sp);
  TextStyle get s32 => copyWith(fontSize: 32.sp);
  TextStyle get s40 => copyWith(fontSize: 40.sp);
  TextStyle get s50 => copyWith(fontSize: 50.sp);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);

  TextStyle get ellipsis => copyWith(overflow: TextOverflow.ellipsis);

  TextStyle get setMainTextColor => copyWith(color: AppColors.primary);
  TextStyle get setPrimaryColor => copyWith(color: AppColors.primary);
  TextStyle get setSecondaryColor => copyWith(color: AppColors.secondary);
  TextStyle get setHintColor => copyWith(color: AppColors.hintText);
  TextStyle get setGreyTextColor => copyWith(color: AppColors.greyText);
  TextStyle get setBlackColor => copyWith(color: AppColors.black);
  TextStyle get setWhiteColor => copyWith(color: AppColors.white);
  TextStyle get setFontColor => copyWith(color: AppColors.font);
  TextStyle get setBgColor => copyWith(color: AppColors.bg);
  TextStyle get setBorderColor => copyWith(color: AppColors.border);

  TextStyle get setShade1Color => copyWith(color: AppColors.shade1);
  TextStyle get setShade2Color => copyWith(color: AppColors.shade2);
  TextStyle get setShade3Color => copyWith(color: AppColors.shade3);
  TextStyle get setShade4Color => copyWith(color: AppColors.shade4);
  TextStyle get setShade5Color => copyWith(color: AppColors.shade5);
  TextStyle get setShade6Color => copyWith(color: AppColors.shade6);
  TextStyle get setShade7Color => copyWith(color: AppColors.shade7);
  TextStyle get setDangerColor => copyWith(color: AppColors.danger);
  TextStyle get setWarningColor => copyWith(color: AppColors.warning);
  TextStyle get setSuccessColor => copyWith(color: AppColors.success);
  TextStyle get setInfoColor => copyWith(color: AppColors.info);

  TextStyle get setErrorColor => copyWith(color: AppColors.error);

  TextStyle setColor(Color color) => copyWith(color: color);
  TextStyle setFontSize(double size) => copyWith(fontSize: size);
  TextStyle setFontWeight(FontWeight weight) => copyWith(fontWeight: weight);

  TextStyle setHeight(double value) => copyWith(height: value);
  TextStyle setLetterSpacing(double value) => copyWith(letterSpacing: value);
  TextStyle setFontStyle(FontStyle style) => copyWith(fontStyle: style);
  TextStyle setDecoration(TextDecoration decoration) =>
      copyWith(decoration: decoration);
  TextStyle setDecorationColor(Color color) => copyWith(decorationColor: color);
  TextStyle setDecorationStyle(TextDecorationStyle style) =>
      copyWith(decorationStyle: style);
  TextStyle setWordSpacing(double value) => copyWith(wordSpacing: value);
  TextStyle setShadows(List<Shadow> shadows) => copyWith(shadows: shadows);
  TextStyle setForeground(Color color) =>
      copyWith(foreground: Paint()..color = color);
  TextStyle setBackground(Color color) =>
      copyWith(background: Paint()..color = color);
  TextStyle get setFontFamily =>
      copyWith(fontFamily: ConstantManager.fontFamily);
  TextStyle setPackage(String? package) => copyWith(package: package);
  TextStyle setHeightPercent(double value) => copyWith(height: value);

  // TextStyle setResponsiveFontSize({double? mobile, double? tablet, double? desktop}) {
  //   final context = Go.navigatorKey.currentContext!;
  //   return copyWith(fontSize: context.responsive(mobile: mobile, tablet: tablet, desktop: desktop));
  // }

  TextStyle get setH1 => copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w300,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setH1Medium => copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setH1SemiBold => copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setH1Bold => copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w900,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setH2 => copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setH2Medium => copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setH2SemiBold => copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setH2Bold => copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w900,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setTitle => copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setTitleMedium => copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setTitleSemiBold => copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setTitleBold => copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w900,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setBody => copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setBodyMedium => copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setBodySemiBold => copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        fontFamily: ConstantManager.fontFamily,
      );
  TextStyle get setBodyBold => copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w900,
        fontFamily: ConstantManager.fontFamily,
      );
}
