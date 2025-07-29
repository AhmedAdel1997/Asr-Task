import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../config/res/assets.gen.dart';
import '../cubit/chage_chat_attributes_cubit/chage_chat_attributes_cubit.dart';

class RecordLoadingWidget extends StatelessWidget {
  const RecordLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        context.watch<ChageChatAttributesCubit>().state.selectedColor;
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        duration: Duration(seconds: 1),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 320.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: selectedColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.zero,
              topLeft: Radius.circular(16.r),
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000.r),
                    child: AppAssets.images.formalPhotoCropped.image(
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  AppAssets.images.record.image(),
                ],
              ),
              16.szW,
              Expanded(
                child: AppAssets.svg.wave.svg(),
              ),
              16.szW,
            ],
          ),
        ),
      ),
    );
  }
}
