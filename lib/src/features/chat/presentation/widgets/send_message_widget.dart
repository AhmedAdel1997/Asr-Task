import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_base/src/core/widgets/text_fields/default_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/color_manager.dart';
import '../../../../core/shared/enums.dart';
import '../../data/models/message_model.dart';
import '../cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({super.key});

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController _messageController = TextEditingController();
  bool isFieldEmpty = true;
  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        isFieldEmpty = _messageController.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 105.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradient,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          AppAssets.images.camera.image(
            height: 34.h,
            width: 34.w,
          ),
          8.szW,
          Expanded(
            child: DefaultTextField(
              controller: _messageController,
              hintText: 'write something...',
              hintStyle: const TextStyle()
                  .setTitleMedium
                  .copyWith(color: AppColors.hintText.withValues(alpha: 0.4)),
              suffixIcon: isFieldEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        context.read<GetChatMessagesCubit>().sendMessage(
                              chatId: '1',
                              message: MessageModel(
                                message: _messageController.text,
                                time: DateTime.now(),
                                senderId: 1,
                                senderName: 'Ahmed Adel',
                                type: MessageType.text,
                                id: Random().nextInt(1000000),
                                image: null,
                                record: null,
                                deletedAt: null,
                              ),
                            );

                        _messageController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.secondary,
                      ),
                    ),
            ),
          ),
          8.szW,
          AppAssets.images.mic.image(
            height: 34.h,
            width: 34.w,
          ),
        ],
      ),
    );
  }
}
