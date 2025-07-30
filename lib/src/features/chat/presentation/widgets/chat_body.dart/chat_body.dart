import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/features/chat/presentation/cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared/base_state.dart';
import '../../cubit/chage_chat_attributes_cubit/chage_chat_attributes_cubit.dart';
import '../image_loading_widget.dart';
import '../record_loading_widget.dart';
import '../typing_widget.dart';
import 'message_bubble.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    final selectedBackground =
        context.watch<ChageChatAttributesCubit>().state.selectedBackground;
    return BlocBuilder<GetChatMessagesCubit, GetChatMessagesState>(
      builder: (context, state) {
        log(state.messages.toString());
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(selectedBackground.path),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    reverse: true,
                    controller:
                        context.read<GetChatMessagesCubit>().scrollController,
                    itemBuilder: (context, index) {
                      return MessageBubble(message: state.messages[index]);
                    },
                    separatorBuilder: (context, index) {
                      return 16.szH;
                    },
                    itemCount: state.messages.length,
                  ),
                ),
                if (state.uploadImageStatus == BaseStatus.loading) ...[
                  10.szH,
                  const ImageLoadingWidget(),
                ],
                if (state.uploadRecordStatus == BaseStatus.loading) ...[
                  10.szH,
                  const RecordLoadingWidget(),
                ],
                // Show typing indicators for other users
                ...state.typingUsers.values.map((userData) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: const TypingWidget(),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
