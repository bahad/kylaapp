import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../home_screen.dart';

class BuildHumiditySliderScaffold extends StatelessWidget {
  const BuildHumiditySliderScaffold({
    super.key,
    required this.body,
    required this.activeIndex,
  });

  final Widget body;
  final int activeIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body,
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 3),
                child: IconButton(
                  iconSize: 44,
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildButton(
                      context,
                      CupertinoIcons.chart_bar,
                      const MockPage(
                        iconData: CupertinoIcons.chart_bar,
                        activeIndex: 0,
                      ),
                      isActive: activeIndex == 0,
                    ),
                    _buildButton(
                      context,
                      CupertinoIcons.drop_fill,
                      const HomeScreen(),
                      isActive: activeIndex == 1,
                    ),
                    _buildButton(
                      context,
                      CupertinoIcons.home,
                      const MockPage(
                        iconData: CupertinoIcons.chart_bar,
                        activeIndex: 2,
                      ),
                      isActive: activeIndex == 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    IconData iconData,
    Widget page, {
    bool isActive = false,
  }) {
    return IconButton(
      icon: Icon(
        iconData,
        color: isActive ? AppColors.whiteColor : AppColors.gray2,
      ),
      onPressed: () {},
    );
  }
}

class MockPage extends StatelessWidget {
  const MockPage({
    super.key,
    required this.iconData,
    required this.activeIndex,
  });

  final IconData iconData;
  final int activeIndex;
  @override
  Widget build(BuildContext context) {
    return BuildHumiditySliderScaffold(
      activeIndex: activeIndex,
      body: Container(
        alignment: Alignment.center,
        child: Icon(
          iconData,
          color: AppColors.whiteColor,
          size: 100.w,
        ),
      ),
    );
  }
}
