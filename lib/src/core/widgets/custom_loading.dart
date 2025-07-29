import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/app_sizes.dart';
import 'package:flutter_base/src/core/helpers/loading_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/res/color_manager.dart';

class CustomLoading {
  static showLoadingView() {
    return Center(
      child: SpinKitDoubleBounce(
        color: AppColors.primary,
        size: AppSize.sH40,
      ),
    );
  }

  static showFullScreenLoading() {
    FullScreenLoadingManager.show();
  }

  static hideFullScreenLoading() {
    return FullScreenLoadingManager.hide();
  }
}
