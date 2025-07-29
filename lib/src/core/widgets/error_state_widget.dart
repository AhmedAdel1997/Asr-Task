import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/color_manager.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final Function() onTap;
  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle().bold.s18.setBlackColor.setFontFamily,
            ),
            IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.replay,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
