// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla/core/utils/theme_manager.dart';
import '../../global_widgets/build_painter.dart';
import '../home_controller.dart';
import 'build_curved_line.dart';
import 'measurement_numbers.dart';
import 'build_slider_button.dart';

class BuildHumiditySlider extends StatelessWidget {
  const BuildHumiditySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) {
        return LayoutBuilder(
          builder: (context, constraintes) {
            var maxHeight = constraintes.maxHeight;
            var oneUnit = maxHeight / 100;
            var value = c.transitionalValue;
            return Row(
              children: [
                MeasurementNumbers(oneUnit, value),
                SliderHandle(oneUnit),
              ],
            );
          },
        );
      },
    );
  }
}

class SliderHandle extends StatefulWidget {
  const SliderHandle(this.oneUnit, {super.key});
  final double oneUnit;
  @override
  _SliderHandleState createState() => _SliderHandleState();
}

class _SliderHandleState extends State<SliderHandle> {
  double dy = 400;
  double diameter = ThemeManager.instance.kBallSize;

  late double _min;
  late double _max;
  late double _stepHeight;
  late void Function(double) updateTrasitionalHumidity;
  late void Function() updateFinalHumidity;

  void handleDrag(details) {
    double newDy = (details.globalPosition.dy - diameter).clamp(_min, _max);

    if (dy != newDy) {
      setState(() {
        updateTrasitionalHumidity(_calcualteHumidity(newDy));
        dy = newDy;
      });
    }
  }

  late double Function(double) _calcualteHumidity;

  @override
  void initState() {
    super.initState();
    HomeController c = Get.find();
    updateTrasitionalHumidity = c.updateTrasitionalValue;
    updateFinalHumidity = c.updateFinalValue;

    var fontSizeShift = c.kNumberFontSize / 2;

    var paddingTop = widget.oneUnit * c.paddingTopInPercentage + fontSizeShift;
    var paddingBottom = widget.oneUnit * c.paddingBottomInPercentage + fontSizeShift;
    var height = widget.oneUnit * 100;
    var body = height - paddingTop - paddingBottom;
    var stepsCount = c.list.length;
    _stepHeight = body / (stepsCount - 1);
    var disacitvatedTopPart = _stepHeight * (stepsCount - c.lastActiveIndex - 1);
    var disacitvatedBottomPart = _stepHeight * (c.firstActiveIndex);

    _calcualteHumidity = (newDy) {
      var procantage = 1 - (newDy - _min) / (_stepHeight * 5);

      var activeCapacity = c.list[c.lastActiveIndex] - c.list[c.firstActiveIndex];
      return procantage * activeCapacity + c.list[c.firstActiveIndex];
    };

    _min = disacitvatedTopPart + paddingTop;
    _max = height - disacitvatedBottomPart - paddingBottom;
  }

  @override
  Widget build(BuildContext context) {
    var centerY = dy - diameter / 2;
    return GetBuilder<HomeController>(
      builder: (c) {
        return SizedBox(
          width: 100,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 15,
                right: 40,
                child: CustomPaint(painter: BuildLinesPainter(c, centerY)),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 25,
                child: BuildCurvedLine(
                  y: centerY,
                ),
              ),
              Positioned(
                right: 0,
                top: centerY,
                child: GestureDetector(
                  onVerticalDragStart: handleDrag,
                  onVerticalDragUpdate: handleDrag,
                  onVerticalDragEnd: (_) => updateFinalHumidity(),
                  child: const BuildSliderButton(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
