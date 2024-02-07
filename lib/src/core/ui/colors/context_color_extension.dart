import 'package:ankabootmobile/src/core/ui/colors/color_schema_access.dart';
import 'package:flutter/material.dart';

class _ContextColorAccess implements ColorSchemaAccess {
  final BuildContext context;

  const _ContextColorAccess(this.context);

  @override
  Color get dividerColor => Theme.of(context).colorScheme.outlineVariant;

  @override
  Color get homePageScaffoldColor => Theme.of(context).colorScheme.background;

  @override
  Color get createAMSAPIPageScaffoldColor =>
      Theme.of(context).colorScheme.background;

  @override
  Color get loaderWrapperBackgroundColor =>
      Theme.of(context).colorScheme.background;
}

extension ContextColorExtension on BuildContext {
  ColorSchemaAccess get colors => _ContextColorAccess(this);
}
