import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:flutter/material.dart';

extension FailureMapperExtension on Failure {
  String mapToStringWith(BuildContext context) =>
      '${context.translation.exception}: ${exception.toString()}';
}
