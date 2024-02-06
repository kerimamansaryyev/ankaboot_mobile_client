import 'package:flutter/material.dart';

enum AMSAPIStatus {
  newAPI,
  free,
  uncertain,
  unavailable,
}

extension AMSAPIStatusDisplayExtension on AMSAPIStatus {
  Color color() => switch (this) {
        AMSAPIStatus.newAPI => Colors.blueAccent.shade100,
        AMSAPIStatus.free => Colors.greenAccent.shade100,
        AMSAPIStatus.uncertain => Colors.amberAccent.shade100,
        AMSAPIStatus.unavailable => Colors.redAccent.shade100,
      };
}
