import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/assets.gen.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/res/color_manager.dart';
import '../cubit/chage_chat_attributes_cubit/chage_chat_attributes_cubit.dart';

class ChangeBackgroundWidget extends StatelessWidget {
  const ChangeBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChageChatAttributesCubit, ChageChatAttributesState>(
      builder: (context, state) {
        return Stack(
          children: [
            AppAssets.images.backgroundBg.image(
              width: double.infinity,
              height: double.infinity,
            ),
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              itemCount: state.backgroundList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 180.w / 210.h,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      state.backgroundList[index].image(
                        width: 130.w,
                        height: 125.h,
                      ),
                      16.szH,
                      GestureDetector(
                        onTap: () {
                          context
                              .read<ChageChatAttributesCubit>()
                              .changeBackground(state.backgroundList[index]);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppAssets.images.button.image(
                              height: 38.h,
                              width: 145.w,
                            ),
                            Text(
                              'Change',
                              style:
                                  const TextStyle().setH2SemiBold.setWhiteColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
