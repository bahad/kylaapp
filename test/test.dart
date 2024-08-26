import 'package:flutter_test/flutter_test.dart';
import 'package:kyla/features/home_controller.dart';

void main() {
  group('HomeController Tests', () {
    late HomeController controller;

    setUp(() {
      controller = HomeController();
    });

    test('Initial values are correct', () {
      expect(controller.transitionalValue, controller.defaultValue.toDouble());
      expect(controller.finalValue, 5);
    });

    test('updateTrasitionalValue updates transitionalValue', () {
      controller.updateTrasitionalValue(50.0);
      expect(controller.transitionalValue, 50.0);
    });

    test('updateFinalValue updates finalValue based on transitionalValue', () {
      controller.updateTrasitionalValue(45.7);
      controller.updateFinalValue();
      expect(controller.finalValue, 46);
    });
  });
}
