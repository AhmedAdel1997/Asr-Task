import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/assets.gen.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_base/src/core/widgets/custom_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/language/locale_keys.g.dart';
import '../../config/res/color_manager.dart';
import '../navigation/navigator.dart';

Future<void> showAreYouSureDialog({
  required BuildContext context,
  required String title,
  required String buttonText,
  required Future Function() function,
  required String description,
  required SvgGenImage image,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return AreYouSureDialog(
        context: context,
        title: title,
        function: function,
        description: description,
        image: image,
        buttonText: buttonText,
      );
    },
  );
}

class AreYouSureDialog extends StatefulWidget {
  final String title;
  final String buttonText;
  final String description;
  final Function() function;
  final BuildContext context;
  final SvgGenImage image;
  const AreYouSureDialog({
    super.key,
    required this.title,
    required this.buttonText,
    required this.description,
    required this.function,
    required this.context,
    required this.image,
  });

  @override
  State<AreYouSureDialog> createState() => _AreYouSureDialogState();
}

class _AreYouSureDialogState extends State<AreYouSureDialog> {
  bool _isLoading = false;
  toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.h,
            width: 65.w,
            decoration: BoxDecoration(
              color: AppColors.shade6,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          24.szH,
          widget.image.svg(
            height: 48.h,
            width: 48.w,
          ),
          16.szH,
          Text(
            widget.title,
            style: const TextStyle().setH1Medium.setFontColor,
          ),
          8.szH,
          Text(
            widget.description,
            style: const TextStyle().setH1Medium.setShade2Color,
          ),
          24.szH,
          _isLoading
              ? CustomLoading.showLoadingView()
              : Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Go.back();
                      },
                      child: Container(
                        height: 56.h,
                        width: 185.w,
                        decoration: BoxDecoration(
                          color: AppColors.shade6,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.cancel,
                            style: const TextStyle().setH2Medium.setShade2Color,
                          ),
                        ),
                      ),
                    ),
                    8.szW,
                    GestureDetector(
                      onTap: () async {
                        toggleLoading();
                        await widget.function();
                        toggleLoading();
                      },
                      child: Container(
                        height: 56.h,
                        width: 185.w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.danger),
                        ),
                        child: Center(
                          child: Text(
                            widget.buttonText,
                            style: const TextStyle().setH2Medium.setDangerColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          16.szH,
        ],
      ),
    );
  }
}
