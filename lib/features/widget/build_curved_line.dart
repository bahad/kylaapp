import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kyla/core/constants/app_colors.dart';

import '../../global_widgets/build_clipper.dart';

class BuildCurvedLine extends StatelessWidget {
  const BuildCurvedLine({super.key, required this.y});

  final double y;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BuildCurvedClipper(y),
      child: Container(
        width: 41.w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: [
              AppColors.primaryColor,
              AppColors.firstSliderGradient,
              AppColors.firstSliderGradient,
              AppColors.secondSliderGradient,
              AppColors.secondSliderGradient,
              AppColors.firstSliderGradient,
              AppColors.firstSliderGradient,
              AppColors.primaryColor,
            ],
            stops: [0.01, 0.1, 0.25, 0.37, 0.66, 0.78, 0.9, 0.99],
          ),
        ),
      ),
    );
  }
}
