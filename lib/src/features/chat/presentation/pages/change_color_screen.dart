import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/res/color_manager.dart';
import '../../../../core/navigation/navigator.dart';
import '../widgets/change_color_widget.dart';

class ChangeColorScreen extends StatelessWidget {
  const ChangeColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 64.h,
        title: Text(
          'Change Color',
          style: const TextStyle().setH1SemiBold,
        ),
        leading: IconButton(
          onPressed: () {
            Go.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.gradient,
            ),
          ),
        ),
      ),
      body: const ChangeColorWidget(),
    );
  }
}
