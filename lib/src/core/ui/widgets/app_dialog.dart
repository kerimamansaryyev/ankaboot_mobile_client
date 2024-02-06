import 'package:ankabootmobile/src/core/ui/app_layout_constraints.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  const AppDialog({
    required this.title,
    required this.content,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      actions: actions,
      content: content,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 2.gap,
      ),
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 1.25.gap,
      ).copyWith(
        top: 1.25.gap,
        bottom: 1.gap,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.symmetric(
        vertical: 0.5.gap,
        horizontal: 1.25.gap,
      ),
    );
  }
}
