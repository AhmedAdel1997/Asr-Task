import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared/base_state.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  Timer? timer;
  TimerCubit() : super(TimerState.initial());

  void startTimer() {
    if (timer != null) {
      timer?.cancel();
    }
    emit(state.copyWith(status: BaseStatus.loading, elapsedSeconds: 0));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(elapsedSeconds: state.elapsedSeconds + 1));
    });
  }

  void stopTimer() {
    timer?.cancel();
    emit(state.copyWith(status: BaseStatus.success, elapsedSeconds: 0));
  }

  String getTimerText() {
    final minutes = state.elapsedSeconds ~/ 60;
    final seconds = state.elapsedSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
