import 'dart:developer';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/assets.gen.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/res/color_manager.dart';
import '../cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';

class SendRecordWidget extends StatefulWidget {
  const SendRecordWidget({super.key});

  @override
  State<SendRecordWidget> createState() => _SendRecordWidgetState();
}

class _SendRecordWidgetState extends State<SendRecordWidget> {
  String? recordedFilePath;
  bool isRecording = false;
  final RecorderController recorderController = RecorderController();

  @override
  void initState() {
    super.initState();
    recorderController.checkPermission();
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isRecording
            ? AudioWaveforms(
                recorderController: recorderController,
                waveStyle: const WaveStyle(
                  extendWaveform: true,
                  waveColor: AppColors.white,
                  durationLinesColor: AppColors.white,
                  middleLineColor: Colors.transparent,
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                size: Size(300.w, 20.h),
              )
            : AppAssets.svg.wave.svg(),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                setState(() {
                  isRecording = false;
                });
                context.read<GetChatMessagesCubit>().stopRecording();
                if (recorderController.isRecording) {
                  recordedFilePath = await recorderController.stop();
                }
              },
              child: AppAssets.svg.delete.svg(),
            ),
            Expanded(
              child: Text(
                '00:00',
                textAlign: TextAlign.center,
                style: const TextStyle().setH2SemiBold.copyWith(
                      color: AppColors.white,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (recorderController.hasPermission) {
                  if (recorderController.isRecording) {
                    recordedFilePath = await recorderController.stop();
                    log(recordedFilePath.toString(), name: 'recordedFilePath');
                    if (context.mounted) {
                      context.read<GetChatMessagesCubit>().stopRecording();
                      context
                          .read<GetChatMessagesCubit>()
                          .sendRecordMessage(path: recordedFilePath!);
                    }
                    return;
                  }
                  setState(() {
                    isRecording = true;
                  });
                  await recorderController.record(path: recordedFilePath);
                }
              },
              child: AppAssets.svg.sendRecord.svg(),
            ),
          ],
        ),
      ],
    );
  }
}
