// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../home_controller.dart';

class MeasurementNumbers extends StatefulWidget {
  const MeasurementNumbers(this.oneUnit, this.value, {super.key});

  final double oneUnit;
  final double value;

  @override
  _MeasurementNumbersState createState() => _MeasurementNumbersState();
}

class _MeasurementNumbersState extends State<MeasurementNumbers> {
  late int activeIndex;

  @override
  void initState() {
    super.initState();

    var initValue = widget.value;

    activeIndex = findNearestIndex(initValue);
  }

  int findNearestIndex(double value) {
    HomeController c = Get.find();
    var a = [...c.list.reversed]..sort((a, b) => (a - value).abs().compareTo((b - value).abs()));
    return c.list.length - c.list.indexOf(a.first) - 1;
  }

  @override
  void didUpdateWidget(MeasurementNumbers oldWidget) {
    HomeController c = Get.find();
    var oldActiveValue = c.list.reversed.toList()[activeIndex];

    var delta = (widget.value - oldActiveValue).abs().round();

    if (delta >= 5) {
      activeIndex = findNearestIndex(widget.value);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: c.paddingTopInPercentage * widget.oneUnit,
              child: Text(c.transitionalValue.toStringAsFixed(3)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildNumbers(c.list, c.firstActiveIndex, c.lastActiveIndex),
              ),
            ),
            SizedBox(height: c.paddingBottomInPercentage * widget.oneUnit),
          ],
        ),
      );
    });
  }

  List<Widget> _buildNumbers(List list, int firstIndex, int lastIndex) {
    return list.reversed
        .toList()
        .asMap()
        .map((i, n) => MapEntry(
              i,
              Row(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 6,
                    color: n <= list[firstIndex] || n >= list[lastIndex]
                        ? AppColors.yellowColor
                        : Colors.transparent,
                  ),
                  AnimatedText(
                    key: ValueKey(n),
                    notActiveNumber: n,
                    activeValue: widget.value,
                    isActive: i == activeIndex,
                    oneUnit: widget.oneUnit,
                  ),
                ],
              ),
            ))
        .values
        .toList();
  }
}

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    super.key,
    required this.notActiveNumber,
    required this.activeValue,
    required this.isActive,
    required this.oneUnit,
  });

  final int notActiveNumber;
  final double activeValue;
  final double oneUnit;
  final bool isActive;

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late ColorTween? colorTween;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    colorTween = ColorTween(begin: AppColors.whiteColor, end: AppColors.secondSliderGradient);
    if (widget.isActive) {
      controller?.forward();
    }
    super.initState();
  }

  late bool? isGoingUp;

  @override
  void didUpdateWidget(AnimatedText oldWidget) {
    if (widget.isActive && !oldWidget.isActive) {
      controller?.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      isGoingUp = widget.activeValue > widget.notActiveNumber;
      controller?.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return const SizedBox();
    } else {
      return GetBuilder<HomeController>(builder: (c) {
        return AnimatedBuilder(
          animation: controller!,
          builder: (_, __) {
            String text;
            Offset offset;

            if (controller!.isAnimating && controller!.status == AnimationStatus.reverse) {
              var number = widget.notActiveNumber + (controller!.value.round() * 5 * (isGoingUp! ? -1 : 1));
              text = ' $number%';
              var dy = controller!.value * 5 * (isGoingUp! ? -1 : 1) * widget.oneUnit;
              offset = Offset(0, dy);
            } else {
              if (widget.isActive) {
                text = ' ${widget.activeValue.round()}%';
                var dy = (widget.notActiveNumber - widget.activeValue) * widget.oneUnit;
                offset = Offset(0, dy);
              } else {
                text = ' ${widget.notActiveNumber}%';
                offset = Offset.zero;
              }
            }

            return Transform.scale(
              alignment: Alignment.centerLeft,
              scale: 1 + (0.4 * controller!.value),
              child: Transform.translate(
                offset: offset,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: c.kNumberFontSize,
                    fontWeight: FontWeight.w900,
                    height: 1,
                    color: colorTween?.evaluate(controller!),
                  ),
                ),
              ),
            );
          },
        );
      });
    }
  }
}
