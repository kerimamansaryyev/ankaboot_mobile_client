import 'package:flutter/cupertino.dart';

extension DoubleLayoutSizeExtension on num {
  double get gap => this * AppLayoutConstraints.gapSize;

  SizedBox get hBox => SizedBox(
        height: this * AppLayoutConstraints.gapSize,
      );

  SizedBox get wBox => SizedBox(
        width: this * AppLayoutConstraints.gapSize,
      );
}

abstract final class AppLayoutConstraints {
  static const double gapSize = 16;
}
