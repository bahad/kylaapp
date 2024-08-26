import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kyla/features/home_controller.dart';
import 'widget/build_humidity_info.dart';
import 'widget/build_scaffold.dart';
import 'widget/build_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) {
        return const BuildHumiditySliderScaffold(
          activeIndex: 1,
          body: HumiditySliderPage(),
        );
      },
    );
  }
}

class HumiditySliderPage extends StatelessWidget {
  const HumiditySliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 180.w,
            child: const BuildHumiditySlider(),
          ),
          const Expanded(
            child: BuildHumidityInfo(),
          ),
        ],
      ),
    );
  }
}
