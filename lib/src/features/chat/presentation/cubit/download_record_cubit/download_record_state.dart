part of 'download_record_cubit.dart';

final class DownloadRecordState extends Equatable {
  final BaseStatus status;

  final String path;
  final PlayerState playerState;

  const DownloadRecordState(
      {required this.status, required this.path, required this.playerState});

  factory DownloadRecordState.initial() => const DownloadRecordState(
      status: BaseStatus.initial, path: '', playerState: PlayerState.stopped);

  DownloadRecordState copyWith({
    BaseStatus? status,
    String? path,
    PlayerState? playerState,
  }) {
    return DownloadRecordState(
      status: status ?? this.status,
      path: path ?? this.path,
      playerState: playerState ?? this.playerState,
    );
  }

  @override
  List<Object> get props => [status, path, playerState];
}
