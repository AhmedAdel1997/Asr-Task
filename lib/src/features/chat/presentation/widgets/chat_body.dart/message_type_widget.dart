import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_base/src/core/widgets/image_viewer.dart';
import 'package:flutter_base/src/features/chat/data/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/res/color_manager.dart';
import '../../../../../core/shared/enums.dart';
import '../../cubit/chage_chat_attributes_cubit/chage_chat_attributes_cubit.dart';
import '../view_record_widget.dart';

class MessageTypeWidget extends StatelessWidget {
  final MessageModel message;
  const MessageTypeWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        return BlocBuilder<ChageChatAttributesCubit, ChageChatAttributesState>(
          builder: (context, state) {
            return CustomDecoratedContainer(
              message: message,
              child: Text(
                message.message,
                style: const TextStyle().setH2Medium.copyWith(
                      color: message.senderId == 2
                          ? AppColors.white
                          : const Color(0xff0D082C),
                    ),
              ),
            );
          },
        );
      case MessageType.image:
        if (message.image == null) {
          return const SizedBox();
        }
        return CustomDecoratedContainer(
          message: message,
          padding: EdgeInsets.all(2.w),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight:
                  message.senderId == 2 ? Radius.zero : Radius.circular(16.r),
              topLeft:
                  message.senderId == 2 ? Radius.circular(16.r) : Radius.zero,
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            child: ImageViewer(
              imageUrl: message.image!,
              width: 320.w,
              fit: BoxFit.cover,
              height: 320.h,
            ),
          ),
        );
      case MessageType.record:
        return ViewRecordWidget(message: message);
    }
  }
}

class CustomDecoratedContainer extends StatelessWidget {
  final MessageModel message;

  final Widget child;
  final EdgeInsets? padding;

  const CustomDecoratedContainer({
    super.key,
    required this.message,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChageChatAttributesCubit, ChageChatAttributesState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: message.senderId == 2
                ? state.selectedColor
                : const Color(0xffE8ECF1),
            borderRadius: BorderRadius.only(
              topRight:
                  message.senderId == 2 ? Radius.zero : Radius.circular(16.r),
              topLeft:
                  message.senderId == 2 ? Radius.circular(16.r) : Radius.zero,
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          constraints: BoxConstraints(
            maxWidth: 320.w,
            minWidth: 100.w,
          ),
          // width: 320.w,
          child: child,
        );
      },
    );
  }
}
