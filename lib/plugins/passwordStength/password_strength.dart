import 'package:flutter/material.dart';

import 'src/bruteforce.dart';
import 'src/common.dart';

/// Estimates the strength of a password.
/// Returns a [double] between `0.0` and `1.0`, inclusive.
/// A value of `0.0` means the given [password] is extremely weak,
/// while a value of `1.0` means it is especially strong.
double estimatePasswordStrength(String password) {
  return estimateBruteforceStrength(password) *
      estimateCommonDictionaryStrength(password);
}

Color generateColor(double strength) {
  Color color = Colors.red;
  if (strength >= 0.06 && strength <= 0.2) {
    color = Colors.orange;
  } else if (strength >= 0.21 && strength <= 0.4) {
    color = Colors.lightBlueAccent;
  } else if (strength > 0.4 && strength <= 0.6) {
    color = Colors.blue;
  } else if (strength > 0.6 && strength <= 0.8) {
    color = Colors.lightGreen;
  } else if (strength > 0.8 && strength <= 1) {
    color = Colors.green.shade700;
  } else if (strength == 0.0){
    color = Colors.white;
  }
  return color;
}
