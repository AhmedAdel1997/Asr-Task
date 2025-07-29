import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';

import '../../config/res/color_manager.dart';

class CustomContainerWithShadow extends StatelessWidget {
  final Widget child;

  const CustomContainerWithShadow({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          10.szH,
        ],
      ),
    );
  }
}
