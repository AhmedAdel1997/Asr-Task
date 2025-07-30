import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/color_manager.dart';
import '../../../../config/res/constants_manager.dart';
import '../../../../core/shared/base_state.dart';
import '../../data/models/message_model.dart';
import '../cubit/chage_chat_attributes_cubit/chage_chat_attributes_cubit.dart';
import '../cubit/download_record_cubit/download_record_cubit.dart';

class ViewRecordWidget extends StatefulWidget {
  final MessageModel message;
  const ViewRecordWidget({super.key, required this.message});

  @override
  State<ViewRecordWidget> createState() => _ViewRecordWidgetState();
}

class _ViewRecordWidgetState extends State<ViewRecordWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => sl<DownloadRecordCubit>(),
      child: ViewRecord(widget: widget),
    );
  }
}

class ViewRecord extends StatelessWidget {
  const ViewRecord({
    super.key,
    required this.widget,
  });

  final ViewRecordWidget widget;

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        context.watch<ChageChatAttributesCubit>().state.selectedColor;
    return BlocBuilder<DownloadRecordCubit, DownloadRecordState>(
      builder: (context, downloadRecordState) {
        return Container(
          decoration: BoxDecoration(
            color: widget.message.senderId == 1
                ? selectedColor
                : const Color(0xffE8ECF1),
            borderRadius: BorderRadius.only(
              topRight: widget.message.senderId == 1
                  ? Radius.zero
                  : Radius.circular(16.r),
              topLeft: widget.message.senderId == 1
                  ? Radius.circular(16.r)
                  : Radius.zero,
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          width: 320.w,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000.r),
                    child: widget.message.senderId == 1
                        ? AppAssets.images.formalPhotoCropped.image(
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.fill,
                          )
                        : AppAssets.images.secondUser.image(
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.fill,
                          ),
                  ),
                  AppAssets.images.record.image(),
                ],
              ),
              4.szW,
              if (downloadRecordState.status == BaseStatus.initial) ...[
                8.szW,
                GestureDetector(
                  onTap: () async {
                    await context.read<DownloadRecordCubit>().downloadRecord(
                          widget.message.record!,
                        );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 28.w,
                        height: 28.h,
                        child: Icon(
                          Icons.download,
                          color: widget.message.senderId == 1
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                      4.szW,
                      AppAssets.svg.wave.svg(
                        width: 200.w,
                        colorFilter: ColorFilter.mode(
                          widget.message.senderId == 1
                              ? AppColors.white
                              : AppColors.black,
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  ),
                ),
              ],
              if (downloadRecordState.status == BaseStatus.loading) ...[
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: CircularProgressIndicator(
                    color: widget.message.senderId == 1
                        ? AppColors.white
                        : AppColors.black,
                  ),
                ),
              ],
              if (downloadRecordState.status == BaseStatus.success) ...[
                IconButton(
                  onPressed: () async {
                    if (downloadRecordState.playerState ==
                        PlayerState.playing) {
                      await context.read<DownloadRecordCubit>().pausePlayer();
                      return;
                    }
                    if (downloadRecordState.playerState == PlayerState.paused) {
                      await context.read<DownloadRecordCubit>().playRecord();
                      return;
                    }

                    if (downloadRecordState.playerState ==
                        PlayerState.stopped) {
                      // Record is already prepared, just play it
                      await context.read<DownloadRecordCubit>().playRecord(
                            isStopped: true,
                          );
                      return;
                    }
                  },
                  iconSize: 30,
                  icon: downloadRecordState.playerState == PlayerState.playing
                      ? Icon(
                          Icons.pause,
                          color: widget.message.senderId == 1
                              ? AppColors.white
                              : AppColors.black,
                        )
                      : Icon(
                          Icons.play_arrow,
                          color: widget.message.senderId == 1
                              ? AppColors.white
                              : AppColors.black,
                        ),
                ),
                4.szW,
                Expanded(
                  child: AudioFileWaveforms(
                    size: Size(400.w, 16.h),
                    waveformType: WaveformType.fitWidth,
                    playerWaveStyle: PlayerWaveStyle(
                      liveWaveColor: widget.message.senderId == 1
                          ? AppColors.black
                          : AppColors.grey,
                      fixedWaveColor: widget.message.senderId == 1
                          ? AppColors.white
                          : AppColors.grey.withValues(alpha: 0.3),
                    ),
                    playerController:
                        context.read<DownloadRecordCubit>().audioPlayer,
                  ),
                )
              ],
            ],
          ),
        );
      },
    );
  }
}
