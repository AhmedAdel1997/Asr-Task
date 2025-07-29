import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/features/chat/presentation/cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/chage_chat_attributes_cubit/chage_chat_attributes_cubit.dart';
import 'message_bubble.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

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
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return MessageBubble(message: state.messages[index]);
                    },
                    separatorBuilder: (context, index) {
                      return 16.szH;
                    },
                    itemCount: state.messages.length,
                  ),
                ),
              ),
              100.szH
            ],
          ),
        );
      },
    );
  }
}
