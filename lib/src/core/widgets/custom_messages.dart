import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/app_sizes.dart';
import 'package:flutter_base/src/config/res/assets.gen.dart';
import 'package:flutter_base/src/config/res/constants_manager.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/res/color_manager.dart';
import '../navigation/navigator.dart';

class MessageUtils {
  static void showSnackBar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    BuildContext? context,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: ConstantManager.snackbarDuration),
      content: Text(
        message,
        style: TextStyle(
                color: textColor ?? AppColors.white, fontSize: FontSize.s14)
            .setFontFamily,
      ),
      backgroundColor: backgroundColor ?? AppColors.primary,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context ?? Go.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  static void showErrorSnackBar(
    String message, {
    BuildContext? context,
    SnackBarAction? action,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: ConstantManager.snackbarDuration),
      content: Text(
        message,
        style: const TextStyle().setFontFamily.setWhiteColor.s14.bold,
      ),
      backgroundColor: AppColors.error,
      behavior: SnackBarBehavior.floating,
      action: action,
    );
    ScaffoldMessenger.of(context ?? Go.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  static void showSuccessSnackBar(
    String message, {
    BuildContext? context,
    SnackBarAction? action,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: ConstantManager.snackbarDuration),
      content: Text(
        message,
        style: const TextStyle().setFontFamily.setWhiteColor.s14.bold,
      ),
      backgroundColor: AppColors.success,
      behavior: SnackBarBehavior.floating,
      action: action,
    );
    ScaffoldMessenger.of(context ?? Go.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  static void showSimpleToast({
    required String msg,
    Color? color,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color ?? AppColors.primary,
      textColor: textColor ?? AppColors.white,
      fontSize: FontSize.s16,
    );
  }

  static Future<void> showSuccessBottomSheet(
    String message, {
    String? description,
  }) async {
    final context = Go.navigatorKey.currentContext!;

    await showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => Container(
        // height: 190.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAssets.svg.success.svg(),
            16.szH,
            Text(
              message,
              style: const TextStyle().setH2Medium.setFontColor,
            ),
            if (description != null) ...[
              8.szH,
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle().setTitle.setShade2Color,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
