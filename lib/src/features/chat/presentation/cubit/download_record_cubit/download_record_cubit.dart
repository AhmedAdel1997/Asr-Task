import 'dart:developer';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import '../../../../../core/shared/base_state.dart';

part 'download_record_state.dart';

class DownloadRecordCubit extends Cubit<DownloadRecordState> {
  DownloadRecordCubit() : super(DownloadRecordState.initial());

  final PlayerController audioPlayer = PlayerController();

  Future<void> downloadRecord(String url) async {
    emit(state.copyWith(status: BaseStatus.loading));
    await FileDownloader.downloadFile(
      url: url,
      onDownloadCompleted: (path) async {
        log(path, name: 'PATH');
        await audioPlayer.preparePlayer(path: path);
        emit(state.copyWith(status: BaseStatus.success, path: path));
      },
    );
  }

  Future<void> playRecord() async {
    await audioPlayer.startPlayer();

    emit(state.copyWith(playerState: PlayerState.playing));
  }

  Future<void> pausePlayer() async {
    await audioPlayer.pausePlayer();
    emit(state.copyWith(playerState: PlayerState.paused));
  }
}
