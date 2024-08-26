import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController() {
    _transitionalValue = defaultValue.toDouble();
    _finalValue = defaultValue;
  }

  final int defaultValue = 37;

  double _transitionalValue = 0;
  double get transitionalValue => _transitionalValue;

  int _finalValue = 5;
  int get finalValue => _finalValue;

  void updateTrasitionalValue(double newValue) {
    _transitionalValue = newValue;
    update();
  }

  void updateFinalValue() {
    _finalValue = _transitionalValue.round();
    update();
  }

  int firstActiveIndex = 2;
  int lastActiveIndex = 7;

  final paddingTopInPercentage = 13.3;
  final paddingBottomInPercentage = 11.2;

  final List<int> list = const [0, 10, 25, 30, 35, 40, 45, 50, 75, 100];
  double kNumberFontSize = 18;
}
