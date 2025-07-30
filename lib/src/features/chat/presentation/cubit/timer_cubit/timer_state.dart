part of 'timer_cubit.dart';

final class TimerState extends Equatable {
  final BaseStatus status;
  final int elapsedSeconds;

  const TimerState({required this.status, required this.elapsedSeconds});

  factory TimerState.initial() =>
      const TimerState(status: BaseStatus.loading, elapsedSeconds: 0);

  TimerState copyWith({BaseStatus? status, int? elapsedSeconds}) {
    return TimerState(
      status: status ?? this.status,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    );
  }

  @override
  List<Object> get props => [status, elapsedSeconds];
}
