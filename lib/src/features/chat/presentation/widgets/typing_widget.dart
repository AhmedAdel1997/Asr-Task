import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../config/res/assets.gen.dart';

class TypingWidget extends StatefulWidget {
  const TypingWidget({
    super.key,
  });

  @override
  State<TypingWidget> createState() => _TypingWidgetState();
}

class _TypingWidgetState extends State<TypingWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );

    _animations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    _startAnimation();
  }

  void _startAnimation() {
    _animateSequentially();
  }

  void _animateSequentially() async {
    while (mounted) {
      for (int i = 0; i < _animationControllers.length; i++) {
        if (mounted) {
          await _animationControllers[i].forward();
          await _animationControllers[i].reverse();
        }
      }
      // Small pause before the next cycle
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(1000.r),
          child: AppAssets.images.formalPhotoCropped.image(
            width: 40.w,
            height: 40.h,
            fit: BoxFit.fill,
          ),
        ),
        12.szW,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ahmed Adel',
              style: const TextStyle().setH2Medium.setWhiteColor,
            ),
            8.szH,
            Skeletonizer(
              enabled: true,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffE8ECF1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    topLeft: Radius.zero,
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                width: 90.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => AnimatedBuilder(
                      animation: _animations[index],
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -8 * _animations[index].value),
                          child: Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: const BoxDecoration(
                              color: Color(0xffC7DFFF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
