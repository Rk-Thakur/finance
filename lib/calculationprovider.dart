import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calculationprovider =
    ChangeNotifierProvider((ref) => CalculationProvider());

class CalculationProvider extends ChangeNotifier {
  double calculatedValue = 0.0;
  void calculation(
      {required double interest,
      required double year,
      required String type}) async {
    switch (type) {
      case 'PVIF':
        double pv = (1 / pow(1 + (interest / 100), year)).toDouble();
        calculatedValue = pv;
        notifyListeners();
        break;
      case 'PVIFA':
        double pva =
            ((1 - 1 / pow(1 + (interest / 100), year)) / (interest / 100))
                .toDouble();
        calculatedValue = pva;
        notifyListeners();
        break;
      case 'FVIF':
        double fv = pow(1 + (interest / 100), year).toDouble();
        calculatedValue = fv;
        notifyListeners();
        break;
      case 'FVIFA':
        double fva = (pow(1 + (interest / 100), year) - 1) / (interest / 100);
        calculatedValue = fva;
        notifyListeners();
        break;
      default:
    }
  }
}
