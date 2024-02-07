import 'package:flutter/material.dart';

enum AMSAPIStatus {
  free,
  uncertain,
  unavailable,
  unknown;

  static final _stringMapped = {
    free.name: free,
    uncertain.name: uncertain,
    unavailable.name: unavailable,
  };

  static final displayValues = <AMSAPIStatus>{
    free,
    uncertain,
    unavailable,
  };

  factory AMSAPIStatus.fromString(String statusName) =>
      _stringMapped[statusName.toLowerCase()] ?? unknown;
}

extension AMSAPIStatusDisplayExtension on AMSAPIStatus {
  Color color() => switch (this) {
        AMSAPIStatus.free => Colors.greenAccent.shade100,
        AMSAPIStatus.uncertain => Colors.amberAccent.shade100,
        AMSAPIStatus.unavailable => Colors.redAccent.shade100,
        AMSAPIStatus.unknown => Colors.grey.shade100,
      };
}
