import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/color_manager.dart';
import '../../../../core/navigation/navigator.dart';

class ViewImageScreen extends StatelessWidget {
  final File image;
  const ViewImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 64.h,
        title: Text(
          'View Image',
          style: const TextStyle().setH1SemiBold,
        ),
        leading: IconButton(
          onPressed: () {
            Go.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.gradient,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.file(image),
              ),
              20.szH,
              GestureDetector(
                onTap: () {
                  Go.back(true);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AppAssets.images.button.image(
                      height: 38.h,
                      width: 145.w,
                    ),
                    Text(
                      'Send',
                      style: const TextStyle().setH2SemiBold.setWhiteColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
