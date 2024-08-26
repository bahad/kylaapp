import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kyla/core/utils/theme_manager.dart';
import '../../core/constants/app_colors.dart';

class BuildSliderButton extends StatelessWidget {
  const BuildSliderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.whiteColor,
      ),
      height: ThemeManager.instance.kBallSize,
      width: ThemeManager.instance.kBallSize,
      alignment: Alignment.center,
      child: Icon(
        Icons.crop_rotate,
        color: AppColors.gray2,
        size: 24.w,
      ),
    );
  }
}
