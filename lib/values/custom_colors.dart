import 'dart:ui';

import 'package:matcher/matcher.dart';

class CustomColors {
  Color _activePrimaryButton = const Color.fromARGB(255, 63, 81, 181);
  Color _activeSecondButton = const Color.fromARGB(226, 243, 64, 64);
  Color _topColor = const Color.fromARGB(255, 0, 75, 200);
  Color _bottomColor = const Color.fromARGB(255, 75, 175, 255);

  Color getActivePrimaryButton() {
    return _activePrimaryButton;
  }

  Color getActiveSecondButton() {
    return _activeSecondButton;
  }

  Color gettopColor() {
    return _topColor;
  }

  Color getbottomColor() {
    return _bottomColor;
  }
}
