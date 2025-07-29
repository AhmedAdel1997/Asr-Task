import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/config/res/assets.gen.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/message_model.dart';

class DeletedMessageBubble extends StatelessWidget {
  final MessageModel message;
  const DeletedMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.senderId == 1 ? Alignment.centerRight : Alignment.centerLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff5F5F5F),
            borderRadius: BorderRadius.only(
              topRight:
                  message.senderId == 1 ? Radius.zero : Radius.circular(16.r),
              topLeft:
                  message.senderId == 1 ? Radius.circular(16.r) : Radius.zero,
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          constraints: BoxConstraints(
            maxWidth: 320.w,
            minWidth: 160.w,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAssets.images.deleted.image(),
              8.szW,
              Expanded(
                child: Text(
                  message.senderId == 1
                      ? 'You deleted this message'
                      : '${message.senderName} deleted this message',
                  maxLines: 1,
                  style: const TextStyle().setH2Medium.setWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
