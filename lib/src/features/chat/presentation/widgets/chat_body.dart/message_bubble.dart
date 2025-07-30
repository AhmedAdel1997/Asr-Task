import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/color_manager.dart';
import '../../../data/models/message_model.dart';
import '../../cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import 'deleted_message_bubble.dart';
import 'message_type_widget.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel message;
  const MessageBubble({super.key, required this.message});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin
    final isDeleted = widget.message.deletedAt != null;
    if (isDeleted) return DeletedMessageBubble(message: widget.message);
    return GestureDetector(
      onLongPress: () {
        if (widget.message.senderId == 2) return;
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;

        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            position.dx + size.width - 20.w,
            position.dy + size.height - 35.h,
            MediaQuery.of(context).size.width - (position.dx + size.width),
            MediaQuery.of(context).size.height - (position.dy + size.height),
          ),
          items: [
            PopupMenuItem(
              onTap: () {
                context.read<GetChatMessagesCubit>().deleteMessage(
                      chatId: '1',
                      messageId: widget.message.documentId ?? '',
                    );
              },
              height: 40.h,
              child: Row(
                children: [
                  Text('Delete Message',
                      style: const TextStyle().setH2Medium.setBlackColor),
                  12.szW,
                  Icon(Icons.delete, color: AppColors.error, size: 24.r),
                ],
              ),
            ),
          ],
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: widget.message.senderId == 1
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: widget.message.senderId == 1
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (widget.message.senderId == 2) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000.r),
                  child: AppAssets.images.secondUser.image(
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.fill,
                  ),
                ),
                12.szW,
              ],
              Column(
                crossAxisAlignment: widget.message.senderId == 2
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.message.senderId == 2) ...[
                        Text(
                          widget.message.senderName,
                          style: const TextStyle().setH2Medium.setWhiteColor,
                        ),
                        8.szH,
                      ],
                      MessageTypeWidget(message: widget.message),
                    ],
                  ),
                  8.szH,
                  Text(
                    DateFormat('HH:mm a').format(widget.message.time),
                    style: const TextStyle().setTitleMedium.setWhiteColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
