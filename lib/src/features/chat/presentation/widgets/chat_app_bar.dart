import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_base/src/core/widgets/are_you_sure_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/color_manager.dart';
import '../../../../core/navigation/navigator.dart';
import '../cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import '../pages/call_screen.dart';
import '../pages/change_background_screen.dart';
import '../pages/change_color_screen.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 64.h,
      leadingWidth: 210.w,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000.r),
              child: AppAssets.images.formalPhotoCropped.image(
                width: 40.w,
                height: 40.h,
                fit: BoxFit.fill,
              ),
            ),
            8.szW,
            Text(
              'Ahmed Adel',
              style: const TextStyle().setH1SemiBold,
            ),
            // 16.szW,
          ],
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Go.to(const CallScreen());
          },
          child: AppAssets.images.call.image(
            height: 27.h,
            width: 27.w,
          ),
        ),
        16.szW,
        PopupMenuButton(
          offset: Offset(0, 20.h),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                onTap: () {
                  Go.to(const ChangeBackgroundScreen());
                },
                height: 50.h,
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        'Change Background',
                        style: const TextStyle().setH2Medium.setBlackColor,
                      ),
                    ),
                    16.szH,
                    AppAssets.images.border.image(width: 180.w),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Go.to(const ChangeColorScreen());
                },
                height: 50.h,
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        'Change Chat Box',
                        style: const TextStyle().setH2Medium.setBlackColor,
                      ),
                    ),
                    16.szH,
                    AppAssets.images.border.image(width: 180.w),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  showAreYouSureDialog(
                    context: context,
                    title: 'Delete Chat',
                    buttonText: 'Delete',
                    function: () async {
                      await context.read<GetChatMessagesCubit>().deleteChat();
                      Go.back();
                    },
                    description: 'Are you sure you want to delete this chat ?',
                    image: AppAssets.svg.deleteDialog,
                  );
                },
                height: 40.h,
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        'Delete Chat',
                        style: const TextStyle().setH2Medium.setBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: AppAssets.images.menu.image(
            height: 27.h,
            width: 27.w,
          ),
        ),
        16.szW,
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradient,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64.h);
}
