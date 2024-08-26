// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kyla/core/constants/app_colors.dart';
import '../home_controller.dart';

class BuildHumidityInfo extends StatelessWidget {
  const BuildHumidityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 2),
          Container(
            height: 550.h,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RETURN TEMPERATURE',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  '20℃',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30.sp),
                ),
                const SizedBox(height: 50),
                Text(
                  'CURRENT HUMIDITY',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    AnimatedLetter(
                      letter: c.finalValue.toString()[0],
                    ),
                    AnimatedLetter(
                      letter: c.finalValue.toString()[1],
                    ),
                    SizedBox(
                      child: Text('%', style: Theme.of(context).textTheme.displayLarge),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'ABSOLUTE HUMIDITY',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  '4gr/fg3',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 42),
                Icon(
                  Icons.warning,
                  color: AppColors.yellowColor,
                  size: 24.w,
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.brightness_1,
                          size: 8.w,
                          color: AppColors.yellowColor,
                        ),
                      ),
                      TextSpan(
                        style: TextStyle(height: 1.3, fontSize: 13.sp),
                        text:
                            ' — extreme humidity level. \n Use precaution for set-points \n outside of 20%-50%',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(flex: 1),
        ],
      );
    });
  }
}

class AnimatedLetter extends StatefulWidget {
  const AnimatedLetter({super.key, required this.letter});

  final String letter;

  @override
  _AnimatedLetterState createState() => _AnimatedLetterState();
}

class _AnimatedLetterState extends State<AnimatedLetter> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late String currentLetter;
  late String prevLetter;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    currentLetter = widget.letter;
    prevLetter = widget.letter;
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedLetter oldWidget) {
    if (widget.letter != oldWidget.letter) {
      setState(() {
        prevLetter = oldWidget.letter;
        currentLetter = widget.letter;
        controller
          ..reset()
          ..forward();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return SizedBox(
            width: 45.w,
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -controller.value * 50),
                  child: Opacity(
                    opacity: 1 - controller.value,
                    child: Text(prevLetter, style: Theme.of(context).textTheme.displayLarge),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 50 - controller.value * 50),
                  child: Opacity(
                    opacity: controller.value,
                    child: Text(currentLetter, style: Theme.of(context).textTheme.displayLarge),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
