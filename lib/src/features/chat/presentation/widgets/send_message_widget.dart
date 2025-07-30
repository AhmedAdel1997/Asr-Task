import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_base/src/core/widgets/text_fields/default_text_field.dart';
import 'package:flutter_base/src/features/chat/presentation/widgets/send_record_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/color_manager.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/shared/enums.dart';
import '../../data/models/message_model.dart';
import '../cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({super.key});

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget>
    with WidgetsBindingObserver {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _messageController.addListener(() {
      setState(() {
        isFieldEmpty = _messageController.text.isEmpty;
      });

      // Trigger typing events
      if (_messageController.text.isNotEmpty) {
        context.read<GetChatMessagesCubit>().startTyping();
      } else {
        context.read<GetChatMessagesCubit>().stopTyping();
      }
    });

    // Add focus listener to handle typing when focus changes
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _messageController.text.isEmpty) {
        context.read<GetChatMessagesCubit>().stopTyping();
      }
    });

    // Ensure focus node is not focused initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.unfocus();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageController.dispose();
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Unfocus when app becomes inactive or paused
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _focusNode.unfocus();
    }
  }

  @override
  void didUpdateWidget(SendMessageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Ensure focus is removed when widget is updated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = context.watch<GetChatMessagesCubit>().state.isRecording;
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 105.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradient,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: isRecording
            ? const SendRecordWidget()
            : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Container(
                            // height: 200.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                16.szH,
                                ListTile(
                                  onTap: () {
                                    Go.back();
                                    context
                                        .read<GetChatMessagesCubit>()
                                        .sendPhotoMessage(
                                            source: ImageSource.camera);
                                  },
                                  leading: AppAssets.svg.camera.svg(
                                    height: 22.h,
                                    width: 22.w,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    'Camera',
                                    style: const TextStyle()
                                        .setTitleMedium
                                        .setFontColor,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Go.back();
                                    context
                                        .read<GetChatMessagesCubit>()
                                        .sendPhotoMessage(
                                            source: ImageSource.gallery);
                                  },
                                  leading: AppAssets.svg.uploadImage.svg(
                                    height: 22.h,
                                    width: 22.w,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    'Galley',
                                    style: const TextStyle()
                                        .setTitleMedium
                                        .setFontColor,
                                  ),
                                ),
                                16.szH,
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: AppAssets.images.camera.image(
                      height: 34.h,
                      width: 34.w,
                    ),
                  ),
                  8.szW,
                  Expanded(
                    child: DefaultTextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      hintText: 'write something...',
                      hintStyle: const TextStyle().setTitleMedium.copyWith(
                          color: AppColors.hintText.withValues(alpha: 0.4)),
                      action: TextInputAction.send,
                      autoFocus: false, // Explicitly disable auto focus
                      onSubmitted: (value) {
                        if (value != null && value.isNotEmpty) {
                          _sendMessage();
                        }
                      },
                      suffixIcon: isFieldEmpty
                          ? null
                          : IconButton(
                              onPressed: _sendMessage,
                              icon: const Icon(
                                Icons.send,
                                color: AppColors.secondary,
                              ),
                            ),
                    ),
                  ),
                  8.szW,
                  GestureDetector(
                    onTap: () {
                      context.read<GetChatMessagesCubit>().startRecording();
                    },
                    child: AppAssets.images.mic.image(
                      height: 34.h,
                      width: 34.w,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      context.read<GetChatMessagesCubit>().sendMessage(
            chatId: '1',
            message: MessageModel(
              message: _messageController.text,
              time: DateTime.now(),
              senderId: 2,
              senderName: 'Maria',
              type: MessageType.text,
              id: Random().nextInt(1000000),
              image: null,
              record: null,
              deletedAt: null,
            ),
          );

      _messageController.clear();
      _focusNode.unfocus();

      // Stop typing when message is sent
      context.read<GetChatMessagesCubit>().stopTyping();
    }
  }
}
