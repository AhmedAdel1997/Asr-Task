import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/res/assets.gen.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/shared/base_state.dart';

part 'chage_chat_attributes_state.dart';

class ChageChatAttributesCubit extends Cubit<ChageChatAttributesState> {
  ChageChatAttributesCubit() : super(ChageChatAttributesState.initial());

  void changeBackground(AssetGenImage background) {
    Go.back();
    emit(state.copyWith(
      selectedBackground: background,
    ));
  }

  void changeColor(Color color) {
    Go.back();
    emit(state.copyWith(selectedColor: color));
  }
}
